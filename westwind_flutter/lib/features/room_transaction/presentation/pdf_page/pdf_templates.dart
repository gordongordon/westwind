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
              return transaction.transactionDay.getDDDMMAndHoursMinutes();
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
 
  /// Helper method to calculate stay days
  static int _calculateStayDays(DateTime checkIn, DateTime checkOut) {
    return checkOut.difference(checkIn).inDays + 1;
  }

}