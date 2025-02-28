import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/data.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/generic_pdf_generator.dart';

/// A generic template for PDF generation based on entity type
class GenericPdfPage<T> extends StatefulWidget {
  final List<T>? entities;
  final String title;
  final Future<List<T>> Function()? fetchData;
  final List<PdfContentConfig<T>> templates;
  final bool needsNotes;

  const GenericPdfPage({
    Key? key,
    this.entities,
    required this.title,
    this.fetchData,
    required this.templates,
    this.needsNotes = true,
  }) : super(key: key);

  @override
  GenericPdfPageState<T> createState() => GenericPdfPageState<T>();
}

class GenericPdfPageState<T> extends State<GenericPdfPage<T>> with SingleTickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
    
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
    
    return PdfPreview(
      maxPageWidth: 700,
      build: (format) => GenericPdfGenerator.generatePdf<T>(
        pageFormat: format,
        entities: _entities!,
        config: widget.templates[_tab],
        notes: _data.message,
      ),
      actions: actions,
      onPrinted: _showPrintedToast,
      onShared: _showSharedToast,
    );
  }
}