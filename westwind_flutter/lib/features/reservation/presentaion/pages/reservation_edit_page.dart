import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';

class ReservationEditPage extends StatefulWidget {
  final int? reservationId;
  static String route([int? reservationId]) =>
      "/reservations/edit/${reservationId ?? ':id'}";
  static String routeNew() => "/reservations/new";

  const ReservationEditPage({super.key, this.reservationId});

  @override
  State<ReservationEditPage> createState() => _ReservationEditPageState();
}

class _ReservationEditPageState extends State<ReservationEditPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController idController = TextEditingController(text: "0");
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController guestIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController rateTypeController =
      TextEditingController(text: RateType.standard.toString());
  final TextEditingController rigNumberController = TextEditingController();

  final TextEditingController rateController =
      TextEditingController(text: "86");
  final TextEditingController rateReasonController =
      TextEditingController(text: RateReason.single.toString());
  final TextEditingController noteController = TextEditingController();

  DateTime dateCreate = TimeManager.instance.now();
  DateTime dateUpdate = TimeManager.instance.now();
  DateTime checkInDate = TimeManager.instance.today();
  DateTime stayDay = TimeManager.instance.today();
  // DateTime checkOutDate = DateTime.now().getDateOnly().add(Duration(days: 1));
  DateTime checkOutDate = TimeManager.instance.today().add(Duration(days: 1));

  bool isCheckedIn = false;
  bool isCanceled = false;
  bool isNightShift = false;

  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();

  bool get isEditing =>
      widget.reservationId != null && widget.reservationId! > 0;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      context
          .read<ReservationManageBloc>()
          .add(RetrieveReservation(id: widget.reservationId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Reservation" : "New Reservation"),
        actions: [
          IconButton(
            onPressed: _saveReservation,
            icon: Icon(Icons.save),
            tooltip: 'Save Reservation',
          ),
        ],
      ),
      body: BlocConsumer<ReservationManageBloc, ReservationManageState>(
        listener: _blocListener,
        builder: (context, state) {
          if (state is ReservationManageStateLoading) {
            return const Loader();
          }
          return _buildForm();
        },
      ),
    );
  }

  onChangedGuestId(value) {
    if (value != null) {
      context
          .read<ReservationManageBloc>()
          .add(RetrieveGuestForReservation(id: int.parse(value)));
    }
  }

  onChangedPhone(value) {
    if (formKey.currentState!.fields['phone']!.valueIsValid) {
      if (value != null) {
        context
            .read<ReservationManageBloc>()
            .add(RetrieveGuestByPhoneForReservation(phone: value.trim()));
      }
    }
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
              if (isEditing) _buildActionButtons(),
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
        Text('Guest Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('id', 'ID', idController, null, enabled: false),
        _buildTextFieldPhone('phone', 'Phone', phoneController, onChangedPhone,
            keyboardType: TextInputType.phone),
        _buildTextField('firstName', 'First Name', firstNameController, null),
        _buildTextField('lastName', 'Last Name', lastNameController, null),
        _buildTextField(
            'guestId', 'Guest ID', guestIdController, onChangedGuestId,
            keyboardType: TextInputType.number),
        _buildTextField('rigNumber', 'Rig Number', rigNumberController, null,
            keyboardType: TextInputType.number),
        _buildTextFieldMultiline('note', 'Note to Guest', noteController,
            keyboardType: TextInputType.multiline),
      ],
    );
  }

  Widget _buildTextFieldMultiline(
    String name,
    String label,
    TextEditingController controller, {
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
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
        maxLines: keyboardType == TextInputType.multiline
            ? null
            : 1, // Allow multiple lines for multiline input
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }

/*
  Widget _buildTextFieldOptional(
      String name, String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int? maxLength}) {
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
        maxLength: maxLength,
        // onChanged: ,
        // validator: FormBuilderValidators.compose([]),
      ),
    );
  }
  */

  Widget _buildReservationInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Reservation Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildDateTimePicker('checkInDate', 'Check In Date',
            initialValue: checkInDate),
        _buildDateTimePicker('checkOutDate', 'Check Out Date',
            initialValue: checkOutDate),
         _buildDateTimePicker('stayDay', 'Stay Day', initialValue: stayDay, enabled: false),
        _buildTextField('roomId', 'Room ID', roomIdController, null,
            keyboardType: TextInputType.number),
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
        Text('Rate Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildDropdown('rateType', 'Rate Type', _rateTypeOptions,
            initialValue: rateTypeController.text),
        _buildDropdown('rateReason', 'Rate Reason', _rateReasonOptions,
            initialValue: rateReasonController.text),
        _buildTextField('rate', 'Rate', rateController, null,
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
        _buildDateTimePicker('dateCreate', 'Date Created',
            initialValue: dateCreate, enabled: false),
        _buildDateTimePicker('dateUpdate', 'Date Updated',
            initialValue: dateUpdate, enabled: false),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildButton(
            'Check In',
            () => context
                .read<ReservationManageBloc>()
                .add(CheckInReservation(id: widget.reservationId!))),
        const SizedBox(height: 16),
        _buildButton(
            'Delete',
            () => context
                .read<ReservationManageBloc>()
                .add(DeleteReservation(id: widget.reservationId!)),
            color: Colors.red),
      ],
    );
  }

/*
  Widget _buildTextFieldGuestId(String name, String label,
      TextEditingController controller, void Function(String?)? onChanged,
      {bool enabled = true, TextInputType keyboardType = TextInputType.text}) {
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
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.numeric(),
        ]),
      ),
    );
  }
*/
  Widget _buildTextFieldPhone(String name, String label,
      TextEditingController controller, void Function(String?)? onChanged,
      {bool enabled = true, TextInputType keyboardType = TextInputType.text}) {
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
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(11),
          FormBuilderValidators.numeric(),
          FormBuilderValidators.equalLength(11),
        ]),
      ),
    );
  }

  Widget _buildTextField(String name, String label,
      TextEditingController controller, void Function(String?)? onChanged,
      {bool enabled = true, TextInputType keyboardType = TextInputType.text}) {
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
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildDateTimePicker(String name, String label,
      {required DateTime initialValue, bool enabled = true}) {
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
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildDropdown(String name, String label, List<String> options,
      {required String initialValue}) {
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
            .map((option) =>
                DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed,
      {Color color = Colors.blue}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }

  void _saveReservation() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final reservation = Reservation(
          id: widget.reservationId,
          guestId: int.parse(guestIdController.text),
          roomId: int.parse(roomIdController.text),
          isCheckedIn: formKey.currentState!.fields['isCheckedIn']!.value,
          isCanceled: formKey.currentState!.fields['isCanceled']!.value,
          isNightShift: formKey.currentState!.fields['isNightShift']!.value,
          dateCreate: formKey.currentState!.fields['dateCreate']!.value,
          dateUpdate: formKey.currentState!.fields['dateUpdate']!.value,
          checkInDate: formKey.currentState!.fields['checkInDate']!.value,
          checkOutDate: formKey.currentState!.fields['checkOutDate']!.value,
          //! stayDay should equal to checkIn Day
          //! haved been handled in server side also every we save reservation.
          stayDay: formKey.currentState!.fields['checkInDate']!.value,
          rateType: RateType.values
              .byName(formKey.currentState!.fields['rateType']!.value),
          rate: double.parse(rateController.text),
          rateReason: RateReason.values
              .byName(formKey.currentState!.fields['rateReason']!.value));

      context
          .read<ReservationManageBloc>()
          .add(SaveReservation(reservation: reservation));
    }
  }

  void _blocListener(BuildContext context, ReservationManageState state) {
    if (state is ReservationManageStateFailure) {
      showSnackbar(context, state.message);
    } else if (state is ReservationManageStateSaveSuccess ||
        state is ReservationManageStateDeleteSuccess ||
        state is ReservationManageStateCheckInSuccess) {
      context.read<ReservationListBloc>().add(FetchReservationsEvent());
      //! handle Reservtion exit refresh
      context.read<RoomCalendarBloc>().add(InitializeCalendar());
      context.pop();
    } else if (state is ReservationManageStateRetrieveSuccess) {
      _populateFields(state.reservation);
    } else if (state is ReservationManageStateRetrieveGuestSuccess) {
      _populateGuestFields(state.guest);
    } else if (state is ReservationManageStateRetrieveGuestByPhoneSuccess) {
      _populateGuestFields(state.guest);
    }
  }

  void _populateFields(Reservation reservation) {
    idController.text = reservation.id!.toString();
    guestIdController.text = reservation.guestId.toString();
    roomIdController.text = reservation.roomId.toString();
    rateController.text = reservation.rate.toString();
    rateReasonController.text = reservation.rateReason.toString();
    rateTypeController.text = reservation.rateType.toString();
    firstNameController.text = reservation.guest == null
        ? "no name given"
        : reservation.guest!.firstName;
    lastNameController.text = reservation.guest == null
        ? "no last name given"
        : reservation.guest!.lastName;
    phoneController.text =
        reservation.guest == null ? '0000000000' : reservation.guest!.phone;
    rigNumberController.text = reservation.guest == null
        ? "no rig given"
        : reservation.guest!.rigNumber.toString();
    noteController.text =
        reservation.guest == null ? "no note given" : reservation.guest!.note;

    setState(() {
      checkInDate = reservation.checkInDate;
      checkOutDate = reservation.checkOutDate;
      stayDay = reservation.stayDay;
      isCheckedIn = reservation.isCheckedIn;
      isCanceled = reservation.isCanceled;
      isNightShift = reservation.isNightShift;
      dateCreate = reservation.dateCreate;
      dateUpdate = reservation.dateUpdate!;
    });

    formKey.currentState?.patchValue({
      'rateType': reservation.rateType.name,
      'rateReason': reservation.rateReason.name,
    });
  }

  void _populateGuestFields(Guest guest) {
    guestIdController.text = guest.id.toString();
    firstNameController.text = guest.firstName;
    lastNameController.text = guest.lastName;
    phoneController.text = guest.phone;
    rigNumberController.text = guest.rigNumber.toString();
    rateTypeController.text = guest.rateType.toString();

    formKey.currentState?.patchValue({
      'rateType': guest.rateType.name,
    });

    noteController.text = guest.note;
  }
}
