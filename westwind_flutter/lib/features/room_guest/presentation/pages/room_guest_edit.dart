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

class RoomGuestEditPage extends StatefulWidget {
  final int? roomGuestId;
  static String route([int? roomGuestId]) =>
      "/roomguests/edit/${roomGuestId ?? ':id'}";
  static String routeNew() => "/roomguests/new";

  const RoomGuestEditPage({super.key, this.roomGuestId});

  @override
  State<RoomGuestEditPage> createState() => _RoomGuestEditPageState();
}

class _RoomGuestEditPageState extends State<RoomGuestEditPage> {
  final formkey = GlobalKey<FormBuilderState>();
  final roomIdController = TextEditingController();
  final guestIdController = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final rateTypeController = TextEditingController();
  final idController = TextEditingController(text: "0");
  final rigNumberController = TextEditingController();
  final rateController = TextEditingController();
  final rateReasonController = TextEditingController();
  final reservationIdController = TextEditingController();

  var stayDate = DateTime.now();
  var updatedDate = DateTime.now();
  var checkOutDate = DateTime.now();
  bool isCheckOut = false;

  // bool isInHouse = false;

  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();

  bool _genderHasError = false;

  void _onChanged(dynamic val) => debugPrint(val.toString());

  bool get isEditing {
    return widget.roomGuestId != null && widget.roomGuestId! > 0;
  }

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      print("isEditing ");
      print(widget.roomGuestId);
      context
          .read<RoomGuestManageBloc>()
          .add(RetrieveRoomGuest(widget.roomGuestId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RoomGuest Edit Page ${widget.roomGuestId}"),
          actions: [
            IconButton(
              onPressed: () {
                formkey.currentState?.saveAndValidate();
                debugPrint(formkey.currentState!.validate().toString());
                if (formkey.currentState!.validate()) {
                  //    debugPrint( " here");
                  final RateType rateType = RateType.values
                      .byName(formkey.currentState!.fields['rateType']!.value);

                  final RateReason rateReason = RateReason.values.byName(
                      formkey.currentState!.fields['rateReason']!.value);

                  final roomGuest = RoomGuest(
                    id: widget.roomGuestId,
                    guestId: int.parse(guestIdController.text),
                    roomId: int.parse(roomIdController.text),
                    stayDate: formkey.currentState!.fields['stayDate']!.value,
                    updateDate:
                        formkey.currentState!.fields['updateDate']!.value,
                    checkInDate: DateTime.now().getDateOnly(),
                    checkOutDate:
                        formkey.currentState!.fields['checkOutDate']!.value,
                    rateType: rateType,
                    rate: double.parse(rateController.text),
                    rateReason: rateReason,
                    roomStatus: RoomStatus.change,
                    reservationId: int.parse(reservationIdController.text),
                    isCheckOut: isCheckOut,
                  );

                  // debugPrint(" after RoomGuest final ");
                  // debugPrint(RoomGuest.toString());
                  //! todo
                  context
                      .read<RoomGuestManageBloc>()
                      .add(SaveRoomGuest(roomGuest));
                }
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        body: BlocConsumer<RoomGuestManageBloc, RoomGuestManageState>(
            listener: (context, state) {
          if (state is RoomGuestManageStateFailure) {
            showSnackbar(context, state.message);
          } else if (state is RoomGuestManageStateSaveSuccess) {
            context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());
            //      context.pop();
            context.pop();
            /*
            if (isEditing) {
              //! May have problem
              context
                  .read<RoomGuestManageBloc>()
                  .add(RetrieveRoomGuest(widget.roomGuestId!));
            }
*/
            //  context.pop();
          } else if ( state is RoomGuestManageStateCalculateRateSuccess ) {
            context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());
            context.pop();
          //  context.pop();
          }
          
          else if (state is RoomGuestManageStateDeleteSuccess) {
            context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());
            context.pop();
         //   context.pop();
          } else if (state
              is RoomGuestManageStateChargeAndExtendStayDaySuccess) {
            context.read<RoomGuestListBloc>().add(FetchRoomGuestsEvent());
            context.pop();
          //  context.pop();
          } else if (state is RoomGuestManageStateRetrieveSuccess) {
            final roomRoomTransactions = state.roomGuest.roomTransactions;

            if (roomRoomTransactions != null) {
              final roomGuestId = state.roomGuest.id;
              final length = roomRoomTransactions.length;
              debugPrint(
                  "RoomTransactions size = $length roomGuest id = $roomGuestId");
            }

            debugPrint("RoomGuestManageState RetrieveSuccess ");
            idController.text = state.roomGuest.id!.toString();
            guestIdController.text = state.roomGuest.guestId.toString();
            roomIdController.text = state.roomGuest.roomId.toString();
            rateController.text = state.roomGuest.rate.toString();

            rateReasonController.text = state.roomGuest.rateReason.toString();
            rateTypeController.text = state.roomGuest.rateType.toString();

            firstNameController.text = state.roomGuest.guest!.firstName;
            lastNameController.text = state.roomGuest.guest!.lastName;
            reservationIdController.text =
                state.roomGuest.reservationId.toString();

            checkOutDate = state.roomGuest.checkOutDate;
            rigNumberController.text =
                state.roomGuest.guest!.rigNumber.toString();

            stayDate = state.roomGuest.stayDate;
            isCheckOut = state.roomGuest.isCheckOut;
            // updatedDate = state.roomGuest.updateDate!;

            //    final type = state.roomGuest.rateType;
            //    final reason = state.roomGuest.rateReason;
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
                      name: 'checkOutDate',
                      initialValue: checkOutDate,
                      decoration:
                          const InputDecoration(labelText: 'Check Out Date'),
                      initialDatePickerMode: DatePickerMode.day,
                      timePickerInitialEntryMode: TimePickerEntryMode.input,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      inputType: InputType.date,
                    ),
                    //     const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'lastName',
                      // enabled: false,
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'firstName',
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderSwitch(
                      title: const Text('Is Check Out'),
                      initialValue: isCheckOut,
                      name: 'isCheckOut',
                      onChanged: _onChanged,
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'Reservation Id',
                      maxLength: 11,
                      controller: reservationIdController,
                      keyboardType: TextInputType.phone,
                      decoration:
                          const InputDecoration(labelText: 'Reservation ID'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),

                        //     FormBuilderValidators.minWordsCount(10,
                        //        allowEmpty: false, errorText: 'e.g. 17805425375'),
                      ]),
                      onChanged: (value) {
                        if (formkey
                            .currentState!.fields['phone']!.valueIsValid) {
                          if (value != null) {
                            //  context.read<RoomGuestManageBloc>().add(
                            //     RetrieveGuestByPhoneForRoomGuest(
                            //         phone: value.trim()));
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDropdown<String>(
                      name: 'rateReason',
                      initialValue: rateReasonController.text,
                      decoration: InputDecoration(
                        labelText: 'RateReason',
                        suffix: _genderHasError
                            ? const Icon(Icons.error)
                            : const Icon(Icons.check),
                        hintText: 'Select RateReason',
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: _rateReasonOptions
                          .map((rateType) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: rateType,
                                child: Text(rateType),
                              ))
                          .toList(),
                      onChanged: (val) {
                        formkey.currentState?.fields['rateReason']?.save();
                        //    newRate = ref.read(rateTableProvider( RateTable(rateType: rateType, rateReason: rateReason, rate: 0.00 )  ));
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),
                    //        const SizedBox(height: 10),

                    FormBuilderTextField(
                      name: 'rate',
                      controller: rateController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'rate'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    FormBuilderTextField(
                        name: 'guestId',
                        controller: guestIdController,
                        decoration: const InputDecoration(labelText: 'guestId'),
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
                    FormBuilderTextField(
                      name: 'roomId',
                      controller: roomIdController,
                      decoration: const InputDecoration(labelText: 'roomId'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'rigNumber',
                      controller: rigNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(labelText: 'rigNumber'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderDropdown<String>(
                      name: 'rateType',
                      initialValue: rateTypeController.text,
                      decoration: InputDecoration(
                        labelText: 'RateType',
                        suffix: _genderHasError
                            ? const Icon(Icons.error)
                            : const Icon(Icons.check),
                        hintText: 'Select RateType',
                      ),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required()]),
                      items: _rateTypeOptions
                          .map((rateType) => DropdownMenuItem(
                                alignment: AlignmentDirectional.center,
                                value: rateType,
                                child: Text(rateType),
                              ))
                          .toList(),
                      onChanged: (val) {
                        formkey.currentState!.fields['rateType']?.save();
                      },
                      valueTransformer: (val) => val?.toString(),
                    ),

                    const SizedBox(height: 10),
                    FormBuilderDateTimePicker(
                      name: 'updateDate',
                      enabled: false,
                      decoration:
                          const InputDecoration(labelText: 'Update Date'),
                      initialValue: updatedDate,
                      initialDatePickerMode: DatePickerMode.day,
                      timePickerInitialEntryMode: TimePickerEntryMode.input,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      inputType: InputType.date,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    if (isEditing)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<RoomGuestManageBloc>().add(
                                  ChargeAndExtendStayDay(
                                      id: widget.roomGuestId!));
                            },
                            child: const Text("Charge & Extend")),
                      ),
                    if (isEditing)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<RoomGuestManageBloc>().add(
                                  CalculateRateRoomGuest(widget.roomGuestId!));
                            },
                            child: const Text("Calculate Rate")),
                      ),
                    if (isEditing)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RoomGuestManageBloc>()
                                  .add(DeleteRoomGuest(widget.roomGuestId!));
                            },
                            child: const Text("Delete")),
                      ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
