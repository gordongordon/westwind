import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_transaction_form_widget.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/widgets/room_transaction_list_widget.dart';

class RoomTransactionEditPage extends StatefulWidget {
  final int? roomTransactionId;
  static String route([int? roomTransactionId]) =>
      "/roomtransactions/edit/${roomTransactionId ?? ':id'}";
  static String routeNew() => "/roomtransactions/new";

  const RoomTransactionEditPage({super.key, this.roomTransactionId});

  @override
  _RoomTransactionEditPageState createState() => _RoomTransactionEditPageState();
}

class _RoomTransactionEditPageState extends State<RoomTransactionEditPage> {
  RoomTransaction? _roomTransaction;

  @override
  void initState() {
    super.initState();
    if (widget.roomTransactionId != null) {
      context.read<RoomTransactionBloc>().add(
        RetrieveRoomTransactionEvent(id: widget.roomTransactionId!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomTransactionId != null ? "Edit Room Transaction" : "New Room Transaction"),
      ),
      body: BlocConsumer<RoomTransactionBloc, RoomTransactionState>(
        listener: _blocListener,
        builder: (context, state) {
          if (state is RoomTransactionListStateLoading) {
            return const Loader();
          } else {
        //    return Row( children: [
        //         
            //  const RoomTransactionListWidget(),
        //       _buildForm(context),
        //    ],);

             
           return  _buildForm(context);
          }
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return RoomTransactionFormWidget(
      roomTransaction: _roomTransaction,
      onSave: (updatedTransaction) {
        context.read<RoomTransactionBloc>().add(
          CreateRoomTransactionEvent(roomTransaction: updatedTransaction),
        );
      },
    );
  }

  void _blocListener(BuildContext context, RoomTransactionState state) {
    if (state is RoomTransactionStateFailure) {
      showSnackbar(context, state.message);
    } else if (state is RoomTransactionStateCreatedSuccess ||
               state is RoomTransactionStateDeletedSuccess) {
      context.read<RoomTransactionBloc>().add(FetchRoomTransactionsEvent());
      context.pop();
    } else if (state is RoomTransactionStateRetrievedSuccess) {
      setState(() {
        _roomTransaction = state.roomTransaction;
      });
    }
  }
}