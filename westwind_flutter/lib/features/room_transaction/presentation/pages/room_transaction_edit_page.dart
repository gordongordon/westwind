import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_list/room_guest_list_bloc.dart';
import 'package:westwind_flutter/features/room_guest/presentation/bloc/room_guest_manage/room_guest_manage_bloc.dart';
import 'package:westwind_flutter/features/room_transaction/presentation/bloc/room_transaction_list_bloc.dart';

class RoomTransactionEditPage extends StatefulWidget {
  final int? roomTransactionId;
  static String route([int? roomTransactionId]) =>
      "/roomtransactions/edit/${roomTransactionId ?? ':id'}";
  static String routeNew() => "/roomtransactions/new";

  const RoomTransactionEditPage({super.key, this.roomTransactionId});

  @override
  State<RoomTransactionEditPage> createState() =>
      _RoomTransactionEditPageState();
}

class _RoomTransactionEditPageState extends State<RoomTransactionEditPage> {
  final formkey = GlobalKey<FormBuilderState>();

  final idController = TextEditingController(text: "0");
  final roomIdController = TextEditingController();
  final guestIdController = TextEditingController();
  final roomGuestIdController = TextEditingController();
  var stayDate = DateTime.now();
  var transactionDay = DateTime.now();

  final transactionTypeController = TextEditingController();
  final itemTypeController = TextEditingController();
  final amountController = TextEditingController();
  final tax1Controller = TextEditingController();
  final tax2Controller = TextEditingController();
  final tax3Controller = TextEditingController();
  final totalController = TextEditingController();

  final descriptionController = TextEditingController();

  // bool isInHouse = false;

  final List<String> _transactionTypeOptions =
      TransactionType.values.map((e) => e.name).toList();

  final List<String> _itemTypeOptions =
      ItemType.values.map((e) => e.name).toList();

  bool _genderHasError = false;

  void _onChanged(dynamic val) => debugPrint(val.toString());

  bool get isEditing {
    return widget.roomTransactionId != null && widget.roomTransactionId! > 0;
  }

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      print("isEditing ");
      print(widget.roomTransactionId);
      context
          .read<RoomGuestManageBloc>()
          .add(RetrieveRoomGuest(widget.roomTransactionId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RoomTransaction Edit Page ${widget.roomTransactionId}"),
          actions: [
            IconButton(
              onPressed: () {
                formkey.currentState?.saveAndValidate();
                debugPrint(formkey.currentState!.validate().toString());
                if (formkey.currentState!.validate()) {
                  //    debugPrint( " here");
                  final TransactionType transactionType = TransactionType.values
                      .byName(formkey
                          .currentState!.fields['transactionType']!.value);

                  final ItemType itemType = ItemType.values
                      .byName(formkey.currentState!.fields['itemType']!.value);
                  final roomTransaction = RoomTransaction(
                      id: widget.roomTransactionId,
                      guestId: int.parse(guestIdController.text),
                      roomId: int.parse(roomIdController.text),
                      roomGuestId: int.parse(roomGuestIdController.text),
                      stayDay: stayDate,
                      transactionDay: DateTime.now(),
                      transactionType: TransactionType.charge,
                      amount: double.parse(amountController.text),
                      tax1: double.parse(tax1Controller.text),
                      tax2: double.parse(tax2Controller.text),
                      tax3: double.parse(tax3Controller.text),
                      total: double.parse(totalController.text),
                      description: descriptionController.text,
                      itemType: itemType);

                  // debugPrint(" after RoomGuest final ");
                  // debugPrint(roomTransaction.toString());
                  //! todo
                  context.read<RoomTransactionListBloc>().add(
                      CreateRoomTransactionListEvent(
                          roomTransaction: roomTransaction));
                }
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        body: BlocConsumer<RoomTransactionListBloc, RoomTransactionListState>(
            listener: (context, state) {
          if (state is RoomTransactionListStateFailure) {
            showSnackbar(context, state.message);
          } else if (state is RoomTransactionListStateCreatedSuccess) {
            context
                .read<RoomTransactionListBloc>()
                .add(FetchRoomTransactionsListEvent());
            context.pop();
            context.pop();

            if (isEditing) {
              //! May have problem
              context.read<RoomTransactionListBloc>().add(
                  RetrieveRoomTransactionListEvent(
                      id: widget.roomTransactionId!));
            }

            context.pop();
          } else if (state is RoomTransactionListStateDeletedSuccess) {
            context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());
            context.pop();
            context.pop();
          } else if (state is RoomTransactionListStateRetrievedSuccess) {
            /*
            final roomRoomTransactions = state.roomTransactionroomTransactions;

            if (roomRoomTransactions != null) {
              final roomGuestId = state.roomTransaction.id;
              final length = roomRoomTransactions.length;
              debugPrint(
                  "RoomTransactions size = $length roomGuest id = $roomGuestId");
            }
            */

            debugPrint("RoomTransactionManageState RetrieveSuccess ");

            idController.text = state.roomTransaction.id!.toString();
            guestIdController.text = state.roomTransaction.guestId.toString();
            roomIdController.text = state.roomTransaction.roomId.toString();

            amountController.text = state.roomTransaction.amount.toString();
            tax1Controller.text = state.roomTransaction.tax1.toString();
            tax2Controller.text = state.roomTransaction.tax2.toString();
            tax3Controller.text = state.roomTransaction.tax3.toString();
            totalController.text = state.roomTransaction.total.toString();

            //   Controller.text = state.roomTransaction..toString();
            transactionTypeController.text =
                state.roomTransaction.transactionType.toString();
            itemTypeController.text = state.roomTransaction.itemType.toString();

            transactionDay = state.roomTransaction.transactionDay.toLocal();
            stayDate = state.roomTransaction.stayDay!;
            descriptionController.text = state.roomTransaction.description;

            // updatedDate = state.roomTransaction.updateDate!;

            //    final type = state.roomTransaction.rateType;
            //    final reason = state.roomTransaction.rateReason;
            //    context.read<RoomGuestManageBloc>().add( CalculateRate(type: type, reason: reason) );
          }
        }, builder: (context, state) {
          if (state is RoomGuestManageStateLoading) {
            return const Loader();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: formkey,
                child: Column(
                  children: [
                    //

                    FormBuilderTextField(
                      name: 'id',
                      enabled: false,
                      //  readOnly: true,
                      controller: idController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(labelText: 'ID'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    //  const SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      name: 'stayDate',
                      decoration: const InputDecoration(labelText: 'Stay Date'),
                      initialValue: stayDate,
                      initialDate: DateTime.now().add(const Duration(days: 10)),
                      initialDatePickerMode: DatePickerMode.day,
                      timePickerInitialEntryMode: TimePickerEntryMode.input,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      inputType: InputType.date,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    //   const SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      name: 'transactionDay',
                      initialValue: transactionDay,
                      decoration:
                          const InputDecoration(labelText: 'Transaction Date'),
                      initialDatePickerMode: DatePickerMode.day,
                      timePickerInitialEntryMode: TimePickerEntryMode.input,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      inputType: InputType.date,
                    ),
                    //     const SizedBox(height: 10),
                      const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'Room Id',
                      maxLength: 11,
                      controller: roomIdController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(labelText: 'Room Id'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),

                        //     FormBuilderValidators.minWordsCount(10,
                        //        allowEmpty: false, errorText: 'e.g. 17805425375'),
                      ])),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'Guest Id',
                      maxLength: 11,
                      controller: guestIdController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(labelText: 'Guest Id'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),

                        //     FormBuilderValidators.minWordsCount(10,
                        //        allowEmpty: false, errorText: 'e.g. 17805425375'),
                      ]),
                    //    const SizedBox(height: 10),
  
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDropdown<String>(
                      name: 'transactionType',
                      initialValue: transactionTypeController.text,
                      decoration: InputDecoration(
                        labelText: 'TransactionType',
                        suffix: _genderHasError
                            ? const Icon(Icons.error)
                            : const Icon(Icons.check),
                        hintText: 'Select Transaction Type',
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: _transactionTypeOptions
                          .map((rateType) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: rateType,
                                child: Text(rateType),
                              ))
                          .toList(),
                      onChanged: (val) {
                        formkey.currentState?.fields['trannsactionType']?.save();
                        //    newRate = ref.read(rateTableProvider( RateTable(rateType: rateType, rateReason: rateReason, rate: 0.00 )  ));
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    //        const SizedBox(height: 10),

                    FormBuilderTextField(
                      name: 'amount',
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'amount'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                                     FormBuilderTextField(
                      name: 'tax1',
                                            controller: tax1Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'tax1'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),                
                       FormBuilderTextField(
                      name: 'tax2',
                      controller: tax2Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'tax2'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),                  
                    
                     FormBuilderTextField(
                      name: 'tax3',
                      controller: tax3Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'tax3'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                     ),

                                           FormBuilderTextField(
                      name: 'total',
                      controller: totalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'total'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),     
                    FormBuilderTextField(
                        name: 'roomGuestId',
                        controller: guestIdController,
                        decoration: const InputDecoration(labelText: 'roomGuestId'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric(),
                        ]),
                        onChanged: (value) {
                          if (value != null) {
                            //     context.read<RoomGuestManageBloc>().add(
                            //        RetrieveGuestForRoomGuest(
                            //           id: int.parse(value)));
                          }
                        }),
                 
      
                    const SizedBox(height: 10),
                    FormBuilderDropdown<String>(
                      name: 'itemType',
                      initialValue: itemTypeController.text,
                      decoration: InputDecoration(
                        labelText: 'ItemType',
                        suffix: _genderHasError
                            ? const Icon(Icons.error)
                            : const Icon(Icons.check),
                        hintText: 'Select ItemType',
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: _itemTypeOptions
                          .map((rateType) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: rateType,
                                child: Text(rateType),
                              ))
                          .toList(),
                      onChanged: (val) {
                        formkey.currentState!.fields['itemType']?.save();
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),

                   
                    if (isEditing)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<RoomGuestManageBloc>().add(
                                  ChargeAndExtendStayDay(
                                      id: widget.roomTransactionId!));
                            },
                            child: const Text("Charge & Extend")),
                      ),
                    if (isEditing)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                            //  context
                             //     .read<RoomTransactionListBloc>()
                              //    .add(DeleteRoomGuest(widget.roomTransactionId!));
                            },
                            child: const Text("Delete")),
                      ),
                    if (isEditing)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                           //   context.read<RoomTransactionListBloc>().add(
                            //      CalculateRateRoomGuest(widget.roomTransactionId!));
                            },
                            child: const Text("Calculate Rate")),
                      ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
