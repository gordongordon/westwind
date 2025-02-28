import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/pdf_page/generic_pdf_generator.dart';

/// Collection of PDF templates for different entity types
class PdfTemplates {
  
  /// Template for room transactions invoice
  static PdfContentConfig<RoomTransaction> getRoomTransactionInvoiceConfig({
    bool includeAllTransactions = true,
  }) {
    return PdfContentConfig<RoomTransaction>(
      title: 'Westwind Motor Inn',
      subtitle: 'Invoice',
      documentName: 'Invoice',
      tableHeaders: [
        'Stay Date',
        'Room#',
        'Type',
        'Description',
        'Appr #',
        'Amount',
        'GST',
        'Levy',
        'Total'
      ],
      columnAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerLeft,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
        6: pw.Alignment.centerRight,
        7: pw.Alignment.centerRight,
        8: pw.Alignment.centerRight,
      },
      getHeaderData: (transactions) {
        // Extract header data from the first transaction if available
        if (transactions.isEmpty) {
          return {
            'invoiceNumber': '0',
            'customerName': 'none, none',
            'checkInDay': 'Check In: N/A',
            'checkOutDay': 'Check Out: N/A',
            'roomId': '0',
          };
        }
        
        final item = transactions.first;
        return {
          'invoiceNumber': item.roomGuestId.toString(),
          'customerName': '${item.roomGuest?.guest?.lastName ?? "none"}, ${item.roomGuest?.guest?.firstName ?? "none"}',
          'checkInDay': 'Check In: ${item.roomGuest?.checkInDate.getDDMonthName() ?? "N/A"}',
          'checkOutDay': 'Check Out: ${item.roomGuest?.checkOutDate.getDDMonthName() ?? "N/A"}',
          'roomId': item.roomId.toString(),
        };
      },
      getRowData: (transaction, headers) {
        return headers.map((header) {
          switch (header) {
            case 'Room#':
              return transaction.roomId.toString();
            case 'Type':
              return transaction.itemType.toString();
            case 'Description':
              return transaction.description;
            case 'Appr #':
              return transaction.approvedCode != null && transaction.approvedCode!.isNotEmpty
                  ? transaction.approvedCode!
                  : '';
            case 'Amount':
              return transaction.amount.toStringAsFixed(2);
            case 'Stay Date':
              return transaction.stayDay.getYYMMDD();
            case 'Levy':
              return transaction.tax2.toStringAsFixed(2);
            case 'GST':
              return transaction.tax1.toStringAsFixed(2);
            case 'Total':
              return transaction.total.toStringAsFixed(2);
            default:
              return '';
          }
        }).toList();
      },
      calculateSummary: (transactions) {
        // Calculate summary data based on transaction type
        double taxableSales = 0;
        if (includeAllTransactions) {
          taxableSales = transactions.fold(0, (sum, item) => sum + item.amount);
        } else {
          taxableSales = transactions.fold(
            0,
            (sum, item) => sum + ((item.itemType == ItemType.room || item.itemType == ItemType.room_adjust) ? item.amount : 0),
          );
        }
        
        final double levy = transactions.fold(0, (sum, item) => sum + item.tax2);
        final double gst = transactions.fold(0, (sum, item) => sum + item.tax1);
        final double grandTotal = transactions.fold(0, (sum, item) => sum + item.total);
        
        return {
          'Taxable Sales': taxableSales,
          'GST': gst,
          'Alberta Tourism Levy': levy,
          'grandTotal': grandTotal,
        };
      },
    );
  }
  
  /// Template for night audit report
  static PdfContentConfig<RoomTransaction> getNightAuditConfig() {
    return PdfContentConfig<RoomTransaction>(
      title: 'Westwind Motor Inn',
      subtitle: 'Night Audit',
      documentName: 'Report',
      tableHeaders: [
        'Transaction Day',
        'Room#',
        'Description',
        'Amount',
        'GST',
        'Levy',
        'Total'
      ],
      columnAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
        6: pw.Alignment.centerRight,
      },
      getHeaderData: (transactions) {
        // Just use current date for night audit
        return {
          'invoiceNumber': TimeManager.instance.today().getDDMonthName(),
          'customerName': 'Night Audit Report',
          'checkInDay': 'Date: ${TimeManager.instance.today().getDDMonthName()}',
          'checkOutDay': '',
        };
      },
      getRowData: (transaction, headers) {
        return headers.map((header) {
          switch (header) {
            case 'Room#':
              return transaction.roomId.toString();
            case 'Description':
              return transaction.itemType.toString();
            case 'Amount':
              return transaction.amount.toStringAsFixed(2);
            case 'Transaction Day':
              return transaction.transactionDay.getYYMMDD();
            case 'Levy':
              return transaction.tax2.toStringAsFixed(2);
            case 'GST':
              return transaction.tax1.toStringAsFixed(2);
            case 'Total':
              return transaction.total.toStringAsFixed(2);
            default:
              return '';
          }
        }).toList();
      },
      calculateSummary: (transactions) {
        final double taxableSales = transactions.fold(0, (sum, item) => sum + item.amount);
        final double levy = transactions.fold(0, (sum, item) => sum + item.tax2);
        final double gst = transactions.fold(0, (sum, item) => sum + item.tax1);
        final double grandTotal = transactions.fold(0, (sum, item) => sum + item.total);
        
        return {
          'Taxable Sales': taxableSales,
          'GST': gst,
          'Alberta Tourism Levy': levy,
          'grandTotal': grandTotal,
        };
      },
    );
  }
  
  /// Template for room guest summary
  static PdfContentConfig<RoomGuest> getRoomGuestConfig() {
    return PdfContentConfig<RoomGuest>(
      title: 'Westwind Motor Inn',
      subtitle: 'Guest Summary',
      documentName: 'Report',
      tableHeaders: [
        'Room',
        'Guest Name',
        'Check In',
        'Check Out',
        'Stay Days',
        'Rate',
        'Status'
      ],
      columnAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerLeft,
        3: pw.Alignment.centerLeft,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
        6: pw.Alignment.centerLeft,
      },
      getHeaderData: (roomGuests) {
        return {
          'invoiceNumber': 'GS-${TimeManager.instance.today().toCompactString()}',
          'customerName': 'Guest Summary Report',
          'checkInDay': 'Date: ${TimeManager.instance.today().getDDMonthName()}',
          'checkOutDay': '',
        };
      },
      getRowData: (roomGuest, headers) {
        return headers.map((header) {
          switch (header) {
            case 'Room':
              return roomGuest.roomId.toString();
            case 'Guest Name':
              return '${roomGuest.guest?.lastName ?? ""}, ${roomGuest.guest?.firstName ?? ""}';
            case 'Check In':
              return roomGuest.checkInDate.getDDMonthName();
            case 'Check Out':
              return roomGuest.checkOutDate.getDDMonthName();
            case 'Stay Days':
              return _calculateStayDays(roomGuest.checkInDate, roomGuest.checkOutDate).toString();
            case 'Rate':
              return roomGuest.rate.toStringAsFixed(2);
            case 'Status':
              return roomGuest.isCheckOut ? 'Checked Out' : 'In House';
            default:
              return '';
          }
        }).toList();
      },
      calculateSummary: (roomGuests) {
        final totalRooms = roomGuests.length;
        final occupiedRooms = roomGuests.where((guest) => !guest.isCheckOut).length;
        final totalRevenue = roomGuests.fold(0.0, (sum, guest) => sum + (guest.rate * _calculateStayDays(guest.checkInDate, guest.checkOutDate)));
        
        return {
          'Total Rooms': totalRooms.toDouble(),
          'Occupied Rooms': occupiedRooms.toDouble(),
          'Vacancy Rate': ((totalRooms - occupiedRooms) / totalRooms * 100),
          'total': totalRevenue,
        };
      },
    );
  }
 

 
 /*
/// Template for room guest meal report
static PdfContentConfig<RoomGuest> getRoomGuestMealConfig() {
  return PdfContentConfig<RoomGuest>(
    title: 'Westwind Motor Inn',
    subtitle: 'Meal Report',
    documentName: 'Meal Report',
    baseColor: PdfColor(0, 0.4, 0.4), // Slightly darker teal
    
    // Define table headers with empty middle column for spacing
    tableHeaders: [
      'Room', '', '', 'Room', '', '', 'Remark'
    ],
    
    // Column alignments (7 columns - 3 for left side, 1 empty, 3 for right side)
    columnAlignments: {
      0: pw.Alignment.centerLeft, // Left Room number
      1: pw.Alignment.centerLeft, // Left Guest 1
      2: pw.Alignment.centerLeft, // Left Guest 2
      3: pw.Alignment.centerLeft, // Right Room number
      4: pw.Alignment.centerLeft, // Right Guest 1
      5: pw.Alignment.centerLeft, // Right Guest 2
      6: pw.Alignment.centerLeft, // Remarks
    },
    
    // Get header data for the document
    getHeaderData: (roomGuests) {
      return {
        'invoiceNumber': 'MR-${TimeManager.instance.today().toCompactString()}',
        'customerName': 'Guest Meal Report',
        'checkInDay': 'Date: ${TimeManager.instance.today().getDDMonthName()}',
        'checkOutDay': '',
      };
    },
    
    // Custom row data creation
    getRowData: (roomGuest, headers) {
      // We're returning a placeholder row here since we'll process pairs in calculateSummary
      // The actual table building is managed in a custom way below
      return [
        roomGuest.roomId.toString(),  // Room number
        _getGuestName(roomGuest, 0),  // First guest name
        _getGuestName(roomGuest, 1),  // Second guest name
        '',                           // Empty for right column room
        '',                           // Empty for right column first guest
        '',                           // Empty for right column second guest
        '',                           // Remarks
      ];
    },
    
    // Custom summary calculation
    calculateSummary: (roomGuests) {
      final totalRooms = roomGuests.length;
      final occupiedRooms = roomGuests.where((guest) => !guest.isCheckOut).length;
      
      return {
        'Total Rooms': totalRooms.toDouble(),
        'Occupied Rooms': occupiedRooms.toDouble(),
        'With Meal': 0.0, // This would need to be updated with actual meal information
        'Without Meal': 0.0, // This would need to be updated with actual meal information
      };
    },
  );
}

/// Helper method to extract guest names
static String _getGuestName(RoomGuest roomGuest, int index) {
  // If this is the main guest (index 0)
  if (index == 0 && roomGuest.guest != null) {
    return roomGuest.guest!.lastName ?? '';
  }
  
  // For additional guests, you would need to access the accompanying guests
  // This would need to be modified based on your data structure
  // For now, returning empty string for demonstration
  return '';
}

/// Override the content table method for meal report
static pw.Widget _buildMealReportTable(
  pw.Context context,
  List<RoomGuest> roomGuests,
  PdfColor baseColor,
  PdfColor accentColor,
) {
  // Sort room guests by room number
  final sortedGuests = List<RoomGuest>.from(roomGuests)
    ..sort((a, b) => a.roomId.compareTo(b.roomId));
  
  // Split into left and right columns
  final int midPoint = (sortedGuests.length / 2).ceil();
  final leftGuests = sortedGuests.take(midPoint).toList();
  final rightGuests = sortedGuests.skip(midPoint).toList();
  
  // Calculate the maximum number of rows needed
  final maxRows = leftGuests.length;
  
  // Create table rows
  final List<List<String>> tableData = [];
  for (int i = 0; i < maxRows; i++) {
    final row = <String>[];
    
    // Add left column data
    if (i < leftGuests.length) {
      final leftGuest = leftGuests[i];
      row.add(leftGuest.roomId.toString());
      row.add(_getGuestName(leftGuest, 0));
      row.add(_getGuestName(leftGuest, 1));
    } else {
      row.addAll(['', '', '']);
    }
    
    // Add right column data
    if (i < rightGuests.length) {
      final rightGuest = rightGuests[i];
      row.add(rightGuest.roomId.toString());
      row.add(_getGuestName(rightGuest, 0));
      row.add(_getGuestName(rightGuest, 1));
      row.add(''); // Remarks
    } else {
      row.addAll(['', '', '', '']);
    }
    
    tableData.add(row);
  }
  
  // Add final summary rows
  tableData.add(['IN HOUSE W/ SUPPER=', '', '', '', '', '', '']);
  tableData.add(['RESEVATIONS W/ SUPPER=', '', '', '', '', '', '']);
  tableData.add(['WITHOUR SUPPER=', '', '', '', '', '', '']);
  tableData.add(['TOTAL PICKUP TICKETS=', '', '', '', '', '', '']);
  
  // Define table headers
  final List<String> headers = [
    'Room', '', '', 'Room', '', '', 'Remark'
  ];
  
  // Create the table
  return pw.TableHelper.fromTextArray(
    border: pw.TableBorder.all(),
    headerAlignment: pw.Alignment.centerLeft,
    cellAlignment: pw.Alignment.centerLeft,
    headerDecoration: pw.BoxDecoration(
      color: baseColor,
    ),
    headerHeight: 25,
    cellHeight: 25,
    headerStyle: pw.TextStyle(
      color: PdfColors.white,
      fontWeight: pw.FontWeight.bold,
    ),
    cellStyle: pw.TextStyle(
      color: PdfColors.black,
    ),
    headers: headers,
    data: tableData,
  );
}
*/

/// Add this method to your PdfTemplates class in pdf_templates.dart
static PdfContentConfig<RoomGuest> getRoomGuestMealConfig() {
  return PdfContentConfig<RoomGuest>(
    title: 'Westwind Motor Inn',
    subtitle: 'Room Guest Meal List',
    documentName: 'Report',
    // We'll use custom table rendering, but these headers are still required
    tableHeaders: ['Room1', 'Guest1', 'Room2', 'Guest2'],
    columnAlignments: {
      0: pw.Alignment.centerLeft,
      1: pw.Alignment.centerLeft,
      2: pw.Alignment.centerLeft,
      3: pw.Alignment.centerLeft,
    },
    getHeaderData: (roomGuests) {
      return {
        'invoiceNumber': 'MEAL-${TimeManager.instance.today().toCompactString()}',
        'customerName': 'Guest Meal Report',
        'checkInDay': 'Date: ${TimeManager.instance.today().getDDMonthName()}',
        'checkOutDay': '',
      };
    },
    // We override the standard row data function because we're using a custom table layout
    getRowData: (roomGuest, headers) {
      // This won't be used directly, but is required by the interface
      return [
        roomGuest.roomId.toString(),
        '${roomGuest.guest?.lastName ?? ""}, ${roomGuest.guest?.firstName ?? ""}',
        '',
        ''
      ];
    },
    calculateSummary: (roomGuests) {
      final inHouseWithSupper = roomGuests.where((guest) => 
        !guest.isCheckOut && _hasSupper(guest)).length;
      final reservationsWithSupper = roomGuests.where((guest) => 
        !guest.isCheckOut && guest.checkInDate.isAfter(TimeManager.instance.today()) && _hasSupper(guest)).length;
      final withoutSupper = roomGuests.where((guest) => 
        !guest.isCheckOut && !_hasSupper(guest)).length;
      
      return {
        'In House with Supper': inHouseWithSupper.toDouble(),
        'Reservations with Supper': reservationsWithSupper.toDouble(),
        'Without Supper': withoutSupper.toDouble(),
        'Total': (inHouseWithSupper + reservationsWithSupper + withoutSupper).toDouble(),
      };
    },
  );
}

// Custom widget to replace standard table in GenericPdfGenerator
static pw.Widget buildTwoColumnGuestTable(List<RoomGuest> guests) {
  // Sort guests by room number
  final sortedGuests = List<RoomGuest>.from(guests);
  sortedGuests.sort((a, b) => a.roomId.compareTo(b.roomId));
  
  // Split into left and right columns
  final int midPoint = (sortedGuests.length / 2).ceil();
  final leftColumnGuests = sortedGuests.sublist(0, midPoint);
  final rightColumnGuests = sortedGuests.length > midPoint 
      ? sortedGuests.sublist(midPoint) 
      : <RoomGuest>[];
  
  // Determine max rows
  final maxRows = midPoint;
  
  // Create table with two sections side by side
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      // Left column
      pw.Expanded(
        child: _buildGuestColumn(leftColumnGuests),
      ),
      pw.SizedBox(width: 10),
      // Right column
      pw.Expanded(
        child: _buildGuestColumn(rightColumnGuests),
      ),
    ],
  );
}

// Helper to build a single column of the guest table
static pw.Widget _buildGuestColumn(List<RoomGuest> guests) {
  return pw.Table(
    border: pw.TableBorder.all(
      color: PdfColors.black,
      width: 0.5,
    ),
    columnWidths: {
      0: const pw.FlexColumnWidth(1),
      1: const pw.FlexColumnWidth(3),
    },
    children: [
      // Header row
      pw.TableRow(
        decoration: const pw.BoxDecoration(color: PdfColors.grey300),
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(
              'Room',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(
              'Guest',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ],
      ),
      // Guest rows
      ...guests.map((guest) => pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(
              guest.roomId.toString(),
              textAlign: pw.TextAlign.center,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(
              '${guest.guest?.lastName ?? ""}, ${guest.guest?.firstName ?? ""}',
            ),
          ),
        ],
      )),
    ],
  );
}

// Helper to build the summary section
static pw.Widget buildMealSummary(Map<String, double> summary) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(top: 20),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfColors.black, width: 0.5),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          color: PdfColors.grey300,
          width: double.infinity,
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            'Summary',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(10),
          child: pw.Column(
            children: [
              _buildSummaryRow('IN HOUSE W/ SUPPER', summary['In House with Supper']?.toInt() ?? 0),
              _buildSummaryRow('RESERVATIONS W/ SUPPER', summary['Reservations with Supper']?.toInt() ?? 0),
              _buildSummaryRow('WITHOUT SUPPER', summary['Without Supper']?.toInt() ?? 0),
              pw.Divider(),
              _buildSummaryRow('TOTAL PICKUP TICKETS', summary['Total']?.toInt() ?? 0),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper to build summary rows
static pw.Widget _buildSummaryRow(String label, int value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 5),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(value.toString()),
      ],
    ),
  );
}

// Helper method to check if a guest has supper included
// You would need to modify this based on your actual data structure
static bool _hasSupper(RoomGuest guest) {
  // This is a placeholder - replace with your actual logic to determine if a guest has supper
  // For example, you might check for a specific rate code or room type
  return guest.rate > 100; // Just an example condition
}

 
  /// Helper method to calculate stay days
  static int _calculateStayDays(DateTime checkIn, DateTime checkOut) {
    return checkOut.difference(checkIn).inDays + 1;
  }

}