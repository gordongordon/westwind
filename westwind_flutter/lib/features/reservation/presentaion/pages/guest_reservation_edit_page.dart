import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';

class GuestReservationEditPage extends StatefulWidget {
  final int? guestId;
  final int? reservationId;
  
  static String route([int? guestId, int? reservationId]) => 
      "/guest-reservation/edit/${guestId ?? ':guestId'}/${reservationId ?? ':reservationId'}";
  static String routeNew() => "/guest-reservation/new";

  const GuestReservationEditPage({super.key, this.guestId, this.reservationId});

  @override
  State<GuestReservationEditPage> createState() => _GuestReservationEditPageState();
}

class _GuestReservationEditPageState extends State<GuestReservationEditPage> {
  final formKey = GlobalKey<FormBuilderState>();
  
  // Guest-related controllers
  final TextEditingController guestIdController = TextEditingController(text: "0");
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController rateTypeController = TextEditingController(text: RateType.standard.name);
  final TextEditingController rigNumberController = TextEditingController();

  // Reservation-related controllers
  final TextEditingController reservationIdController = TextEditingController(text: "0");
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController rateController = TextEditingController(text: "86");
  final TextEditingController rateReasonController = TextEditingController(text: RateReason.single.toString());

  // Date-related variables
  DateTime dateCreate = DateTime.now();
  DateTime dateUpdate = DateTime.now();
  DateTime checkInDate = DateTime.now().getDateOnly();
  DateTime stayDay = DateTime.now().getDateOnly();
  DateTime checkOutDate = DateTime.now().getDateOnly().add(Duration(days: 1));

  // Boolean flags
  bool isInHouse = false;
  bool isCheckedIn = false;
  bool isCanceled = false;
  bool isNightShift = false;

  // Dropdown options
  final List<String> _rateTypeOptions = RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions = RateReason.values.map((e) => e.name).toList();

  // Getters for editing mode
  bool get isGuestEditing => widget.guestId != null && widget.guestId! > 0;
  bool get isReservationEditing => widget.reservationId != null && widget.reservationId! > 0;

  @override
  void initState() {
    super.initState();
    if (isGuestEditing) {
      context.read<GuestManageBloc>().add(GuestManageRetrieveEvent(id: widget.guestId!));
    }
    if (isReservationEditing) {
      context.read<ReservationManageBloc>().add(RetrieveReservation(id: widget.reservationId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isGuestEditing || isReservationEditing ? "Edit Guest & Reservation" : "New Guest & Reservation"),
        actions: [
          IconButton(
            onPressed: _saveGuestReservation,
            icon: Icon(Icons.save),
            tooltip: 'Save Guest & Reservation',
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GuestManageBloc, GuestManageState>(
            listener: _guestBlocListener,
          ),
          BlocListener<ReservationManageBloc, ReservationManageState>(
            listener: _reservationBlocListener,
          ),
        ],
        child: BlocBuilder<GuestManageBloc, GuestManageState>(
          builder: (context, guestState) {
            return BlocBuilder<ReservationManageBloc, ReservationManageState>(
              builder: (context, reservationState) {
                if (guestState is GuestManageStateLoading || 
                    reservationState is ReservationManageStateLoading) {
                  return const Loader();
                }
                return _buildForm();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGuestInfoSection(),
              _buildReservationInfoSection(),
              _buildRateInfoSection(),
              _buildAdditionalInfoSection(),
              if (isGuestEditing || isReservationEditing) _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuestInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Guest Information', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('guestId', 'Guest ID', guestIdController, null, enabled: false),
        _buildTextField('firstName', 'First Name', firstNameController, null,
          validator: FormBuilderValidators.compose([FormBuilderValidators.required()])),
        _buildTextField('lastName', 'Last Name', lastNameController, null,
          validator: FormBuilderValidators.compose([FormBuilderValidators.required()])),
        _buildTextFieldOptionalEmail('email', 'Email', emailController),
        _buildTextFieldPhone('phone', 'Phone', phoneController, _onPhoneChanged),
        _buildTextFieldOptional('rigNumber', 'Rig Number', rigNumberController, keyboardType: TextInputType.number),
        _buildRateTypeDropdown(),
        _buildInHouseSwitch(),
      ],
    );
  }

  Widget _buildReservationInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Reservation Information', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('reservationId', 'Reservation ID', reservationIdController, null, enabled: false),
        _buildDateTimePicker('checkInDate', 'Check In Date', initialValue: checkInDate),
        _buildDateTimePicker('checkOutDate', 'Check Out Date', initialValue: checkOutDate),
        _buildDateTimePicker('stayDay', 'Stay Day', initialValue: stayDay),
        _buildTextField('roomId', 'Room ID', roomIdController, null, 
          keyboardType: TextInputType.number,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.integer(),
          ])),
        FormBuilderSwitch(
          name: 'isCheckedIn',
          title: const Text('Is Checked In'),
          initialValue: isCheckedIn,
          onChanged: (val) => setState(() => isCheckedIn = val ?? false),
        ),
        FormBuilderSwitch(
          name: 'isCanceled',
          title: const Text('Is Canceled'),
          initialValue: isCanceled,
          onChanged: (val) => setState(() => isCanceled = val ?? false),
        ),
        FormBuilderSwitch(
          name: 'isNightShift',
          title: const Text('Is Night Shift'),
          initialValue: isNightShift,
          onChanged: (val) => setState(() => isNightShift = val ?? false),
        ),
      ],
    );
  }

  Widget _buildRateInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Rate Information', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildDropdown('rateReason', 'Rate Reason', _rateReasonOptions, initialValue: rateReasonController.text),
        _buildTextField('rate', 'Rate', rateController, null, 
          keyboardType: TextInputType.number,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ])),
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
        _buildDateTimePicker('dateCreate', 'Date Created', initialValue: dateCreate, enabled: false),
        _buildDateTimePicker('dateUpdate', 'Date Updated', initialValue: dateUpdate, enabled: false),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 24),
        if (isReservationEditing) _buildButton(
          'Check In',
          () => context.read<ReservationManageBloc>().add(CheckInReservation(id: widget.reservationId!))
        ),
        const SizedBox(height: 16),
        _buildButton(
          'Delete',
          () {
            if (isGuestEditing) {
              context.read<GuestManageBloc>().add(GuestManageDeleteEvent(id: widget.guestId!));
            }
            if (isReservationEditing) {
              context.read<ReservationManageBloc>().add(DeleteReservation(id: widget.reservationId!));
            }
          },
          color: Colors.red
        ),
      ],
    );
  }

  Widget _buildTextField(String name, String label, TextEditingController controller, void Function(String?)? onChanged,
      {bool enabled = true, TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildTextFieldOptional(String name, String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildTextFieldOptionalEmail(String name, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: FormBuilderValidators.email(),
      ),
    );
  }

  Widget _buildTextFieldPhone(String name, String label, TextEditingController controller, void Function(String?)? onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
        onChanged: onChanged,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.maxLength(11),
          FormBuilderValidators.minLength(11),
        ]),
      ),
    );
  }

  Widget _buildDateTimePicker(String name, String label, {required DateTime initialValue, bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderDateTimePicker(
        name: name,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        initialValue: initialValue,
        inputType: InputType.date,
        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildDropdown(String name, String label, List<String> options, {required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderDropdown<String>(
        name: name,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        initialValue: initialValue,
        items: options
            .map((option) => DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildRateTypeDropdown() {
    return FormBuilderDropdown<String>(
      name: 'rateType',
      decoration: InputDecoration(
        labelText: 'Rate Type',
        border: OutlineInputBorder(),
      ),
      initialValue: rateTypeController.text,
      items: _rateTypeOptions
          .map((rateType) => DropdownMenuItem(value: rateType, child: Text(rateType)))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            rateTypeController.text = value;
          });
        }
      },
      validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
    );
  }

  Widget _buildInHouseSwitch() {
    return FormBuilderSwitch(
      name: 'isInHouse',
      title: Text('Currently In House'),
      initialValue: isInHouse,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, {Color color = Colors.blue}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }

  void _onPhoneChanged(String? value) {
    if (value != null && formKey.currentState!.fields['phone']!.isValid) {
      context.read<GuestManageBloc>().add(GuestManageRetrieveByPhoneEvent(phone: value.trim()));
    //  context.read<ReservationManageBloc>().add(RetrieveGuestByPhoneForReservation(phone: value.trim()));
    }
  }

  void _saveGuestReservation() {
    if (_validateGuestForm()) {
      _saveGuest();
    } else {
      showSnackbar(context, 'Please fill all required fields for the guest');
    }
  }

  bool _validateGuestForm() {
    final guestFields = [
      'firstName',
      'lastName',
      'phone',
      'rateType',
    ];
    
    return _validateFields(guestFields);
  }

  bool _validateReservationForm() {
    final reservationFields = [
      'roomId',
      'checkInDate',
      'checkOutDate',
      'stayDay',
      'rate',
      'rateReason',
    ];
    
    return _validateFields(reservationFields);
  }

  bool _validateFields(List<String> fields) {
    bool isValid = true;
    for (var field in fields) {
      if (formKey.currentState?.fields[field]?.validate() == false) {
        isValid = false;
        print('Validation failed for field: $field');
      }
    }
    return isValid;
  }

  void _saveGuest() {
    final guest = Guest(
      id: widget.guestId == null ? null : int.tryParse(guestIdController.text),
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
      email: emailController.text.isNotEmpty ? emailController.text : null,
      isInHouse: formKey.currentState!.fields['isInHouse']!.value,
      dateCreate: formKey.currentState!.fields['dateCreate']!.value,
      dateUpdate: formKey.currentState!.fields['dateUpdate']!.value,
      rateType: RateType.values.byName(formKey.currentState!.fields['rateType']!.value),
      staffId: 1,
      companyId: 1,
      rigNumber: rigNumberController.text.isNotEmpty ? int.parse(rigNumberController.text) : null,
      accountBalance: 0,
    );

    context.read<GuestManageBloc>().add(GuestManageSaveEvent(guest: guest));
  }

void _saveReservation(int guestId) {
  print('Attempting to save reservation for guest ID: $guestId');
  if (_validateReservationForm()) {
    try {
      // Log each field separately with null checks
      print('Room ID: ${roomIdController.text}');
      print('Is Checked In: ${formKey.currentState?.fields['isCheckedIn']?.value ?? false}');
      print('Is Canceled: ${formKey.currentState?.fields['isCanceled']?.value ?? false}');
      print('Is Night Shift: ${formKey.currentState?.fields['isNightShift']?.value ?? false}');
      print('Date Create: ${formKey.currentState?.fields['dateCreate']?.value ?? DateTime.now()}');
      print('Date Update: ${formKey.currentState?.fields['dateUpdate']?.value ?? DateTime.now()}');
      print('Check In Date: ${formKey.currentState?.fields['checkInDate']?.value ?? DateTime.now()}');
      print('Check Out Date: ${formKey.currentState?.fields['checkOutDate']?.value ?? DateTime.now().add(Duration(days: 1))}');
      print('Stay Day: ${formKey.currentState?.fields['stayDay']?.value ?? DateTime.now()}');
      print('Rate Type: ${formKey.currentState?.fields['rateType']?.value ?? RateType.standard.name}');
      print('Rate: ${rateController.text}');
      print('Rate Reason: ${formKey.currentState?.fields['rateReason']?.value ?? RateReason.single.name}');

      final reservation = Reservation(
        id: widget.reservationId == null ? null : int.tryParse(reservationIdController.text),
        guestId: guestId,
        roomId: int.tryParse(roomIdController.text) ?? 0,
        isCheckedIn: formKey.currentState?.fields['isCheckedIn']?.value ?? false,
        isCanceled: formKey.currentState?.fields['isCanceled']?.value ?? false,
        isNightShift: formKey.currentState?.fields['isNightShift']?.value ?? false,
        dateCreate: formKey.currentState?.fields['dateCreate']?.value ?? DateTime.now(),
        dateUpdate: formKey.currentState?.fields['dateUpdate']?.value ?? DateTime.now(),
        checkInDate: formKey.currentState?.fields['checkInDate']?.value ?? DateTime.now(),
        checkOutDate: formKey.currentState?.fields['checkOutDate']?.value ?? DateTime.now().add(Duration(days: 1)),
        stayDay: formKey.currentState?.fields['stayDay']?.value ?? DateTime.now(),
        rateType: RateType.values.byName(formKey.currentState?.fields['rateType']?.value ?? RateType.standard.name),
        rate: double.tryParse(rateController.text) ?? 0.0,
        rateReason: RateReason.values.byName(formKey.currentState?.fields['rateReason']?.value ?? RateReason.single.name),
      );

      print('Reservation object created: $reservation');
      context.read<ReservationManageBloc>().add(SaveReservation(reservation: reservation));
    } catch (e, stackTrace) {
      print('Error creating reservation object: $e');
      print('Stack trace: $stackTrace');
      showSnackbar(context, 'Error creating reservation: $e');
    }
  } else {
    print('Reservation form validation failed');
    showSnackbar(context, 'Please fill all required fields for the reservation');
  }
}

void _guestBlocListener(BuildContext context, GuestManageState state) {
  print('Current guest state: $state');
  if (state is GuestManageStateFailure) {
    print('${state.message}');
    showSnackbar(context, 'Failed to Guest: ${state.message}');
  } else if (state is GuestManageStateSaveSuccess) {
    print('Guest saved successfully. ID: ${state.guest.id}');
    _saveReservation(state.guest.id!);
  } else if (state is GuestManageStateRetrieveSuccess) {
    _populateGuestFields(state.guest);
  } else if (state is GuestManageStateRetrieveByPhoneSuccess) {
    _populateGuestFields(state.guest);
  }
}

void _reservationBlocListener(BuildContext context, ReservationManageState state) {
  print('Current reservation state: $state');
  if (state is ReservationManageStateFailure) {
    print('Reservation save failed: ${state.message}');
    showSnackbar(context, 'Failed to save reservation: ${state.message}');
  } else if (state is ReservationManageStateSaveSuccess) {
    print('Reservation saved successfully');
    showSnackbar(context, 'Guest and Reservation saved successfully');
   // context.read<GuestListBloc>().add(FetchGuestsEvent());
   // context.read<ReservationListBloc>().add(FetchReservationsEvent());
   // context.pop();
  } else if (state is ReservationManageStateRetrieveSuccess) {
    _populateReservationFields(state.reservation);
  }
  /*
   else if (state is ReservationManageStateRetrieveGuestSuccess ||
      state is ReservationManageStateRetrieveGuestByPhoneSuccess) {

    _populateGuestFields(state is ReservationManageStateRetrieveGuestSuccess
        ? state.guest
        : (state as ReservationManageStateRetrieveGuestByPhoneSuccess).guest);
  }
  */
}

  void _populateGuestFields(Guest guest) {
    guestIdController.text = guest.id.toString();
    firstNameController.text = guest.firstName;
    lastNameController.text = guest.lastName;
    phoneController.text = guest.phone;
    emailController.text = guest.email ?? '';
    rigNumberController.text = guest.rigNumber?.toString() ?? '';
    rateTypeController.text = guest.rateType.name;

    setState(() {
      isInHouse = guest.isInHouse;
      dateCreate = guest.dateCreate;
      dateUpdate = guest.dateUpdate ?? DateTime.now();
    });

    formKey.currentState?.patchValue({
      'rateType': guest.rateType.name,
      'isInHouse': guest.isInHouse,
    });
  }

  void _populateReservationFields(Reservation reservation) {
    reservationIdController.text = reservation.id.toString();
    roomIdController.text = reservation.roomId.toString();
    rateController.text = reservation.rate.toString();
    rateReasonController.text = reservation.rateReason.toString();

    setState(() {
      checkInDate = reservation.checkInDate;
      checkOutDate = reservation.checkOutDate;
      stayDay = reservation.stayDay;
      isCheckedIn = reservation.isCheckedIn;
      isCanceled = reservation.isCanceled;
      isNightShift = reservation.isNightShift;
      dateCreate = reservation.dateCreate;
      dateUpdate = reservation.dateUpdate ?? DateTime.now();
    });

    formKey.currentState?.patchValue({
      'rateReason': reservation.rateReason.name,
      'isCheckedIn': reservation.isCheckedIn,
      'isCanceled': reservation.isCanceled,
      'isNightShift': reservation.isNightShift,
    });

    if (reservation.guest != null) {
      _populateGuestFields(reservation.guest!);
    }
  }
}