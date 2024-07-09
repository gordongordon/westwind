import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:intl/intl.dart';

class RoomGuestTransactionFormWidget extends StatefulWidget {
  final Function(RoomTransaction) onSave;
  final int roomGuestId;

  const RoomGuestTransactionFormWidget({
    super.key,
    required this.onSave,
    required this.roomGuestId,
  });

  @override
  _RoomTransactionFormWidgetState createState() => _RoomTransactionFormWidgetState();
}

class _RoomTransactionFormWidgetState extends State<RoomGuestTransactionFormWidget> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          FormBuilderDropdown<TransactionType>(
            name: 'transactionType',
            decoration: InputDecoration(labelText: 'Transaction Type'),
            validator: FormBuilderValidators.required(),
            items: TransactionType.values
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    ))
                .toList(),
          ),
          FormBuilderDropdown<ItemType>(
            name: 'itemType',
            decoration: InputDecoration(labelText: 'Item Type'),
            validator: FormBuilderValidators.required(),
            items: ItemType.values
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    ))
                .toList(),
          ),
          FormBuilderTextField(
            name: 'amount',
            decoration: InputDecoration(labelText: 'Amount'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
          ),
          FormBuilderTextField(
            name: 'tax1',
            decoration: InputDecoration(labelText: 'GST'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
          ),
          FormBuilderTextField(
            name: 'tax2',
            decoration: InputDecoration(labelText: 'Levy'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
          ),
          FormBuilderTextField(
            name: 'tax3',
            decoration: InputDecoration(labelText: 'Additional Tax'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
          ),
          FormBuilderTextField(
            name: 'description',
            decoration: InputDecoration(labelText: 'Description'),
            validator: FormBuilderValidators.required(),
            maxLines: 3,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Create Transaction'),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      final newTransaction = RoomTransaction(
        guestId: widget.roomGuestId,
        roomGuestId: widget.roomGuestId,
        roomId: 101,
        transactionType: formData['transactionType'] as TransactionType,
        itemType: formData['itemType'] as ItemType,
        amount: double.parse(formData['amount']),
        tax1: double.parse(formData['tax1']),
        tax2: double.parse(formData['tax2']),
        tax3: double.parse(formData['tax3']),
        total: double.parse(formData['amount']) +
            double.parse(formData['tax1']) +
            double.parse(formData['tax2']) +
            double.parse(formData['tax3']),
        description: formData['description'],
        stayDay: DateTime.now(),
        transactionDay: DateTime.now(),
        // Set other fields as needed
      );
      widget.onSave(newTransaction);
    }
  }
}