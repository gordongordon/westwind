import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_guest_transactions/room_guest_transactions_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/generic_pdf_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/pdf_templates.dart';

//import 'package:url_launcher/url_launcher.dart' as ul;
class InvoiceReportPage extends StatefulWidget {
  final int? roomGuestId;
  static String route([int? roomGuestId]) =>
      "/report/roomGuestInvoice/${roomGuestId ?? ':id'}";
  static String routeNew() => "/report/new";

  const InvoiceReportPage({super.key, this.roomGuestId});

  @override
  InvoiceReportPageState createState() => InvoiceReportPageState();
}

class InvoiceReportPageState extends State<InvoiceReportPage> {


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
        FetchRoomGuestTransactionsOrderDescending(163, null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomGuestTransactionsBloc, RoomGuestTransactionsState>(
      builder: (context, state) {
        if (state is RoomGuestTransactionsLoaded) {
          return GenericPdfPage<RoomTransaction>(
            title: 'Invoice (Room Guest Transactioin) ',
            entities: state.transactions,
            templates: [
              PdfTemplates.getRoomTransactionInvoiceConfig(),
              PdfTemplates.getNightAuditConfig(),
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
}
