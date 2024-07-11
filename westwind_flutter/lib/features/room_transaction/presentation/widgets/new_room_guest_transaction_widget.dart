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
  _RoomGuestTransactionFormWidgetState createState() =>
      _RoomGuestTransactionFormWidgetState();
}

class _RoomGuestTransactionFormWidgetState
    extends State<RoomGuestTransactionFormWidget> {
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
          /* 
          FormBuilderTextField(
            name: 'tax1',
            decoration: InputDecoration(labelText: 'GST'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
          ),
         // if ( _formKey.)

          FormBuilderTextField(
            name: 'tax2',
            decoration: InputDecoration(labelText: 'Levy'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
          ),
          */
          /*
          FormBuilderTextField(
            name: 'tax3',
            decoration: InputDecoration(labelText: 'Additional Tax'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.numeric(),
            ]),
            keyboardType: TextInputType.number,
          ),
          */

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
      final itemType = formData['itemType'] as ItemType;
      final amount = double.parse(formData['amount']);
      final tax1 = double.parse(formData['tax1']);
      final tax2 = double.parse(formData['tax2']);
      late double gst;
      late double levy;
      late double total;

      switch (itemType) {
        case ItemType.room:
          {
            gst = amount * 0.05;
            levy = amount * 0.04;
            total = amount + gst + levy;
          }
        case ItemType.food:
          {
            gst = amount * 0.05;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.laundry:
          {
            gst = amount * 0.05;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.vending:
          {
            gst = 0;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.atm:
          {
            gst = 0;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.pet:
          {
            gst = amount * 0.05;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.demage:
          {
            gst = 0;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.deposite:
          {
            gst = 0;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.other:
          {
            gst = 0;
            levy = 0;
            total = amount + gst + levy;
          }
        case ItemType.balance:
          {
            gst = 0;
            levy = 0;
            total = amount + gst + levy;
            total = total * -1;
          }
      }

      final newTransaction = RoomTransaction(
        guestId: widget.roomGuestId,
        roomGuestId: widget.roomGuestId,
        // Get 
        roomId: 101,
        transactionType: formData['transactionType'] as TransactionType,
        itemType: formData['itemType'] as ItemType,
        amount: amount,
        tax1: tax1,
        tax2: tax2,
       // tax3: 0,
        /*
        tax3: double.parse(formData['tax3']),
        */
        total: total,
        description: formData['description'],
        //! need to get stayDay from roomGuest,
        stayDay: DateTime.now(),
        transactionDay: DateTime.now(),
        // Set other fields as needed
      );
      widget.onSave(newTransaction);
    }
  }
}
