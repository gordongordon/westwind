import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:westwind_client/westwind_client.dart';

class RoomTransactionFormWidget extends StatefulWidget {
  final RoomTransaction? roomTransaction;
  final Function(RoomTransaction) onSave;

  const RoomTransactionFormWidget({
    Key? key,
    this.roomTransaction,
    required this.onSave,
  }) : super(key: key);

  @override
  State<RoomTransactionFormWidget> createState() => _RoomTransactionFormWidgetState();
}

class _RoomTransactionFormWidgetState extends State<RoomTransactionFormWidget> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController idController = TextEditingController(text: "0");
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController guestIdController = TextEditingController();
  final TextEditingController roomGuestIdController = TextEditingController();
  final TextEditingController transactionTypeController = TextEditingController();
  final TextEditingController itemTypeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController tax1Controller = TextEditingController();
  final TextEditingController tax2Controller = TextEditingController();
  final TextEditingController tax3Controller = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime stayDay = DateTime.now();
  DateTime transactionDay = DateTime.now();

  final List<String> _transactionTypeOptions = TransactionType.values.map((e) => e.name).toList();
  final List<String> _itemTypeOptions = ItemType.values.map((e) => e.name).toList();

  @override
  void initState() {
    super.initState();
    if (widget.roomTransaction != null) {
      _populateFields(widget.roomTransaction!);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveRoomTransaction,
                child: const Text('Save Room Transaction'),
              ),
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
        Text('Transaction Details', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('id', 'Transaction ID', idController, enabled: false),
        _buildDateTimePicker('stayDay', 'Stay Day', initialValue: stayDay),
        _buildDateTimePicker('transactionDay', 'Transaction Day', initialValue: transactionDay),
        _buildTextField('roomId', 'Room ID', roomIdController),
        _buildTextField('guestId', 'Guest ID', guestIdController),
        _buildDropdown('transactionType', 'Transaction Type', _transactionTypeOptions, initialValue: transactionTypeController.text),
      ],
    );
  }

  Widget _buildFinancialDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Financial Details', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('amount', 'Amount', amountController, keyboardType: TextInputType.number),
        _buildTextField('tax1', 'GST', tax1Controller, keyboardType: TextInputType.number),
        _buildTextField('tax2', 'Levy', tax2Controller, keyboardType: TextInputType.number),
        _buildTextField('tax3', 'Additional Tax', tax3Controller, keyboardType: TextInputType.number),
        _buildTextField('total', 'Total', totalController, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Additional Information', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('roomGuestId', 'Room Guest ID', roomGuestIdController),
        _buildDropdown('itemType', 'Item Type', _itemTypeOptions, initialValue: itemTypeController.text),
        _buildTextField('description', 'Description', descriptionController, maxLines: 3),
      ],
    );
  }

  Widget _buildTextField(String name, String label, TextEditingController controller, {bool enabled = true, TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
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
        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildDateTimePicker(String name, String label, {required DateTime initialValue}) {
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
        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildDropdown(String name, String label, List<String> options, {required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderDropdown<String>(
        name: name,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
      ),
    );
  }

  void _saveRoomTransaction() {
    if (formKey.currentState!.saveAndValidate()) {
      final transactionType = TransactionType.values.byName(formKey.currentState!.fields['transactionType']!.value);
      final itemType = ItemType.values.byName(formKey.currentState!.fields['itemType']!.value);

      final roomTransaction = RoomTransaction(
        id: widget.roomTransaction?.id,
        guestId: int.parse(guestIdController.text),
        roomId: int.parse(roomIdController.text),
        roomGuestId: int.parse(roomGuestIdController.text),
        stayDay: formKey.currentState!.fields['stayDay']!.value,
        transactionDay: formKey.currentState!.fields['transactionDay']!.value,
        transactionType: transactionType,
        amount: double.parse(amountController.text),
        tax1: double.parse(tax1Controller.text),
        tax2: double.parse(tax2Controller.text),
        tax3: double.parse(tax3Controller.text),
        total: double.parse(totalController.text),
        description: descriptionController.text,
        itemType: itemType,
      );

      widget.onSave(roomTransaction);
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
    tax3Controller.text = transaction.tax3.toString();
    totalController.text = transaction.total.toString();
    transactionTypeController.text = transaction.transactionType.toString();
    itemTypeController.text = transaction.itemType.toString();
    transactionDay = transaction.transactionDay.toLocal();
    stayDay = transaction.stayDay!;
    descriptionController.text = transaction.description;
    
    formKey.currentState?.patchValue({
      'transactionType': transaction.transactionType.name,
      'itemType': transaction.itemType.name,
    });
  }
}