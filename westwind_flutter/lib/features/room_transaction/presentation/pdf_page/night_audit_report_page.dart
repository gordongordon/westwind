import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_guest_transactions/room_guest_transactions_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/generic_pdf_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/pdf_templates.dart';

//import 'package:url_launcher/url_launcher.dart' as ul;
class NightAuditReportPage extends StatefulWidget {
  final int? roomGuestId;
  static String route([int? roomGuestId]) =>
      "/report/nightaudit/${roomGuestId ?? ':id'}";
  static String routeNew() => "/report/nightaudit/new";

  const NightAuditReportPage({super.key, this.roomGuestId});

  @override
  NightAuditReportPageState createState() => NightAuditReportPageState();
}

class NightAuditReportPageState extends State<NightAuditReportPage> {


  @override
  void initState() {
    super.initState();

    // context.read<RoomGuestTransactionsBloc>().add(
    //    FetchRoomGuestTransactions(163));


    context.read<RoomTransactionBloc>().add(FetchRoomTransactionsByDayEvent(
        day: TimeManager.instance.today().subtract(Duration(days: 0))));
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomTransactionBloc, RoomTransactionState>(
      builder: (context, state) {
        if (state is RoomTransactionListByDayStateLoaded) {
          return GenericPdfPage<RoomTransaction>(
            title: 'Night Audit Report ',
            entities: state.roomTransactions,
            templates: [
              PdfTemplates.getRoomTransactionInvoiceConfig(),
              PdfTemplates.getNightAuditConfig(),
            ],
            needsNotes: false, // Set to true if notes are needed
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Your Night Audit Report')),
          body: state is RoomGuestTransactionsLoading
              ? const Center(child: CircularProgressIndicator())
              : const Center(child: Text('Failed to load data')),
        );
      },
    );
  }
}
