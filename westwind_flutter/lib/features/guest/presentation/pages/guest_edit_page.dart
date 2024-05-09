import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final formkey = GlobalKey<FormBuilderState>();

  final dateCreate = DateTime.now();

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

    if (isEditing ) {
      print( "isEditing ");
      print( widget.guestId);
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
                debugPrint( formkey.currentState!.validate().toString());
                if (formkey.currentState!.validate()) {
                  // Get RateType and assign back to database

                  if ( formkey.currentState!.fields['rateType'] == null) {
                    debugPrint("rateType == null");
                  }
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
                    dateCreate: new DateTime.now(),
                    rateType: rateType,
                    staffId: 1,
                    companyId: 1,
                    rigNumber: 99,
                  );

                  debugPrint( guest.toString() );
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
            } else if (state is GuestManageStateRetrieveSuccess ) {
              debugPrint("GuestManageState RetrieveSuccess ");
              firstNameController.text = state.guest.firstName;
              lastNameController.text = state.guest.lastName;
              emailController.text = state.guest.email;
              phoneController.text = state.guest.phone;
              ;
            }
          },
          builder: (context, state) {
            if (state is GuestManageStateLoading) {
               return const Loader();
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormBuilder(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        decoration:
                            const InputDecoration(label: Text('FirstName')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'FirstName required';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: lastNameController,
                        decoration:
                            const InputDecoration(label: Text('last name')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'last name required';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(label: Text('Email')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email required';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(label: Text('phone')),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'phone required';
                          }

                          if (int.tryParse(value) == null) {
                            return 'Invalid phone';
                          }

                          // to do validate email
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDropdown<String>(
                        name: 'rateType',
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
                        title: const Text('Is in house?'),
                        name: 'isInHouse',
                        onChanged: _onChanged,
                      ),
                      const SizedBox(height: 10),
                      FormBuilderDateTimePicker(
                        name: 'dateCreate',
                        decoration:
                            const InputDecoration(labelText: 'Date Created'),
                        initialValue: dateCreate,
                        //                 initialDate: DateTime.now().add(const Duration(days: 10)),
                        initialDatePickerMode: DatePickerMode.day,
                        timePickerInitialEntryMode: TimePickerEntryMode.input,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        inputType: InputType.date,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
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
