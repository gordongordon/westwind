import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';

class ReservationEditPage extends StatefulWidget {
  final int? reservationId;
  static String route([int? reservationId]) =>
      "/reservations/edit/${reservationId ?? ':id'}";
  static String routeNew() => "/reservations/new";

  const ReservationEditPage({super.key, this.reservationId});

  @override
  State<ReservationEditPage> createState() => _GuetEditPageState();
}

class _GuetEditPageState extends State<ReservationEditPage> {
  final formkey = GlobalKey<FormBuilderState>();
  final roomNumberController = TextEditingController();
  final roomIdController = TextEditingController();
  final guestIdController = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final rateTypeController = TextEditingController();
  final dateCreateController = TextEditingController();
  final idController = TextEditingController(text: "0");
  final rigNumberController = TextEditingController();
  bool isCheckedIn = false;
  bool isCanceled = false;
  bool isNightShift = false;
  final rateController = TextEditingController();
  final rateReasonController = TextEditingController();

  var dateCreate = DateTime.now();
  var dateUpdate = DateTime.now();
  var checkInDate = DateTime.now();
  var checkOutDate = DateTime.now();

  // bool isInHouse = false;

  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();

  bool _genderHasError = false;

  void _onChanged(dynamic val) => debugPrint(val.toString());

  bool get isEditing {
    return widget.reservationId != null && widget.reservationId! > 0;
  }

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      print("isEditing ");
      print(widget.reservationId);
      context
          .read<ReservationManageBloc>()
          .add(RetrieveReservation(id: widget.reservationId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reservation Edit Page ${widget.reservationId}"),
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

                  final reservation = Reservation(
                    id: widget.reservationId,
                    guestId: int.parse(guestIdController.text),
                    roomId: int.parse(roomIdController.text),
                    isCheckedIn:
                        formkey.currentState!.fields['isCheckedIn']!.value,
                    isCanceled:
                        formkey.currentState!.fields['isCanceled']!.value,
                    isNightShift:
                        formkey.currentState!.fields['isNightShift']!.value,
                    dateCreate:
                        formkey.currentState!.fields['dateCreate']!.value,
                    dateUpdate:
                        formkey.currentState!.fields['dateUpdate']!.value,
                    checkInDate:
                        formkey.currentState!.fields['checkInDate']!.value,
                    checkOutDate:
                        formkey.currentState!.fields['checkOutDate']!.value,
                    rateType: rateType,
                    rate: double.parse(rateController.text),
                    rateReason: rateReason,
                  );

                  debugPrint(" after Reservation final ");
                  debugPrint(reservation.toString());
                  context
                      .read<ReservationManageBloc>()
                      .add(SaveReservation(reservation: reservation));
                  context.pop();
                }
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        body: BlocConsumer<ReservationManageBloc, ReservationManageState>(
          listener: (context, state) {
            if (state is ReservationManageStateFailure) {
              showSnackbar(context, state.message);
            } else if (state is ReservationManageStateSaveSuccess) {
              context.read<ReservationListBloc>().add(FetchReservationsEvent());
              //  context.pop();
              if (isEditing) {
                //! May have problem
                context
                    .read<ReservationManageBloc>()
                    .add(RetrieveReservation(id: widget.reservationId!));
              }

              context.pop();
            } else if (state is ReservationManageStateDeleteSuccess) {
              context.read<ReservationListBloc>().add(FetchReservationsEvent());
              context.pop();
              context.pop();
            } else if (state is ReservationManageStateRetrieveSuccess) {
              debugPrint("ReservationManageState RetrieveSuccess ");
              idController.text = state.reservation.id!.toString();
              guestIdController.text = state.reservation.guestId.toString();
              roomIdController.text = state.reservation.roomId.toString();
              rateController.text = state.reservation.rate.toString();
              rateReasonController.text =
                  state.reservation.rateReason.toString();
              firstNameController.text = state.reservation.guest!.firstName;
              lastNameController.text = state.reservation.guest!.lastName;
              phoneController.text = state.reservation.guest!.phone;
              rateTypeController.text = state.reservation.rateType.toString();
              isCheckedIn = state.reservation.isCheckedIn;
              isCanceled = state.reservation.isCanceled;
              isNightShift = state.reservation.isNightShift;
              dateCreate = state.reservation.dateCreate;
              dateUpdate = state.reservation.dateUpdate!;
              checkInDate = state.reservation.checkInDate;
              checkOutDate = state.reservation.checkOutDate;
              rigNumberController.text =
                  state.reservation.guest!.rigNumber.toString();
            } else if (state is ReservationManageStateRetrieveGuestSuccess) {
              firstNameController.text = state.guest.firstName;
              lastNameController.text = state.guest.lastName;
              phoneController.text = state.guest.phone;
              rigNumberController.text = state.guest.rigNumber.toString();
              rateController.text = state.guest.rateType.toString();
            } else if (state
                is ReservationManageStateRetrieveGuestByPhoneSuccess) {
              firstNameController.text = state.guest.firstName;
              lastNameController.text = state.guest.lastName;
              phoneController.text = state.guest.phone;
              rigNumberController.text = state.guest.rigNumber.toString();
              rateController.text = state.guest.rateType.toString();
            } else if (state is ReservationManageStateCheckInSuccess) {
              context.read<ReservationListBloc>().add(FetchReservationsEvent());

              context.pop();
            }
          },
          builder: (context, state) {
            if (state is ReservationManageStateLoading) {
              return const Loader();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormBuilder(
                  key: formkey,
                  child: Column(
                    children: [
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
                        name: 'checkInDate',
                        decoration:
                            const InputDecoration(labelText: 'Check In Date'),
                        initialValue: checkInDate,
                        initialDate:
                            DateTime.now().add(const Duration(days: 10)),
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
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
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
                      FormBuilderTextField(
                        name: 'phone',
                        maxLength: 11,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(labelText: 'Phone'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(11),
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.equalLength(11),
                          //     FormBuilderValidators.minWordsCount(10,
                          //        allowEmpty: false, errorText: 'e.g. 17805425375'),
                        ]),
                        onChanged: (value) {
                          if (  formkey.currentState!.fields['phone']!.valueIsValid ) {
          
                           if ( value != null)  {
                            context.read<ReservationManageBloc>().add(
                                RetrieveGuestByPhoneForReservation(
                                    phone: value.trim()));
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
                          decoration:
                              const InputDecoration(labelText: 'guestId'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                          ]),
                          onChanged: (value) {
                            if (value != null) {
                              context.read<ReservationManageBloc>().add(
                                  RetrieveGuestForReservation(
                                      id: int.parse(value)));
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
                        decoration:
                            const InputDecoration(labelText: 'rigNumber'),
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
                      FormBuilderSwitch(
                        title: const Text('Is it check In?'),
                        initialValue: isCheckedIn,
                        name: 'isCheckedIn',
                        onChanged: _onChanged,
                      ),
                      FormBuilderSwitch(
                        title: const Text('Is it cancel?'),
                        initialValue: isCanceled,
                        name: 'isCanceled',
                        onChanged: _onChanged,
                      ),
                      FormBuilderSwitch(
                        title: const Text('Is it night shift?'),
                        initialValue: isNightShift,
                        name: 'isNightShift',
                        onChanged: _onChanged,
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDateTimePicker(
                        name: 'dateCreate',
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Date Created'),
                        initialValue: dateCreate,
                        initialDatePickerMode: DatePickerMode.day,
                        timePickerInitialEntryMode: TimePickerEntryMode.input,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        inputType: InputType.date,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDateTimePicker(
                        name: 'dateUpdate',
                        enabled: false,
                        decoration:
                            const InputDecoration(labelText: 'Date Updated'),
                        initialValue: dateUpdate,
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
                                context.read<ReservationManageBloc>().add(
                                    DeleteReservation(
                                        id: widget.reservationId!));
                              },
                              child: const Text("Delete")),
                        ),
                      if (isEditing)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                context.read<ReservationManageBloc>().add(
                                    CheckInReservation(
                                        id: widget.reservationId!));
                              },
                              child: const Text("CheckIn")),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
