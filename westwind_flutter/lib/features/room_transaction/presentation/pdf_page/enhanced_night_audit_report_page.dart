import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/enhanced_pdf_generator.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/enhanced_pdf_page.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/enhanced_pdf_templates.dart';

/// Enhanced Night Audit Report Page with multi-column support
class EnhancedNightAuditReportPage extends StatefulWidget {
  final int? roomGuestId;
  static String route([int? roomGuestId]) =>
      "/report/enhanced-nightaudit/${roomGuestId ?? ':id'}";
  static String routeNew() => "/report/enhanced-nightaudit/new";

  const EnhancedNightAuditReportPage({super.key, this.roomGuestId});

  @override
  EnhancedNightAuditReportPageState createState() => EnhancedNightAuditReportPageState();
}

class EnhancedNightAuditReportPageState extends State<EnhancedNightAuditReportPage> {
  @override
  void initState() {
    super.initState();

    // Fetch room transactions for today
    context.read<RoomTransactionBloc>().add(FetchRoomTransactionsByDayEvent(
        day: TimeManager.instance.today()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomTransactionBloc, RoomTransactionState>(
      builder: (context, state) {
        if (state is RoomTransactionListByDayStateLoaded) {
          return EnhancedPdfPage<RoomTransaction>(
            title: 'Enhanced Night Audit Report',
            entities: state.roomTransactions,
            templates: [
              // Use our enhanced templates with multi-column support
              EnhancedPdfTemplates.getNightAuditConfig(),
            ],
            needsNotes: false,
            // Default to multi-column mode
        //    defaultEnableColumnOverflow: true,
        //    defaultColumnCount: 2,
        //    defaultFillColumnVertically: false,
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Enhanced Night Audit Report')),
          body: state is RoomTransactionListByDayStateLoaded
              ? const Center(child: CircularProgressIndicator())
              : const Center(child: Text('Failed to load data')),
        );
      },
    );
  }
}