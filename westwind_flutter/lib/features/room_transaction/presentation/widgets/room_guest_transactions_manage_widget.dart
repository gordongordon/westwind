import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_manage/room_guest_manage_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_guest_transactions/room_guest_transactions_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_transaction_management_form_widget.dart';

class RoomGuestTransactionsManageWidget extends StatefulWidget {
  final int roomGuestId;

  const RoomGuestTransactionsManageWidget(
      {super.key, required this.roomGuestId});

  @override
  _RoomGuestTransactionsManageWidgetState createState() =>
      _RoomGuestTransactionsManageWidgetState();
}

class _RoomGuestTransactionsManageWidgetState
    extends State<RoomGuestTransactionsManageWidget> {
  double _total = 0;
  double _amount = 0;
  double _gst = 0;
  double _levy = 0;

  @override
  void initState() {
    super.initState();
    context
        .read<RoomGuestTransactionsBloc>()
        .add(FetchRoomGuestTransactions(widget.roomGuestId));
    context
        .read<RoomTransactionBloc>()
        .add(RetrieveRoomGuestEvent(roomGuestId: widget.roomGuestId));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<RoomGuestTransactionsBloc,
              RoomGuestTransactionsState>(
            builder: (context, state) {
              if (state is RoomGuestTransactionsLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RoomGuestTransactionsLoaded) {
                _total = _computeTotal(state.transactions);
                _amount = _computeAmount(state.transactions);
                _gst = _computeGST(state.transactions);
                _levy = _computeLevy(state.transactions);
                // Use Future.microtask to schedule setState for the next frame
                Future.microtask(() {
                  if (mounted) {
                    setState(() {
                      _total = _total;
                      _gst = _gst;
                      _levy = _levy;
                    });
                  }
                });

                return _buildTransactionsList(state.transactions);
              } else if (state is RoomGuestTransactionsFailure) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('No transactions found'));
              }
            },
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            // 'Add New Transaction - total of {$_total}      / GST of $_gst      / Levy of $_levy',
            '${_total > 0 ? 'Owning' : 'Credit'} of \$${_amount.toStringAsFixed(2)} + GST of \$${_gst.toStringAsFixed(2)} + Levy of \$${_levy.toStringAsFixed(2)} = total of \$${_total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<RoomTransactionBloc, RoomTransactionState>(
                listener: _blocListener,
                builder: (context, state) {
                  if (state is RoomTransactionStateRetrievedRoomGuestSuccess) {
                    return RoomTransactionManagementFormWidget(
                        roomTransaction: null,
                        roomGuest: state.roomGuest,
                        onSave: (updatedTransaction) {
                          context.read<RoomTransactionBloc>().add(
                              CreateRoomTransactionEvent(
                                  roomTransaction: updatedTransaction));
                        });
                  } else {
                    return Placeholder();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _blocListener(BuildContext context, RoomTransactionState state) {
    if (state is RoomTransactionStateFailure) {
      showSnackbar(context, state.message);
    } else if (state is RoomTransactionStateCreatedSuccess ||
        state is RoomTransactionStateDeletedSuccess) {
      context
          .read<RoomGuestTransactionsBloc>()
          .add(FetchRoomGuestTransactions(widget.roomGuestId));
      context
          .read<RoomTransactionBloc>()
          .add(RetrieveRoomGuestEvent(roomGuestId: widget.roomGuestId));
    }
  }

  double _computeTotal(List<RoomTransaction> transactions) {
    return transactions.fold(
        0.0, (sum, transaction) => sum + transaction.total);
  }

  double _computeAmount(List<RoomTransaction> transactions) {
    return transactions.fold(
        0.0, (sum, transaction) => sum + transaction.amount);
  }

  double _computeGST(List<RoomTransaction> transactions) {
    return transactions.fold(0.0, (sum, transaction) => sum + transaction.tax1);
  }

  double _computeLevy(List<RoomTransaction> transactions) {
    return transactions.fold(0.0, (sum, transaction) => sum + transaction.tax2);
  }

  Widget _buildTransactionsList(List<RoomTransaction> transactions) {
    return ListView.builder(
      // reverse: tr
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isLastItem = index == transactions.length - 1;
        final isFirstItem = index == 0;

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          color: isFirstItem
              ? Colors.red[50]
              : null, // Light red background for the last item
          child: ExpansionTile(
            title: Text(
              '${transaction.transactionType} - ${transaction.itemType}    /    # ${transaction.roomId} - StayDay at ${transaction.stayDay.getMonthNameDD()}  /    Create At - ${transaction.transactionDay.getMonthDayHour()} / Appr # - ${transaction.approvedCode}',
              style: TextStyle(color: isFirstItem ? Colors.red : null),
            ),
            subtitle: Text(
              'Total: \$${transaction.total.toStringAsFixed(2)}',
              style: TextStyle(color: isFirstItem ? Colors.red : null),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Transaction ID', '${transaction.id}',
                        isLastItem: isFirstItem),
                    _buildInfoRow('Room ID', '${transaction.roomId}',
                        isLastItem: isFirstItem),
                    _buildInfoRow('Guest ID', '${transaction.guestId}',
                        isLastItem: isFirstItem),
                    _buildInfoRow('Guest ',
                        '${transaction.guest?.lastName} ${transaction.guest?.firstName}',
                        isLastItem: isFirstItem),
                    _buildInfoRow(
                        'Stay Day', transaction.stayDay.getMonthNameDD(),
                        isLastItem: isFirstItem),
                    _buildInfoRow('Transaction Day',
                        transaction.transactionDay.getMonthDayHourMinute(),
                        isLastItem: isFirstItem),
                    transaction.approvedCode != null
                        ? _buildInfoRow('Appr #', '${transaction.approvedCode}',
                            isLastItem: isFirstItem)
                        : Container(),
                    _buildInfoRow(
                        'Amount', '\$${transaction.amount.toStringAsFixed(2)}',
                        isLastItem: isFirstItem),
                    _buildInfoRow(
                        'GST', '\$${transaction.tax1.toStringAsFixed(2)}',
                        isLastItem: isFirstItem),
                    _buildInfoRow(
                        'Levy', '\$${transaction.tax2.toStringAsFixed(2)}',
                        isLastItem: isFirstItem),
                    _buildInfoRow(
                        'Total', '\$${transaction.total.toStringAsFixed(2)}',
                        isLastItem: isFirstItem),
                    _buildInfoRow('Description', transaction.description,
                        isLastItem: isFirstItem),
                    _buildActionButtons(transaction.id),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(int? transactionId) {
    if (transactionId != null) {
      return Column(
        children: [
          const SizedBox(height: 16),
          _buildButton(
              'Delete',
              () => context
                  .read<RoomTransactionBloc>()
                  .add(DeleteRoomTransactionEvent(id: transactionId)),
              color: Colors.red),
        ],
      );
    }
    return SizedBox();
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      {Color color = Colors.blue}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }

/* 
Widget _buildButton(String text, VoidCallback onPressed) {
  return ElevatedButton.icon(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, // Set a meaningful color like green for "Save"
      foregroundColor: Colors.white, // Text/icon color
      minimumSize: Size(double.infinity, 50), // Full-width and height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      padding: EdgeInsets.symmetric(vertical: 14), // Add vertical padding for better touch target
      elevation: 3, // Add slight shadow
    ),
    icon: Icon(Icons.save, size: 24), // Save icon
    label: Text(
      text,
      style: TextStyle(
        fontSize: 18, // Larger font for readability
        fontWeight: FontWeight.bold, // Make it stand out
      ),
    ),
  );
}
*/

  Widget _buildInfoRow(String label, String value, {required bool isLastItem}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isLastItem ? Colors.red : null,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isLastItem ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

/*
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MM-dd').format(date);
  }
  */
}
