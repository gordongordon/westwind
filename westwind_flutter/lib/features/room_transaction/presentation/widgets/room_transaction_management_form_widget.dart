import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/core/utils/form/form_helpers.dart';
import 'package:westwind_flutter/core/widgets/app_form_fields.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/utils/form/app_validators.dart';

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
  final TextEditingController descriptionController =
      TextEditingController(text: "");
  final TextEditingController approvedCodeController =
      TextEditingController(text: "");

  DateTime stayDay = TimeManager.instance.today();
  DateTime transactionDay = TimeManager.instance.now();

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

    // Setup tax calculation listeners
    FormHelpers.setupTaxCalculationListeners(
      amountController: amountController,
      tax1Controller: tax1Controller,
      tax2Controller: tax2Controller,
      totalController: totalController,
      calculateTaxesAutomatically: false, // Set based on your requirement
    );
  }

  @override
  void dispose() {
    // Clean up listeners
    FormHelpers.cleanupTaxCalculationListeners(
      amountController: amountController,
      tax1Controller: tax1Controller,
      tax2Controller: tax2Controller,
    );
    super.dispose();
  }

  void _updateItemTypeOptions(String transactionType) {
    setState(() {
      if (transactionType == TransactionType.pay.name) {
        _currentItemTypeOptions = [
          ItemType.debit.name,
          ItemType.cash.name,
          ItemType.visa.name,
          ItemType.master.name,
          ItemType.amex.name,
          ItemType.eTransfer.name,
          ItemType.gift_card.name,
          ItemType.laundry.name,
        ];
      } else if (transactionType == TransactionType.charge.name) {
        _currentItemTypeOptions = [
          ItemType.laundry.name,
          ItemType.room.name,
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
          ItemType.amex.name,
          ItemType.eTransfer.name,
          ItemType.gift_card.name,
        ];
      } else if (transactionType == TransactionType.refund.name) {
        _currentItemTypeOptions = [
          ItemType.debit.name,
          ItemType.cash.name,
          ItemType.visa.name,
          ItemType.master.name,
          ItemType.amex.name,
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
              AppFormFields.buildActionButton(
                text: "Save Room Transaction",
                onPressed: _saveRoomTransaction,
                color: Colors.green,
                icon: Icons.save,
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
        AppFormFields.buildSectionHeader(context, 'Create a new transaction'),
        AppFormFields.buildDropdown(
          name: 'transactionType',
          label: 'Transaction Type',
          options: _transactionTypeOptions,
          initialValue: transactionTypeController.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                transactionTypeController.text = value;
                _updateItemTypeOptions(value);
              });
            }
          },
          prefixIcon: Icons.swap_horiz,
        ),
        AppFormFields.buildMoneyField(
          name: 'amount',
          label: 'Amount',
          controller: amountController,
          onChanged: (value) => FormHelpers.calculateTaxesFromAmount(
            amountController: amountController,
            tax1Controller: tax1Controller,
            tax2Controller: tax2Controller,
            totalController: totalController,
          ),
        ),
        AppFormFields.buildDropdown(
          name: 'itemType',
          label: 'Item Type',
          options: _currentItemTypeOptions,
          initialValue: itemTypeController.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                itemTypeController.text = value;
              });
            }
          },
          prefixIcon: Icons.category,
        ),
        AppFormFields.buildTextField(
          name: 'approvedCode',
          label: 'Approved Code',
          controller: approvedCodeController,
          // Using our makeOptional wrapper to ensure validation only happens if input is provided
          validator: AppValidators.approvedCodeValidator,
          required: false,
          prefixIcon: Icons.check_circle,
        ),
        AppFormFields.buildNoteField(
          name: 'description',
          label: 'Description',
          controller: descriptionController,
          required: false,
          // Using requiredNoteValidator with makeOptional to validate only when text is provided
          validator: AppValidators.requiredNoteValidator,
        ),
      ],
    );
  }

  Widget _buildTransactionDetailsSection() {
    final guestName = widget.roomTransaction?.guest != null 
        ? "${widget.roomTransaction!.guest!.firstName} ${widget.roomTransaction!.guest!.lastName}" 
        : "Unknown Guest";
    final roomNumber = widget.roomTransaction?.roomId != null 
        ? "Room # ${widget.roomTransaction!.roomId}" 
        : "";
    final sectionTitle = "Transaction Details - $guestName $roomNumber";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, sectionTitle),
        AppFormFields.buildIdField(
          name: 'id',
          label: 'Transaction ID',
          controller: idController,
          enabled: false,
          validator: AppValidators.transactionIdValidator,
        ),
        AppFormFields.buildDateTimePicker(
          name: 'stayDay',
          label: 'Stay Day',
          initialValue: stayDay,
          inputType: InputType.date,
        ),
        AppFormFields.buildDateTimePicker(
          name: 'transactionDay',
          label: 'Transaction Day',
          initialValue: transactionDay,
          inputType: InputType.date,
        ),
        AppFormFields.buildIdField(
          name: 'roomId',
          label: 'Room ID',
          controller: roomIdController,
          validator: AppValidators.roomIdValidator,
        ),
        AppFormFields.buildIdField(
          name: 'guestId',
          label: 'Guest ID',
          controller: guestIdController,
          validator: AppValidators.guestIdValidator,
        ),
        AppFormFields.buildDropdown(
          name: 'transactionType',
          label: 'Transaction Type',
          options: _transactionTypeOptions,
          initialValue: transactionTypeController.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                transactionTypeController.text = value;
                _updateItemTypeOptions(value);
              });
            }
          },
          prefixIcon: Icons.swap_horiz,
        ),
      ],
    );
  }

  Widget _buildFinancialDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Financial Details'),
        AppFormFields.buildMoneyField(
          name: 'amount',
          label: 'Amount',
          controller: amountController,
          validator: AppValidators.amountValidator,
          onChanged: (value) => FormHelpers.calculateTaxesFromAmount(
            amountController: amountController,
            tax1Controller: tax1Controller,
            tax2Controller: tax2Controller,
            totalController: totalController,
          ),
        ),
        AppFormFields.buildMoneyField(
          name: 'tax1',
          label: 'GST (Tax 1)',
          controller: tax1Controller,
          validator: AppValidators.taxValidator,
        ),
        AppFormFields.buildMoneyField(
          name: 'tax2',
          label: 'Levy (Tax 2)',
          controller: tax2Controller,
          validator: AppValidators.taxValidator,
        ),
        AppFormFields.buildMoneyField(
          name: 'total',
          label: 'Total',
          controller: totalController,
          validator: AppValidators.totalValidator,
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Additional Information'),
        AppFormFields.buildIdField(
          name: 'roomGuestId',
          label: 'Room Guest ID',
          controller: roomGuestIdController,
          validator: AppValidators.reservationIdValidator,
        ),
        AppFormFields.buildDropdown(
          name: 'itemType',
          label: 'Item Type',
          options: _currentItemTypeOptions,
          initialValue: itemTypeController.text,
          onChanged: (value) {
            if (value != null) {
              setState(() {
                itemTypeController.text = value;
              });
            }
          },
          prefixIcon: Icons.category,
        ),
        AppFormFields.buildTextField(
          name: 'approvedCode',
          label: 'Approved Code',
          controller: approvedCodeController,
          validator: AppValidators.approvedCodeValidator,
          required: false,
          prefixIcon: Icons.check_circle,
        ),
        AppFormFields.buildNoteField(
          name: 'description',
          label: 'Description',
          controller: descriptionController,
          required: false,
        ),
      ],
    );
  }

  void _saveRoomTransaction() {
    if (FormHelpers.validateForm(formKey, context)) {
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
      late double cost;

      switch (transactionType) {
        case TransactionType.refund:
          sign = 1;
          break;
        case TransactionType.deposit:
          sign = -1;
          break;
        case TransactionType.pay:
          sign = -1;
          break;
        case TransactionType.charge:
          sign = 1;
          break;
        case TransactionType.adjustCredit:
          sign = -1;
          break;
        case TransactionType.adjustDebit:
          sign = 1;
          break;
        default:
          throw Exception('Unknown transaction type: $transactionType');
      }

      switch (itemType) {
        case ItemType.room:
        case ItemType.room_adjust:
          {
            cost = (amount / 1.09);
            gst = (cost * 0.05);
            levy = (cost * 0.04);
          }
          break;
        case ItemType.food:
        case ItemType.laundry:
        case ItemType.pet:
          gst = (amount * 0.05);
          levy = 0;
          break;
        case ItemType.vending:
        case ItemType.atm:
        case ItemType.demage:
        case ItemType.deposite:
        case ItemType.other:
        case ItemType.visa:
        case ItemType.master:
        case ItemType.amex:
        case ItemType.cash:
        case ItemType.eTransfer:
        case ItemType.gift_card:
        case ItemType.debit:
          gst = 0;
          levy = 0;
          break;
        default:
          throw Exception('Unknown item type: $itemType');
      }

      if (itemType == ItemType.room_adjust) {
        total = amount;
        amount = cost;
      } else {
        total = (amount + gst + levy);
      }

      final totalFinal = (total * sign).roundToTwoDecimals();
      final amountFinal = (amount * sign).roundToTwoDecimals();
      final gstFinal = gst.roundToTwoDecimals();
      final levyFinal = levy.roundToTwoDecimals();

      final roomTransaction = RoomTransaction(
        id: widget.roomTransaction?.id,
        guestId: int.parse(guestIdController.text),
        roomId: int.parse(roomIdController.text),
        roomGuestId: int.parse(roomGuestIdController.text),
        stayDay: finalStayDay,
        transactionDay: transactionDay,
        transactionType: transactionType,
        amount: amountFinal,
        tax1: gstFinal,
        tax2: levyFinal,
        total: totalFinal,
        description: descriptionController.text,
        itemType: itemType,
        approvedCode: approvedCodeController.text,
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
    transactionDay = transaction.transactionDay;
    stayDay = transaction.stayDay;
    descriptionController.text = transaction.description;
    approvedCodeController.text = transaction.approvedCode!;

    _updateItemTypeOptions(transaction.transactionType.name);
  }
}