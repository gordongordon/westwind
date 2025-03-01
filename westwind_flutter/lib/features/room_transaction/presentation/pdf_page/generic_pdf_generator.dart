import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';

/// A generic class that defines PDF content configuration
class PdfContentConfig<T> {
  final String title;
  final String subtitle;
  final String documentName;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final List<String> tableHeaders;
  final Map<int, pw.Alignment> columnAlignments;
  final String paymentInfo;
  final String footerText;
  
  /// Function to get header data from entity list (used in document header)
  final Map<String, dynamic> Function(List<T> entities) getHeaderData;
  
  /// Function to extract row data from an entity
  final List<String> Function(T entity, List<String> headers) getRowData;
  
  /// Function to calculate summary data (total, taxes, etc.)
  final Map<String, double> Function(List<T> entities) calculateSummary;

  PdfContentConfig({
    required this.title,
    required this.subtitle,
    required this.documentName,
    required this.tableHeaders,
    required this.columnAlignments,
    required this.getHeaderData,
    required this.getRowData,
    required this.calculateSummary,
    this.baseColor = const PdfColor(0, 0.6, 0.6),
    this.accentColor = const PdfColor(0.66, 0.66, 0.66),

    this.paymentInfo = 'Westwind Motor Inn, 4225 50St, Drayton Vally, Alberta, T7A1M4\n Tel: 1 (780) 542-5375\n Email: westwindmotorinn@gmail.com',
    this.footerText = 'Thank you for your business. We appreciate your partnership and look forward to serving you again.',
  });
}

/// A generic class for generating PDF documents
class GenericPdfGenerator {
  static const _darkColor = PdfColor(0.2, 0.2, 0.2); // Dark gray/almost black
  static const _lightColor = PdfColor(0.83, 0.83, 0.83) ; // White
  
  /// Generate PDF for any entity type
  static Future<Uint8List> generatePdf<T>({
    required PdfPageFormat pageFormat,
    required List<T> entities,
    required PdfContentConfig<T> config,
    required String notes,
  }) async {
    // Create a PDF document
    final doc = pw.Document();
    
    // Load assets
    final bgShape = await rootBundle.loadString('assets/invoice.svg');
    
    // Get header data
    final headerData = config.getHeaderData(entities);
    
    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          await PdfGoogleFonts.robotoRegular(),
          await PdfGoogleFonts.robotoBold(),
          await PdfGoogleFonts.robotoItalic(),
          bgShape,
        ),
        header: (context) => _buildHeader(
          context, 
          config.title, 
          config.documentName, 
          headerData['invoiceNumber'] ?? '',
          config.baseColor,
          config.accentColor,
          _getTextColor(config.accentColor),
        ),
        footer: (context) => _buildFooter(
          context,
          headerData['invoiceNumber'] ?? '',
        ),
        build: (context) => [
          _buildContentHeader(
            context,
            headerData,
            notes,
            config.baseColor,
          ),
          _buildContentTable<T>(
            context,
            entities,
            config.tableHeaders,
            config.columnAlignments,
            config.getRowData,
            config.baseColor,
            config.accentColor,
            _getTextColor(config.baseColor),
          ),
          pw.SizedBox(height: 10),
          _buildContentFooter(
            context,
            config.calculateSummary(entities),
            config.footerText,
            config.paymentInfo,
            config.baseColor,
            config.accentColor,
          ),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  /// Build the page theme
  static pw.PageTheme _buildTheme(
    PdfPageFormat pageFormat,
    pw.Font base,
    pw.Font bold,
    pw.Font italic,
    String bgShape,
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
        child: pw.SvgImage(svg: bgShape),
      ),
    );
  }

  /// Build the document header
  static pw.Widget _buildHeader(
    pw.Context context,
    String title,
    String documentName,
    String invoiceNumber,
    PdfColor baseColor,
    PdfColor accentColor,
    PdfColor textColor,
  ) {
    final invoiceDay = TimeManager.instance.today().toCompactString();
    
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      title,
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                      left: 40, top: 10, bottom: 10, right: 20
                    ),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('$documentName #'),
                          pw.Text('$invoiceNumber-$invoiceDay'),
                          pw.Text('Date:'),
                          pw.Text(_formatDate(TimeManager.instance.today())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 10)
      ],
    );
  }

  /// Build the document footer
  static pw.Widget _buildFooter(pw.Context context, String invoiceNumber) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.BarcodeWidget(
            barcode: pw.Barcode.pdf417(),
            data: 'Invoice# $invoiceNumber',
            drawText: false,
          ),
        ),
        pw.Text(
          'Page ${context.pageNumber}/${context.pagesCount}',
          style: const pw.TextStyle(
            fontSize: 12,
            color: PdfColors.white,
          ),
        ),
      ],
    );
  }

  /// Build the content header with customer information
  static pw.Widget _buildContentHeader(
    pw.Context context,
    Map<String, dynamic> headerData,
    String notes,
    PdfColor baseColor,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 18,
            child: pw.FittedBox(
              child: pw.Text(
                notes,
                style: pw.TextStyle(
                  color: baseColor,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice to:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                    text: pw.TextSpan(
                      text: '${headerData['customerName'] ?? ''}\n',
                      style: pw.TextStyle(
                        color: _darkColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                      ),
                      children: [
                        const pw.TextSpan(
                          text: '\n',
                          style: pw.TextStyle(
                            fontSize: 5,
                          ),
                        ),
                        pw.TextSpan(
                          text: '${headerData['checkInDay'] ?? ''}\n',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        pw.TextSpan(
                          text: '${headerData['checkOutDay'] ?? ''}\n',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build the content table
  static pw.Widget _buildContentTable<E>(
    pw.Context context,
    List<E> entities,
    List<String> tableHeaders,
    Map<int, pw.Alignment> cellAlignments,
    List<String> Function(E, List<String>) getRowData,
    PdfColor baseColor,
    PdfColor accentColor,
    PdfColor headerTextColor,
  ) {
    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 20,
      cellHeight: 18,
      cellAlignments: cellAlignments,
      headerStyle: pw.TextStyle(
        color: headerTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .2,
          ),
        ),
      ),
      headers: tableHeaders,
      data: List<List<String>>.generate(
        entities.length,
        (row) => getRowData(entities[row] as E, tableHeaders),
      ),
    );
  }

  /// Build the content footer with summary totals
  static pw.Widget _buildContentFooter(
    pw.Context context,
    Map<String, double> summary,
    String footerText,
    String paymentInfo,
    PdfColor baseColor,
    PdfColor accentColor,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                footerText,
                style: pw.TextStyle(
                  color: _darkColor,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  'Payment Info:',
                  style: pw.TextStyle(
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                paymentInfo,
                style: const pw.TextStyle(
                  fontSize: 9,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 11,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildSummaryRows(summary, baseColor, accentColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to build summary rows
  static pw.Widget _buildSummaryRows(
    Map<String, double> summary,
    PdfColor baseColor,
    PdfColor accentColor,
  ) {
    final rows = <pw.Widget>[];
    
    // Add all summary items except the total
    summary.forEach((key, value) {
      if (key != 'total' && key != 'grandTotal') {
        rows.add(
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('$key:'),
              pw.Text(_formatCurrency(value)),
            ],
          ),
        );
        rows.add(pw.SizedBox(height: 5));
      }
    });
    
    // Add divider and total
    rows.add(pw.Divider(color: accentColor));
    
    // Add grand total or balance due
    final total = summary['grandTotal'] ?? summary['total'] ?? 0.0;
    rows.add(
      pw.DefaultTextStyle(
        style: pw.TextStyle(
          color: baseColor,
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Balance Due:'),
            pw.Text(_formatCurrency(total)),
          ],
        ),
      ),
    );
    
    return pw.Column(children: rows);
  }

  /// Helper method to determine text color based on background color
  static PdfColor _getTextColor(PdfColor backgroundColor) {
    return backgroundColor.isLight ? _darkColor : _lightColor;
  }

  /// Format currency
  static String _formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  /// Format date
  static String _formatDate(DateTime date) {
    final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${monthNames[date.month - 1]}, ${date.year}';
  }
}