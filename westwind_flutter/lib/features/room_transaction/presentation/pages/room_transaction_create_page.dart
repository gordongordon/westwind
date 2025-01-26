import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_manage/room_guest_manage_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_bloc.dart';

class RoomTransactionCreatePage extends StatefulWidget {
  final int? roomTransactionId;
  static String route([int? roomTransactionId]) =>
      "/roomtransactions/create/${roomTransactionId ?? ':id'}";
  static String routeNew() => "/roomtransactions/new";

  const RoomTransactionCreatePage({super.key, this.roomTransactionId});

  @override
  State<RoomTransactionCreatePage> createState() =>
      _RoomTransactionEditPageState();
}

class _RoomTransactionEditPageState extends State<RoomTransactionCreatePage> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController idController = TextEditingController(text: "0");
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController guestIdController = TextEditingController();
  final TextEditingController roomGuestIdController = TextEditingController();
  final TextEditingController transactionTypeController =
      TextEditingController();
  final TextEditingController itemTypeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController tax1Controller = TextEditingController();
  final TextEditingController tax2Controller = TextEditingController();
  // final TextEditingController tax3Controller = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime stayDay = TimeManager.instance.today();
  DateTime transactionDay = TimeManager.instance.today();

  final List<String> _transactionTypeOptions =
      TransactionType.values.map((e) => e.name).toList();
  final List<String> _itemTypeOptions =
      ItemType.values.map((e) => e.name).toList();

  bool get isEditing =>
      widget.roomTransactionId != null && widget.roomTransactionId! > 0;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      context
          .read<RoomTransactionBloc>()
          .add(RetrieveRoomTransactionEvent(id: widget.roomTransactionId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(isEditing ? "Edit Room Transaction" : "New Room Transaction"),
        actions: [
          IconButton(
            onPressed: _saveRoomTransaction,
            icon: Icon(Icons.save),
            tooltip: 'Save Room Transaction',
          ),
        ],
      ),
      body: BlocConsumer<RoomTransactionBloc, RoomTransactionState>(
        listener: _blocListener,
        builder: (context, state) {
          if (state is RoomTransactionListStateLoading) {
            return const Loader();
          }
          return _buildForm();
        },
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTransactionDetailsSection(),
              _buildFinancialDetailsSection(),
              _buildAdditionalInfoSection(),
              if (isEditing) _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction Details',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('id', 'Transaction ID', idController, enabled: false),
        _buildDateTimePicker('stayDay', 'Stay Day', initialValue: stayDay),
        _buildDateTimePicker('transactionDay', 'Transaction Day',
            initialValue: transactionDay),
        _buildTextField('roomId', 'Room ID', roomIdController),
        _buildTextField('guestId', 'Guest ID', guestIdController),
        _buildDropdown(
            'transactionType', 'Transaction Type', _transactionTypeOptions,
            initialValue: transactionTypeController.text),
      ],
    );
  }

  Widget _buildFinancialDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Financial Details',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('amount', 'Amount', amountController,
            keyboardType: TextInputType.number),
        _buildTextField('tax1', 'GST', tax1Controller,
            keyboardType: TextInputType.number),
        _buildTextField('tax2', 'Levy', tax2Controller,
            keyboardType: TextInputType.number),
        //  _buildTextField('tax3', 'Additional Tax', tax3Controller, keyboardType: TextInputType.number),
        _buildTextField('total', 'Total', totalController,
            keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Additional Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('roomGuestId', 'Room Guest ID', roomGuestIdController),
        _buildDropdown('itemType', 'Item Type', _itemTypeOptions,
            initialValue: itemTypeController.text),
        _buildTextField('description', 'Description', descriptionController,
            maxLines: 3),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildButton(
            'Delete Transaction',
            () => context.read<RoomTransactionBloc>().add(
                DeleteRoomTransactionEvent(id: widget.roomTransactionId!))),
        const SizedBox(height: 16),
        _buildButton(
            'Charge & Extend Stay',
            () => context
                .read<RoomGuestManageBloc>()
                .add(ChargeAndExtendStayDay(id: widget.roomTransactionId!))),
      ],
    );
  }

  Widget _buildTextField(
      String name, String label, TextEditingController controller,
      {bool enabled = true,
      TextInputType keyboardType = TextInputType.text,
      int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildDateTimePicker(String name, String label,
      {required DateTime initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderDateTimePicker(
        name: name,
        initialValue: initialValue,
        inputType: InputType.date,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildDropdown(String name, String label, List<String> options,
      {required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderDropdown<String>(
        name: name,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: options
            .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }

  void _saveRoomTransaction() {
    if (formKey.currentState!.saveAndValidate()) {
      final transactionType = TransactionType.values
          .byName(formKey.currentState!.fields['transactionType']!.value);
      final itemType = ItemType.values
          .byName(formKey.currentState!.fields['itemType']!.value);

      final roomTransaction = RoomTransaction(
        id: widget.roomTransactionId,
        guestId: int.parse(guestIdController.text),
        roomId: int.parse(roomIdController.text),
        roomGuestId: int.parse(roomGuestIdController.text),
        stayDay: formKey.currentState!.fields['stayDay']!.value,
        transactionDay: formKey.currentState!.fields['transactionDay']!.value,
        transactionType: transactionType,
        amount: double.parse(amountController.text),
        tax1: double.parse(tax1Controller.text),
        tax2: double.parse(tax2Controller.text),
        // tax3: double.parse(tax3Controller.text),
        total: double.parse(totalController.text),
        description: descriptionController.text,
        itemType: itemType,
      );

      context
          .read<RoomTransactionBloc>()
          .add(CreateRoomTransactionEvent(roomTransaction: roomTransaction));
    }
  }

  void _blocListener(BuildContext context, RoomTransactionState state) {
    if (state is RoomTransactionStateFailure) {
      showSnackbar(context, state.message);
    } else if (state is RoomTransactionStateCreatedSuccess ||
        state is RoomTransactionStateDeletedSuccess) {
      context.read<RoomTransactionBloc>().add(FetchRoomTransactionsEvent());
      context.pop();
    } else if (state is RoomTransactionStateRetrievedSuccess) {
      _populateFields(state.roomTransaction);
    }
  }

  void _populateFields(RoomTransaction transaction) {
    idController.text = transaction.id.toString();
    guestIdController.text = transaction.guestId.toString();
    roomGuestIdController.text = transaction.roomGuestId.toString();
    roomIdController.text = transaction.roomId.toString();
    amountController.text = transaction.amount.toString();
    tax1Controller.text = transaction.tax1.toString();
    tax2Controller.text = transaction.tax2.toString();
    //  tax3Controller.text = transaction.tax3.toString();
    totalController.text = transaction.total.toString();
    transactionTypeController.text = transaction.transactionType.toString();
    itemTypeController.text = transaction.itemType.toString();
    transactionDay = transaction.transactionDay.toLocal();
    stayDay = transaction.stayDay;
    descriptionController.text = transaction.description;

    formKey.currentState?.patchValue({
      'transactionType': transaction.transactionType.name,
      'itemType': transaction.itemType.name,
    });
  }
}
