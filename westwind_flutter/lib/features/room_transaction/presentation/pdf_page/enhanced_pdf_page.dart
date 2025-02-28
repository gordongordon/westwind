import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/data.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/enhanced_pdf_generator.dart';

/// An enhanced template for PDF generation with column overflow support
class EnhancedPdfPage<T> extends StatefulWidget {
  final List<T>? entities;
  final String title;
  final Future<List<T>> Function()? fetchData;
  final List<EnhancedPdfContentConfig<T>> templates;
  final bool needsNotes;
  
  // New parameters for column overflow
  final bool defaultEnableColumnOverflow;
  final int defaultColumnCount;
  final bool defaultFillColumnVertically;

  const EnhancedPdfPage({
    super.key,
    this.entities,
    required this.title,
    this.fetchData,
    required this.templates,
    this.needsNotes = false,
    this.defaultEnableColumnOverflow = false,
    this.defaultColumnCount = 1,
    this.defaultFillColumnVertically = true, // Default to vertical filling
  });

  @override
  EnhancedPdfPageState<T> createState() => EnhancedPdfPageState<T>();
}

class EnhancedPdfPageState<T> extends State<EnhancedPdfPage<T>> with SingleTickerProviderStateMixin {
  int _tab = 0;
  TabController? _tabController;
  PrintingInfo? printingInfo;
  List<T>? _entities;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  
  var _data = const CustomData();
  var _hasData = false;
  var _pending = false;
  
  // Column overflow state
  bool _enableColumnOverflow = false;
  int _columnCount = 2;
  bool _fillColumnVertically = true; // Track vertical/horizontal filling

  @override
  void initState() {
    super.initState();
    
    // Initialize column overflow settings from widget defaults
    _enableColumnOverflow = widget.defaultEnableColumnOverflow;
    _columnCount = widget.defaultColumnCount;
    _fillColumnVertically = widget.defaultFillColumnVertically;
    
    _initializeData();
  }
  
  Future<void> _initializeData() async {
    // If entities were provided directly, use them
    if (widget.entities != null) {
      setState(() {
        _entities = widget.entities;
      });
      _initTabController();
      return;
    }
    
    // Otherwise, fetch data
    if (widget.fetchData != null) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        final data = await widget.fetchData!();
        setState(() {
          _entities = data;
          _isLoading = false;
        });
        _initTabController();
      } catch (e) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }
  
  Future<void> _initTabController() async {
    final info = await Printing.info();

    _tabController = TabController(
      vsync: this,
      length: widget.templates.length,
      initialIndex: _tab,
    );

    _tabController!.addListener(() {
      if (_tab != _tabController!.index) {
        setState(() {
          _tab = _tabController!.index;
        });
      }
      
      if (widget.needsNotes && !_hasData && !_pending) {
        _pending = true;
        _askForNotes(context).then((value) {
          if (value != null) {
            setState(() {
              _data = CustomData(message: value);
              _hasData = true;
              _pending = false;
            });
          } else {
            setState(() {
              _pending = false;
            });
          }
        });
      }
    });

    setState(() {
      printingInfo = info;
    });
    
    // Check if we need to ask for notes
    if (widget.needsNotes && !_hasData && !_pending) {
      _pending = true;
      _askForNotes(context).then((value) {
        if (value != null) {
          setState(() {
            _data = CustomData(message: value);
            _hasData = true;
            _pending = false;
          });
        } else {
          setState(() {
            _pending = false;
          });
        }
      });
    }
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  Future<String?> _askForNotes(BuildContext context) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Please enter notes for the document:'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: TextField(
            decoration: const InputDecoration(hintText: '[your notes]'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text.isEmpty ? '[No notes provided]' : controller.text);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: _tabController != null && widget.templates.length > 1
            ? TabBar(
                controller: _tabController,
                tabs: widget.templates.map<Tab>((e) => Tab(text: e.subtitle)).toList(),
                isScrollable: true,
              )
            : null,
        actions: [
          // Add column layout toggle button
          IconButton(
            icon: Icon(_enableColumnOverflow ? Icons.view_column : Icons.table_rows),
            onPressed: () {
              setState(() {
                _enableColumnOverflow = !_enableColumnOverflow;
              });
            },
            tooltip: _enableColumnOverflow ? 'Multi-column mode' : 'Single column mode',
          ),
          // Add fill direction toggle when multi-column is enabled
          if (_enableColumnOverflow)
            IconButton(
              icon: Icon(_fillColumnVertically ? Icons.vertical_split : Icons.horizontal_split),
              onPressed: () {
                setState(() {
                  _fillColumnVertically = !_fillColumnVertically;
                });
              },
              tooltip: _fillColumnVertically ? 'Fill columns vertically' : 'Distribute rows evenly',
            ),
          // Add column count selector when multi-column is enabled
          if (_enableColumnOverflow)
            PopupMenuButton<int>(
              icon: const Icon(Icons.more_vert),
              tooltip: 'Column count',
              onSelected: (int count) {
                setState(() {
                  _columnCount = count;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('2 columns'),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text('3 columns'),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text('4 columns'),
                ),
              ],
            ),
        ],
      ),
      body: _buildBody(actions),
    );
  }
  
  Widget _buildBody(List<PdfPreviewAction> actions) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_errorMessage'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    if (_entities == null || _entities!.isEmpty) {
      return const Center(child: Text('No data available'));
    }
    
    if (_tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (!_hasData && widget.needsNotes) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please provide notes to continue'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _askForNotes(context).then((value) {
                  if (value != null) {
                    setState(() {
                      _data = CustomData(message: value);
                      _hasData = true;
                    });
                  }
                });
              },
              child: const Text('Add Notes'),
            ),
          ],
        ),
      );
    }
    
    // Get the current template and update its column overflow settings
    final currentTemplate = widget.templates[_tab];
    final updatedTemplate = EnhancedPdfContentConfig<T>(
      title: currentTemplate.title,
      subtitle: currentTemplate.subtitle,
      documentName: currentTemplate.documentName,
      tableHeaders: currentTemplate.tableHeaders,
      columnAlignments: currentTemplate.columnAlignments,
      getHeaderData: currentTemplate.getHeaderData,
      getRowData: currentTemplate.getRowData,
      calculateSummary: currentTemplate.calculateSummary,
      baseColor: currentTemplate.baseColor,
      accentColor: currentTemplate.accentColor,
      paymentInfo: currentTemplate.paymentInfo,
      footerText: currentTemplate.footerText,
      // Apply current column overflow settings
      enableColumnOverflow: _enableColumnOverflow,
      columnCount: _columnCount,
      fillColumnVertically: _fillColumnVertically, // Apply current fill direction
    );
    
    return PdfPreview(
      maxPageWidth: 700,
      build: (format) => EnhancedPdfGenerator.generatePdf<T>(
        pageFormat: format,
        entities: _entities!,
        config: updatedTemplate,
        notes: _data.message,
      ),
      actions: actions,
      onPrinted: _showPrintedToast,
      onShared: _showSharedToast,
    );
  }
}