/*
 * Copyright (C) 2017, David PHAM-VAN <dev.nfet.net@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_guest_transactions/room_guest_transactions_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/data.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/invoice.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/invoice_with_all_transactions.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/pdf_generator.dart';

//import 'package:url_launcher/url_launcher.dart' as ul;
class PdfEditPage extends StatefulWidget {
  final int? roomGuestId;
  static String route([int? roomGuestId]) =>
      "/pdfEdit/roomGuestInvoice/${roomGuestId ?? ':id'}";
  static String routeNew() => "/pdfEdit/new";

  const PdfEditPage({super.key, this.roomGuestId});

  @override
  PdfEditPageState createState() => PdfEditPageState();
}

class PdfEditPageState extends State<PdfEditPage>
    with SingleTickerProviderStateMixin {
  int _tab = 0;
  TabController? _tabController;
  PrintingInfo? printingInfo;
  var _roomTransactions;


  var _data = const CustomData();
  var _hasData = false;
  var _pending = false;

  List<PdfGenerator> pdfGenerators = [];

  @override
  void initState() {
    super.initState();
/*
    context.read<RoomTransactionBloc>().add(FetchRoomTransactionsByDayEvent(
        day: TimeManager.instance.toServer(
            TimeManager.instance.today().subtract(Duration(days: 1)))));
*/
    // First fetch the data
    if (widget.roomGuestId != null) {
      context.read<RoomGuestTransactionsBloc>().add(
//         RetrieveRoomTransactionWithOutLaundryEvent( widget.roomGuestId!));
           FetchRoomGuestTransactionsOrderDescending(widget.roomGuestId!, TransactionType.pay));


   //   context
   //       .read<RoomGuestTransactionsBloc>()
   //       .add(FetchRoomGuestTransactions(widget.roomGuestId!));
      //! we mayn't need this
      //  context
      //           .read<RoomTransactionBloc>()
      //           .add(RetrieveRoomGuestEvent(roomGuestId: widget.roomGuestId!));
    }

/*
    context.read<RoomTransactionBloc>().stream.listen((state) {
      if (state is RoomTransactionListByDayStateLoaded) {
    //    _roomTransactions =   state.roomTransactions;

        pdfGenerators.add(
          PdfGenerator(
            'Today Transactions',
            'invoice.dart',
            (format, data, transactions) async {
              return await generateInvoiceWithAllTransactions(
                  format, data, transactions);
            },
            state.roomTransactions,
            true,
          ),
        );
        _init();
      }
    });
    */

    
    // Listen to the bloc state changes
    context.read<RoomGuestTransactionsBloc>().stream.listen((state) {
      if (state is RoomGuestTransactionsLoaded) {
        // Initialize PdfGenerators once we have the data

        final result = state.transactions;
        /*
        final result = state.transactions
            .where((item) => item.itemType != ItemType.laundry)
            .toList();*/

        pdfGenerators = <PdfGenerator>[
          PdfGenerator(
            'INVOICE (Room only) - RoomGuest ID ${widget.roomGuestId!}',
            'invoice.dart',
            (format, data, transactions) async {
              return await generateInvoice(format, data, result);
            },
            result,
            true,
          ),
          PdfGenerator(
            'INVOICE (All Transactions)- RoomGuest ID ${widget.roomGuestId!}',
            'invoice.dart',
            (format, data, transactions) async {
              return await generateInvoiceWithAllTransactions(
                  format, data, transactions);
            },
            state.transactions,
            true,
          ),
        ];

        // Then initialize other components that depend on pdfGenerators
        _init();
        _checkIfNameNeeded(); // Add this lin
      }
    });
    
  }

  Future<void> _init() async {
    final info = await Printing.info();

    _tabController = TabController(
      vsync: this,
      length: pdfGenerators.length,
      initialIndex: _tab,
    );

    _tabController!.addListener(() {
      if (_tab != _tabController!.index) {
        setState(() {
          _tab = _tabController!.index;
        });
      }
      if (pdfGenerators[_tab].needsData && !_hasData && !_pending) {
        _pending = true;
        askName(context).then((value) {
          if (value != null) {
            setState(() {
              _data = CustomData(message: value);
              _hasData = true;
              _pending = false;
            });
          }
        });
      }
    });

    setState(() {
      printingInfo = info;
    });
  }

  void _setupTabController(List<PdfGenerator> generators) {
    _tabController = TabController(
      vsync: this,
      length: generators.length,
      initialIndex: _tab,
    );
    _tabController!.addListener(() {
      if (_tab != _tabController!.index) {
        setState(() {
          _tab = _tabController!.index;
        });
      }
      if (generators[_tab].needsData && !_hasData && !_pending) {
        _pending = true;
        askName(context).then((value) {
          if (value != null) {
            setState(() {
              _data = CustomData(message: value);
              _hasData = true;
              _pending = false;
            });
          }
        });
      }
    });
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

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Westwind PDF Demo'),
        bottom: _tabController != null
            ? TabBar(
                controller: _tabController,
                tabs: pdfGenerators.map<Tab>((e) => Tab(text: e.name)).toList(),
                isScrollable: true,
              )
            : null,
      ),
      body: BlocBuilder<RoomGuestTransactionsBloc, RoomGuestTransactionsState>(
        builder: (context, state) {
          if (state is RoomGuestTransactionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomGuestTransactionsLoaded) {
          // final _roomTransactions = state.transactions;
/*
            // Only set up generators and tab controller once
            if (pdfGenerators.isEmpty) {
              pdfGenerators = <PdfGenerator>[
                PdfGenerator(
                  'INVOICE - RoomGuest ID ${widget.roomGuestId!} ',
                  'invoice.dart',
                  //  generateInvoice,
                  (format, data, transactions) async {
                    // This matches the typedef LayoutCallbackWithData
                    return await generateInvoice(format, data, transactions);
                  },
                  roomTransactions,
                  true,
                ),
              ];
              _setupTabController(pdfGenerators);
            }
*/


            return _tabController != null
                ? PdfPreview(
                    maxPageWidth: 700,
                    build: (format) => pdfGenerators[_tab]
                        .builder(format, _data, state.transactions),
                    actions: actions,
                    onPrinted: _showPrintedToast,
                    onShared: _showSharedToast,
                  )
                : const Center(child: CircularProgressIndicator());
                
                
               // return Center(child: Text( 'wrong transACTIOIN'));
             
          } else if (state is RoomGuestTransactionsFailure) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No transactions found'));
          }
        },
      ),
    );
  }

  void _checkIfNameNeeded() {
    if (pdfGenerators.isNotEmpty &&
        pdfGenerators[_tab].needsData &&
        !_hasData &&
        !_pending) {
      _pending = true;
      askName(context).then((value) {
        if (value != null) {
          setState(() {
            _data = CustomData(message: value);
            _hasData = true;
            _pending = false;
          });
        }
      });
    }
  }

  Future<String?> askName(BuildContext context) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Please type note or PO into invoice:'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: TextField(
            decoration: const InputDecoration(hintText: '[your notes]'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  Navigator.pop(context, controller.text);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
