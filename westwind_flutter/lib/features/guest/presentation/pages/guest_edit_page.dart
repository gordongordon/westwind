import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_detail/guest_detail_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';

class GuestEditPage extends StatefulWidget {
  final int? guestId;
  static String route([int? guestId]) => "/guests/edit/${guestId ?? ':id'}";
  static String routeNew() => "/guests/new";

  const GuestEditPage({super.key, this.guestId});

  @override
  State<GuestEditPage> createState() => _GuetEditPageState();
}

class _GuetEditPageState extends State<GuestEditPage> {
  final formkey = GlobalKey<FormBuilderState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final rateTypeController = TextEditingController();
  final dateCreateController = TextEditingController();
  final idController = TextEditingController(text: "0");
  final rigNumberController = TextEditingController();
  var dateCreate = DateTime.now();
  var dateUpdate = DateTime.now();
  bool isInHouse = false;

  bool _genderHasError = false;

  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();

  void _onChanged(dynamic val) => debugPrint(val.toString());

  bool get isEditing {
    return widget.guestId != null && widget.guestId! > 0;
  }

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      print("isEditing ");
      print(widget.guestId);
      context
          .read<GuestManageBloc>()
          .add(GuestManageRetrieveEvent(id: widget.guestId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Guest Edit Page ${widget.guestId}"),
          actions: [
            IconButton(
              onPressed: () {
                formkey.currentState?.saveAndValidate();
                debugPrint(formkey.currentState!.validate().toString());
                if (formkey.currentState!.validate()) {
                  RateType rateType = RateType.values
                      .byName(formkey.currentState!.fields['rateType']!.value);
                  //      if ( formkey.currentState!.fields['rigNumber'] == null) {
                  //        debugPrint("rateType == null");
                  //     }
                  //     final rigNumber = formkey
                  //        .currentState!.fields['rigNumber']!.value
                  //       .toString();

                  final guest = Guest(
                    id: widget.guestId,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    isInHouse: formkey.currentState!.fields['isInHouse']!.value,
                    dateCreate:
                        formkey.currentState!.fields['dateCreate']!.value,
                    dateUpdate:
                        formkey.currentState!.fields['dateUpdate']!.value,
                    rateType: rateType,
                    staffId: 1,
                    companyId: 1,
                    rigNumber: int.parse(rigNumberController.text),
                  );

                  debugPrint(guest.toString());
                  context
                      .read<GuestManageBloc>()
                      .add(GuestManageSaveEvent(guest: guest));
                  // context.pop();
                }
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        body: BlocConsumer<GuestManageBloc, GuestManageState>(
          listener: (context, state) {
            if (state is GuestManageStateFailure) {
              showSnackbar(context, state.message);
            } else if (state is GuestManageStateSaveSuccess) {
              context.read<GuestListBloc>().add(FetchGuestsEvent());
              //  context.pop();
              if (isEditing) {
                context
                    .read<GuestDetailBloc>()
                    .add(GuestDetailRetrieveEvent(id: widget.guestId!));
              }

              context.pop();
            } else if (state is GuestManageStateDeleteSuccess) {
              context.read<GuestListBloc>().add(FetchGuestsEvent());
              context.pop();
              context.pop();
            } else if (state is GuestManageStateRetrieveSuccess) {
              // debugPrint("GuestManageState RetrieveSuccess ");
              idController.text = state.guest.id!.toString();
              firstNameController.text = state.guest.firstName;
              lastNameController.text = state.guest.lastName;
              emailController.text = state.guest.email;
              phoneController.text = state.guest.phone;
              rateTypeController.text = state.guest.rateType.toString();
              isInHouse = state.guest.isInHouse;
              dateCreate = state.guest.dateCreate;
              dateUpdate = state.guest.dateUpdate!;
              rigNumberController.text = state.guest.rigNumber.toString();
            } else if (state is GuestManageStateRetrieveByPhoneSuccess) {
              //  debugPrint("GuestManageState RetrieveSuccess ");
              idController.text = state.guest.id!.toString();
              firstNameController.text = state.guest.firstName;
              lastNameController.text = state.guest.lastName;
              emailController.text = state.guest.email;
              phoneController.text = state.guest.phone;
              rateTypeController.text = state.guest.rateType.toString();
              isInHouse = state.guest.isInHouse;
              dateCreate = state.guest.dateCreate;
              dateUpdate = state.guest.dateUpdate!;
              rigNumberController.text = state.guest.rigNumber.toString();
            }
          },
          builder: (context, state) {
            if (state is GuestManageStateLoading) {
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
                          if (formkey
                              .currentState!.fields['phone']!.valueIsValid) {
                            if (value != null) {
                              context.read<GuestManageBloc>().add(
                                  GuestManageRetrieveByPhoneEvent(phone: value.trim()));
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
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
                        title: Text((isInHouse
                            ? "Is in house?   Yes"
                            : " Is in house?    No")),
                        enabled: false,
                        inactiveThumbColor: Colors.red,
                        initialValue: isInHouse,
                        name: 'isInHouse',
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
                                context.read<GuestManageBloc>().add(
                                    GuestManageDeleteEvent(
                                        id: widget.guestId!));
                              },
                              child: const Text("Delete")),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
