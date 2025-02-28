import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_guest_transactions/room_guest_transactions_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/enhanced_pdf_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/enhanced_pdf_templates.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/generic_pdf_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/pdf_templates.dart';

//import 'package:url_launcher/url_launcher.dart' as ul;
class EnhancedInvoiceReportPage extends StatefulWidget {
  final int? roomGuestId;
  static String route([int? roomGuestId]) =>
      "/report/roomGuestInvoice/${roomGuestId ?? ':id'}";
  static String routeNew() => "/report/new";

  const EnhancedInvoiceReportPage({super.key, this.roomGuestId});

  @override
  EnhancedInvoiceReportPageState createState() => EnhancedInvoiceReportPageState();
}

class EnhancedInvoiceReportPageState extends State<EnhancedInvoiceReportPage> {


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
        FetchRoomGuestTransactionsOrderDescending(242));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomGuestTransactionsBloc, RoomGuestTransactionsState>(
      builder: (context, state) {
        if (state is RoomGuestTransactionsLoaded) {
          return EnhancedPdfPage<RoomTransaction>(
            title: 'Invoice (Room Guest Transactioin) ',
            entities: state.transactions,
            templates: [
                EnhancedPdfTemplates.getRoomTransactionInvoiceConfig(),
             // PdfTemplates.getNightAuditConfig(),
            ],
            needsNotes: false, // Set to true if notes are needed
            defaultColumnCount: 2,
            defaultEnableColumnOverflow: true,
            defaultFillColumnVertically: false,
            
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
