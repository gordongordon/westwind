import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:westwind_client/westwind_client.dart';

class RoomTransactionManagementFormWidget extends StatefulWidget {
  final RoomTransaction? roomTransaction;
  final RoomGuest? roomGuest;
  final Function(RoomTransaction) onSave;

  const RoomTransactionManagementFormWidget({
    super.key,
    this.roomTransaction,
    this.roomGuest,
    required this.onSave,
  });

  @override
  State<RoomTransactionManagementFormWidget> createState() =>
      _RoomTransactionManagementFormWidgetState();
}

class _RoomTransactionManagementFormWidgetState
    extends State<RoomTransactionManagementFormWidget> {
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
  final TextEditingController totalController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime stayDay = DateTime.now();
  DateTime transactionDay = DateTime.now().toLocal();

  final List<String> _transactionTypeOptions =
      TransactionType.values.map((e) => e.name).toList();
  final List<String> _allItemTypeOptions =
      ItemType.values.map((e) => e.name).toList();
  List<String> _currentItemTypeOptions = [];

  @override
  void initState() {
    super.initState();
    if (widget.roomTransaction != null) {
      _populateFields(widget.roomTransaction!);
      
    } else if (widget.roomGuest != null) {
      final roomGuest = widget.roomGuest!;
      roomGuestIdController.text = roomGuest.id.toString();
      guestIdController.text = roomGuest.guestId.toString();
      roomIdController.text = roomGuest.roomId.toString();
      stayDay = roomGuest.stayDay;
      itemTypeController.text = ItemType.other.name;
      transactionTypeController.text = TransactionType.pay.name;
    }
    _updateItemTypeOptions(transactionTypeController.text);
  }

  void _updateItemTypeOptions(String transactionType) {
    setState(() {
      if (transactionType == TransactionType.pay.name) {
        _currentItemTypeOptions = [
          ItemType.debit.name,
          ItemType.cash.name,
          ItemType.visa.name,
          ItemType.master.name,
          ItemType.eTransfer.name,
          ItemType.gift_card.name,
        ];
      } else if (transactionType == TransactionType.charge.name) {
        _currentItemTypeOptions = [
          ItemType.laundry.name,
          ItemType.room_adjust.name,
          ItemType.pet.name,
          ItemType.atm.name,
          ItemType.demage.name,
          ItemType.food.name,
          ItemType.other.name,
          ItemType.vending.name,
        ];
      } else if (transactionType == TransactionType.deposit.name) {
        _currentItemTypeOptions = [
          ItemType.debit.name,
          ItemType.cash.name,
          ItemType.visa.name,
          ItemType.master.name,
          ItemType.eTransfer.name,
          ItemType.gift_card.name,
        ];
      } else if (transactionType == TransactionType.refund.name) {
        _currentItemTypeOptions = [
          ItemType.debit.name,
          ItemType.cash.name,
          ItemType.visa.name,
          ItemType.master.name,
          ItemType.eTransfer.name,
          ItemType.gift_card.name,
        ];
      } else if (transactionType == TransactionType.adjustCredit.name) {
        _currentItemTypeOptions = [
          ItemType.laundry.name,
          ItemType.room_adjust.name,
          ItemType.pet.name,
          ItemType.atm.name,
          ItemType.demage.name,
          ItemType.food.name,
          ItemType.other.name,
          ItemType.vending.name,
        ];
      } else if (transactionType == TransactionType.adjustDebit.name) {
        _currentItemTypeOptions = [
          ItemType.laundry.name,
          ItemType.room_adjust.name,
          ItemType.pet.name,
          ItemType.atm.name,
          ItemType.demage.name,
          ItemType.food.name,
          ItemType.other.name,
          ItemType.vending.name,
        ];
      } else {
        _currentItemTypeOptions = _allItemTypeOptions;
      }

      // Ensure the current itemType is valid for the new options
      if (!_currentItemTypeOptions.contains(itemTypeController.text)) {
        itemTypeController.text = _currentItemTypeOptions.first;
      }
    });
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
              if (widget.roomGuest != null)
                _buildRoomGuestDetailsSection()
              else ...[
                _buildTransactionDetailsSection(),
                _buildFinancialDetailsSection(),
                _buildAdditionalInfoSection(),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveRoomTransaction,
                child: const Text('Save Room 33 Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildRoomGuestDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Transaction Details',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildDropdown(
          'transactionType',
          'Transaction Type',
          _transactionTypeOptions,
          initialValue: transactionTypeController.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                transactionTypeController.text = value;
                _updateItemTypeOptions(value);
              });
            }
          },
        ),
        _buildTextField('amount', 'Amount', amountController,
            keyboardType: TextInputType.number),
        _buildDropdown('itemType', 'Item Type', _currentItemTypeOptions,
            initialValue: itemTypeController.text, onChanged: (value) {
          if (value != null) {
            setState(() {
              itemTypeController.text = value;
            });
          }
        }),
        _buildTextField('description', 'Description', descriptionController,
            maxLines: 3),
      ],
    );
  }
  

  Widget _buildTransactionDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //! This can be null //
        Text('Transaction Details -  ${widget.roomTransaction!.guest != null ? "${widget.roomTransaction!.guest!.firstName} ${widget.roomTransaction!.guest!.lastName} - Room # ${widget.roomTransaction!.roomId}"  : "Unknow Guest Name"}',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('id', 'Transaction ID', idController, enabled: false),
        _buildDateTimePicker('stayDay', 'Stay Day', initialValue: stayDay),
        _buildDateTimePicker('transactionDay', 'Transaction Day',
            initialValue: transactionDay),
        _buildTextField('roomId', 'Room ID', roomIdController),
        _buildTextField('guestId', 'Guest ID', guestIdController),
        _buildDropdown(
          'transactionType',
          'Transaction Type',
          _transactionTypeOptions,
          initialValue: transactionTypeController.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                transactionTypeController.text = value;
                _updateItemTypeOptions(value);
              });
            }
          },
        ),
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
        _buildDropdown('itemType', 'Item Type', _currentItemTypeOptions,
            initialValue: itemTypeController.text, onChanged: (value) {
          if (value != null) {
            setState(() {
              itemTypeController.text = value;
            });
          }
        }),
        _buildTextField('description', 'Description', descriptionController,
            maxLines: 3),
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
      {required String initialValue, void Function(String?)? onChanged}) {
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
        onChanged: onChanged,
      ),
    );
  }

  void _saveRoomTransaction() {
    if (formKey.currentState!.saveAndValidate()) {
      final transactionType = TransactionType.values
          .byName(formKey.currentState!.fields['transactionType']!.value);
      final itemType = ItemType.values
          .byName(formKey.currentState!.fields['itemType']!.value);
      final finalStayDay = widget.roomGuest == null
          ? formKey.currentState!.fields['stayDay']!.value
          : stayDay;

      var amount = double.parse(amountController.text);
      late double gst;
      late double levy;
      late double total;
      late double sign;

      switch (transactionType) {
        case TransactionType.deposit:
        case TransactionType.pay:
        case TransactionType.refund:
        case TransactionType.adjustCredit:
          sign = -1;
        case TransactionType.charge:
        case TransactionType.adjustDebit:
          sign = 1;
      }

      switch (itemType) {
        case ItemType.room:
        case ItemType.room_adjust:
          gst = amount * 0.05;
          levy = amount * 0.04;
        case ItemType.food:
        case ItemType.laundry:
        case ItemType.pet:
          gst = amount * 0.05;
          levy = 0;
        case ItemType.vending:
        case ItemType.atm:
        case ItemType.demage:
        case ItemType.deposite:
        case ItemType.other:
        case ItemType.visa:
        case ItemType.master:
        case ItemType.cash:
        case ItemType.eTransfer:
        case ItemType.gift_card:
        case ItemType.debit:
          gst = 0;
          levy = 0;
      }

      total = amount + gst + levy;
      final totalFinal = total * sign;
      final amountFinal = amount * sign;

      final roomTransaction = RoomTransaction(
        id: widget.roomTransaction?.id,
        guestId: int.parse(guestIdController.text),
        roomId: int.parse(roomIdController.text),
        roomGuestId: int.parse(roomGuestIdController.text),
        stayDay: finalStayDay,
        transactionDay: transactionDay,
        transactionType: transactionType,
        amount: amountFinal,
        tax1: gst,
        tax2: levy,
        total: totalFinal,
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
    amountController.text = transaction.amount.abs().toString();
    tax1Controller.text = transaction.tax1.toString();
    tax2Controller.text = transaction.tax2.toString();
    totalController.text = transaction.total.abs().toString();
    transactionTypeController.text = transaction.transactionType.name;
    itemTypeController.text = transaction.itemType.name;
    transactionDay = transaction.transactionDay.toLocal();
    stayDay = transaction.stayDay;
    descriptionController.text = transaction.description;

    _updateItemTypeOptions(transaction.transactionType.name);
  }
}
