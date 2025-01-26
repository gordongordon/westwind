import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:westwind_client/westwind_client.dart';

import 'data.dart';

import 'invoice.dart';

/*
const pdfGenerators = <PdfGenerator>[
 // Example('RÉSUMÉ', 'resume.dart', generateResume),
 // Example('DOCUMENT', 'document.dart', generateDocument),
  PdfGenerator('INVOICE', 'invoice.dart', generateInvoice),
 // Example('REPORT', 'report.dart', generateReport),
 // Example('CALENDAR', 'calendar.dart', generateCalendar),
 // Example('CERTIFICATE', 'certificate.dart', generateCertificate, true),
];
*/


typedef LayoutCallbackWithData = Future<Uint8List> Function(PdfPageFormat pageFormat, CustomData data, List<RoomTransaction> roomTransactioins);

class PdfGenerator {
  const PdfGenerator(this.name, this.file, this.builder, this.roomTransactions, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;

  final List<RoomTransaction> roomTransactions;
}
