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

import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/room_transaction/domain/repositories/room_transaction_repository.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf/data.dart';

Future<Uint8List> generateInvoice(
  PdfPageFormat pageFormat,
  CustomData data,
  List<RoomTransaction> roomTransactions,
) async {
  //final lorem = pw.LoremText();

  //final RoomTransactionRepository roomTransactionRepository;

  //final transaction = await roomTransactionRepository.retrieve(100);
/*
  final products = <Product>[
    Product('19', lorem.sentence(4), 86, TimeManager.instance.today()),
    Product('22', lorem.sentence(6), 86, TimeManager.instance.today()),
    Product('66', lorem.sentence(4), 86, TimeManager.instance.today()),
    Product('77', lorem.sentence(3), 86, TimeManager.instance.today()),
  ];
  */
  final length = roomTransactions.length;
  int invoiceNumber;
  String lastName;
  String firstName;
  String phoneNumber;
  String roomId;
  String description;
  DateTime checkInDay;
  DateTime checkOutDay;

  if (length > 0) {
    final item = roomTransactions[0];
    invoiceNumber = item.roomGuestId;
    lastName = item.roomGuest!.guest!.lastName;
    firstName = item.roomGuest!.guest!.firstName;
    phoneNumber = item.roomGuest!.guest!.phone;
    checkInDay = item.roomGuest!.checkInDate;
    checkOutDay = item.roomGuest!.checkOutDate;
    roomId = item.roomId.toString();
    description = item.description;
  } else {
    invoiceNumber = 0;
    lastName = "none";
    firstName = "none";
    phoneNumber = "0";
    checkInDay = TimeManager.instance.today();
    checkOutDay = TimeManager.instance.today();
    roomId = "0";
    description = "-";
  }

  final invoice = Invoice(
    invoiceNumber: invoiceNumber.toString(),
    roomTransactions: roomTransactions,
    customerName: '$lastName, $firstName',
    customerAddress: 'none',
    roomId: roomId,
    description : description,
    checkInDay:  'Check  In : ${checkInDay.getDDMonthName()}',
    checkOutDay: 'Check Out : ${checkOutDay.getDDMonthName()} ',
    paymentInfo:
        'Westwind Motor Inn, 4225 50St, Drayton Vally, Alberta, T7A1M4\n Tel: 1 (780) 542-5375\n Email: westwindmotorinn@gmail.com',
    tax: .9,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
    inputData: data,
  );

  return await invoice.buildPdf(pageFormat);
}

class Invoice {
  Invoice({
    required this.roomTransactions,
    required this.customerName,
    required this.customerAddress,
    required this.roomId,
    required this.description,
    required this.checkInDay,
    required this.checkOutDay,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
    required this.inputData,
  });

  final List<RoomTransaction> roomTransactions;
  final String customerName;
  final String customerAddress;
  final String roomId;
  final String description;
  final String checkInDay;
  final String checkOutDay;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final CustomData inputData;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  // double get _taxAbleSales = roomTransactions.map<double>( (p) => p.itemType == ItemType.room )

//  double get _subAmount =>
  //    roomTransactions.map<double>((p) => p.amount).reduce((a, b) => a + b);
  //     roomTransactions.map<double>((p) => p.amount).reduce((a, b) => a + b);

  //    roomTransactions.map<double>((p) => p.amount).reduce((a, b) => a + b);
  double get _taxableSales => roomTransactions
      .map<double>((p) => (p.itemType == ItemType.room ) || (p.itemType == ItemType.room_adjust) ? p.amount : 0)
      .fold(0, (a, b) => a + b);

// double get _subAmount =>    roomTransactions.fold(0, (a, b) => a + b.amount);

  double get _levy =>
      roomTransactions.map<double>((p) => p.tax2).fold(0, (a, b) => a + b);
     // .reduce((a, b) => a + b);

  double get _gst =>
      roomTransactions.map<double>((p) => p.tax1).fold(0, (a, b) => a + b);
      //.reduce((a, b) => a + b);
  // double get _grandTotal => _total * (1 + tax);
  double get _grandTotal =>
      roomTransactions.map<double>((p) => p.total).fold(0, (a, b) => a + b);
    //  .reduce((a, b) => a + b);

  String? _logo;

  String? _bgShape;

  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) async {
    // Create a PDF document.
    final doc = pw.Document();

    _logo = await rootBundle.loadString('assets/logo.svg');
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
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 10),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          // _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
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
                      'Westwind Motor Inn',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          //pw.Text(  invoiceNumber ),
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
                children: [
                  /*
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child:
                        _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
                  ),
                  */
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 10)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    //  final invoiceDay = TimeManager.instance.today().getMonthDayHour();

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

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: _bgShape!),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 18,
            child: pw.FittedBox(
              child: pw.Text(
                '${inputData.message}',
                //    'Total: ${_formatCurrency(_grandTotal)}',
                //        ' ',
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
                          text: '$customerName\n',
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
                          text: '$checkInDay\n',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        pw.TextSpan(
                          text: '$checkOutDay\n',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        /*
                        pw.TextSpan(
                          text: '${inputData.message}\n',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 10,
                          ),
                        ),
                        */
                      ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Thank you for your business. We appreciate your partnership and look forward to serving you again.',
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
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Taxable Sales:'),
                    pw.Text(_formatCurrency(_taxableSales)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('GST:'),
                    //pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
                    pw.Text(_formatCurrency(_gst)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Alberta Tourism Levy:'),
                    //        pw.Text('${(tax * 100).toStringAsFixed(1)}%'),
                    pw.Text(_formatCurrency(_levy)),
                  ],
                ),
                pw.Divider(color: accentColor),
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
                      pw.Text(_formatCurrency(_grandTotal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: accentColor)),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                pw.LoremText().paragraph(40),
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'Stay Date',
      'Room#',
      'Description',
      'Amount',
      'GST',
      'Levy',
      'Total'
    ];

    return pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
        color: baseColor,
      ),
      headerHeight: 20,
      cellHeight: 18,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
        6: pw.Alignment.centerRight,
        //       6: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: _baseTextColor,
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
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        roomTransactions.length,
        (row) => List<String>.generate(tableHeaders.length,
            //         (col) => roomTransactions[row].getIndex(col),

            (col) {
          // Use a switch or map to access the correct property
          switch (tableHeaders[col]) {
            case 'Room#':
              return roomTransactions[row].roomId.toString();
            case 'Description':
//              return roomTransactions[row].itemType.toString();
            return roomTransactions[row].description.toString();
            case 'Amount':
              return roomTransactions[row].amount.toString();
            case 'Stay Date':
              return roomTransactions[row].stayDay.getYYMMDD();
            case 'Levy':
              return roomTransactions[row].tax2.toString();
            case 'GST':
              return roomTransactions[row].tax1.toStringAsFixed(2);
            case 'Total':
              return roomTransactions[row].total.toString();
            default:
              return '';
          }
        }),
      ),
    );
  }
}

String _formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}

/*
class Product {
  const Product(
    this.id,
    this.productName,
    this.price,
    this.stayDay,
  );

  final String id;
  final String productName;
  final double price;
  final DateTime stayDay;

  double get total => price * 1;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return id;
      case 1:
        return productName;
      case 2:
        return _formatCurrency(price);
      case 3:
        return stayDay.toLocal().getDDMonthName();
      case 4:
        return _formatCurrency(total);
    }
    return '';
  }
}

*/
