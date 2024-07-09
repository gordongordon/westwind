import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_guest_transactions/room_guest_transactions_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/new_room_guest_transaction_widget.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_transaction_form_widget.dart';

class RoomGuestTransactionsWidget extends StatefulWidget {
  final int roomGuestId;

  const RoomGuestTransactionsWidget({Key? key, required this.roomGuestId}) : super(key: key);

  @override
  _RoomGuestTransactionsWidgetState createState() => _RoomGuestTransactionsWidgetState();
}

class _RoomGuestTransactionsWidgetState extends State<RoomGuestTransactionsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<RoomGuestTransactionsBloc>().add(FetchRoomGuestTransactions(widget.roomGuestId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Guest Transactions ${widget.roomGuestId}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<RoomGuestTransactionsBloc, RoomGuestTransactionsState>(
              builder: (context, state) {
                if (state is RoomGuestTransactionsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RoomGuestTransactionsLoaded) {
                  return _buildTransactionsList(state.transactions);
                } else if (state is RoomGuestTransactionsError) {
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
              'Add New Transaction',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RoomGuestTransactionFormWidget(
                 //! May need to handle it. roomGuestId
                  roomGuestId: widget.roomGuestId,
                  onSave: (transaction) {
                    context.read<RoomGuestTransactionsBloc>().add(CreateRoomTransaction(transaction));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<RoomTransaction> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ExpansionTile(
            title: Text('${transaction.transactionType} - ${transaction.itemType}'),
            subtitle: Text('Total: \$${transaction.total.toStringAsFixed(2)}'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Transaction ID', '${transaction.id}'),
                    _buildInfoRow('Room ID', '${transaction.roomId}'),
                    _buildInfoRow('Guest ID', '${transaction.guestId}'),
                    _buildInfoRow('Stay Day', _formatDate(transaction.stayDay)),
                    _buildInfoRow('Transaction Day', _formatDate(transaction.transactionDay)),
                    _buildInfoRow('Amount', '\$${transaction.amount.toStringAsFixed(2)}'),
                    _buildInfoRow('GST', '\$${transaction.tax1.toStringAsFixed(2)}'),
                    _buildInfoRow('Levy', '\$${transaction.tax2.toStringAsFixed(2)}'),
                    _buildInfoRow('Additional Tax', '\$${transaction.tax3.toStringAsFixed(2)}'),
                    _buildInfoRow('Total', '\$${transaction.total.toStringAsFixed(2)}'),
                    _buildInfoRow('Description', transaction.description),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }
}