import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_guest_transactions/room_guest_transactions_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/generic_pdf_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/pdf_templates.dart';

//import 'package:url_launcher/url_launcher.dart' as ul;
class InvoiceReportReportPage extends StatefulWidget {
  final int? roomGuestId;
  static String route([int? roomGuestId]) =>
      "/report/roomGuestInvoice/${roomGuestId ?? ':id'}";
  static String routeNew() => "/report/new";

  const InvoiceReportReportPage({super.key, this.roomGuestId});

  @override
  InvoiceReportReportPageState createState() => InvoiceReportReportPageState();
}


class InvoiceReportReportPageState  extends State<InvoiceReportReportPage>  {
  // static String route() => "/reports/room-tranasaction-report";


//  static String route([int? roomGuestId]) =>
//      "/report/roomGuestInvoice/${roomGuestId ?? ':id'}";
//  static String routeNew() => "/pdfEdit/new";

  
//  @override
//  Widget build(BuildContext context) {


  @override
  void initState() {
    super.initState();
/*
    context.read<RoomTransactionBloc>().add(FetchRoomTransactionsByDayEvent(
        day: TimeManager.instance.toServer(
            TimeManager.instance.today().subtract(Duration(days: 1)))));
*/
    // First fetch the data
   // if (widget.roomGuestId != null) {
      context.read<RoomGuestTransactionsBloc>().add(
//         RetrieveRoomTransactionWithOutLaundryEvent( widget.roomGuestId!));
           FetchRoomGuestTransactions(163));
    }


@override
Widget build(BuildContext context) {
  return BlocBuilder<RoomGuestTransactionsBloc, RoomGuestTransactionsState>(
    builder: (context, state) {
      if (state is RoomGuestTransactionsLoaded) {
        return GenericPdfPage<RoomTransaction>(
          title: 'Your Report Title',
          entities: state.transactions,
          templates: [
            PdfTemplates.getRoomTransactionInvoiceConfig(),
          ],
          needsNotes: true, // Set to true if notes are needed
        );
      }

      return Scaffold(
        appBar: AppBar(title: const Text('Your Report')),
        body: state is RoomGuestTransactionsLoading
            ? const Center(child: CircularProgressIndicator())
            : const Center(child: Text('Failed to load data')),
      );
    },
  );
}

/*
    return BlocProvider(
       create: (context) => context.read<RoomGuestTransactionsBloc>()..add(FetchRoomGuestTransactions(100)),
    //  create: (context) => RoomGuestTransactionsBloc()..add(FetchRoomGuestTransactions(100)),

// create: (context) => RoomGuestTransactionsBloc(repository: context.read<>())


      child: BlocBuilder<RoomGuestTransactionsBloc, RoomGuestTransactionsState>(
        builder: (context, state) {
          if (state is  RoomGuestTransactionsLoaded) {
            return GenericPdfPage<RoomTransaction>(
              title: 'Your Report Title',
              entities: state.transactions,
              templates: [
                PdfTemplates.getRoomTransactionInvoiceConfig(),
              ],
              needsNotes: false, // Set to true if notes are needed
            );
          }
          
          return Scaffold(
            appBar: AppBar(title: const Text('Your Report')),
            body: state is  RoomGuestTransactionsLoading
                ? const Center(child: CircularProgressIndicator())
                : const Center(child: Text('Failed to load data')),
          );
        },
      ),
    );
  }
*/  
}

