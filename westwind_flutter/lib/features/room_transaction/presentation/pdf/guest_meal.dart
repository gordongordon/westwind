import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';

/// Generates a PDF report showing all checked-in room guests
/// organized in two columns with room numbers and guest names
Future<Uint8List> generateRoomOccupancyReport(
  PdfPageFormat pageFormat,
  List<RoomGuest> roomGuests,
) async {
  // Filter only checked-in room guests
  final checkedInGuests = roomGuests.where((guest) => !guest.isCheckOut).toList();
  
  // Sort by room ID for consistent display
  checkedInGuests.sort((a, b) => a.roomId.compareTo(b.roomId));
  
  // Group room guests by room ID
  final Map<int, List<RoomGuest>> guestsByRoom = {};
  for (var guest in checkedInGuests) {
    if (!guestsByRoom.containsKey(guest.roomId)) {
      guestsByRoom[guest.roomId] = [];
    }
    guestsByRoom[guest.roomId]!.add(guest);
  }
  
  // Create a report object
  final report = RoomOccupancyReport(
    title: "Room Occupancy Report",
    generatedDate: TimeManager.instance.today(),
    guestsByRoom: guestsByRoom,
    baseColor: PdfColors.blue800,
    accentColor: PdfColors.blue500,
  );

  // Build and return the PDF
  return await report.buildPdf(pageFormat);
}

class RoomOccupancyReport {
  RoomOccupancyReport({
    required this.title,
    required this.generatedDate,
    required this.guestsByRoom,
    required this.baseColor,
    required this.accentColor,
  });

  final String title;
  final DateTime generatedDate;
  final Map<int, List<RoomGuest>> guestsByRoom;
  final PdfColor baseColor;
  final PdfColor accentColor;

  String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document
    final doc = pw.Document();

    // Load background shape
    _bgShape = await rootBundle.loadString('assets/invoice.svg');

    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
        ),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => [
          _buildTitle(context),
          _buildRoomOccupancyTable(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              children: [
                pw.Container(
                  height: 40,
                  padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    'Westwind Motor Inn',
                    style: pw.TextStyle(
                      color: baseColor,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            width: 150,
            height: 40,
            alignment: pw.Alignment.centerRight,
            padding: const pw.EdgeInsets.only(right: 20),
            child: pw.Text(
              'Date: ${_formatDate(generatedDate)}',
              style: pw.TextStyle(
                color: baseColor,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 10),
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        'Page ${context.pageNumber}/${context.pagesCount}',
        style: pw.TextStyle(
          fontSize: 10,
          color: PdfColors.black,
        ),
      ),
    );
  }

  pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat,
    pw.Font base,
    pw.Font bold,
    pw.Font italic,
  ) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: _bgShape != null ? pw.SvgImage(svg: _bgShape!) : pw.Container(),
      ),
    );
  }

  pw.Widget _buildTitle(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 20),
      alignment: pw.Alignment.center,
      child: pw.Text(
        title,
        style: pw.TextStyle(
          color: baseColor,
          fontWeight: pw.FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  pw.Widget _buildRoomOccupancyTable(pw.Context context) {
    // Get list of room IDs sorted
    final roomIds = guestsByRoom.keys.toList()..sort();
    
    // Calculate split point for the two columns (half of the rooms)
    final int midpoint = (roomIds.length / 2).ceil();
    
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // First column (rooms 1 to midpoint)
          pw.Expanded(
            child: _buildRoomColumn(roomIds.sublist(0, midpoint)),
          ),
          pw.SizedBox(width: 20),
          // Second column (remaining rooms)
          pw.Expanded(
            child: midpoint < roomIds.length 
                ? _buildRoomColumn(roomIds.sublist(midpoint))
                : pw.Container(),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildRoomColumn(List<int> roomIds) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Header row
        pw.Container(
          padding: const pw.EdgeInsets.only(bottom: 10),
          decoration: pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: baseColor, width: 2),
            ),
          ),
          child: pw.Row(
            children: [
              pw.Container(
                width: 50,
                child: pw.Text(
                  'Room #',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: baseColor,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  'Guest Names',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: baseColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Room rows
        ...roomIds.map((roomId) => _buildRoomRow(roomId)),
      ],
    );
  }

  pw.Widget _buildRoomRow(int roomId) {
    final guests = guestsByRoom[roomId] ?? [];
    
    // Format guest names (show up to 2)
    final guestNames = guests.map((guest) {
      final firstName = guest.guest?.firstName ?? '';
      final lastName = guest.guest?.lastName ?? '';
      return '$firstName $lastName'.trim();
    }).toList();
    
    String displayNames = '';
    if (guestNames.isNotEmpty) {
      displayNames = guestNames[0];
      if (guestNames.length > 1) {
        displayNames += ', ${guestNames[1]}';
      }
      if (guestNames.length > 2) {
        displayNames += ' +${guestNames.length - 2} more';
      }
    }
    
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey300, width: 1),
        ),
      ),
      child: pw.Row(
        children: [
          pw.Container(
            width: 50,
            child: pw.Text(
              roomId.toString(),
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(displayNames),
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMMd('en_US');
  return format.format(date);
}