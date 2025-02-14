import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/utils/MyDateExtension.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/data/datasources/guest_datasource.dart';
import 'package:westwind_flutter/features/guest/data/repositories/guest_repository_imp.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';
import 'package:westwind_flutter/features/guest/domain/usecases/list_guest.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_bloc.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_list/guest_list_events.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_list/reservation_list_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

class GuestReservationEditPage extends StatefulWidget {
  final int? guestId;
  final int? reservationId;
  final int? roomId;
  final DateTime? date;

  static String route([int? guestId, int? reservationId]) =>
      "/guest-reservation/edit/${guestId ?? ':guestId'}/${reservationId ?? ':reservationId'}";

  static String routeNew() => "/guest-reservation/new";

  static String routeCalendar([int? roomId, DateTime? date]) =>
      "/guest-reservation/calendar/${roomId ?? ':roomId'}/${date ?? ':date'}";

  const GuestReservationEditPage({
    super.key,
    this.guestId,
    this.reservationId,
    this.roomId,
    this.date,
  });

  @override
  State<GuestReservationEditPage> createState() =>
      _GuestReservationEditPageState();
}

class _GuestReservationEditPageState extends State<GuestReservationEditPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final dropDownKey = GlobalKey<DropdownSearchState>();

  // final List<String> getData = ['gordon', 'may'];

  // final GuestRepository guestRepository;

  // Guest-related controllers
  final TextEditingController guestIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController rateTypeController =
      TextEditingController(text: RateType.standard.name);
  final TextEditingController rigNumberController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  // Reservation-related controllers
  final TextEditingController reservationIdController =
      TextEditingController(text: "0");
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController rateController =
      TextEditingController(text: "86");
  final TextEditingController rateReasonController =
      TextEditingController(text: RateReason.single.toString());

  // Date-related variables
  DateTime dateCreate = TimeManager.instance.now();
  DateTime dateUpdate = TimeManager.instance.now();
  DateTime checkInDate = TimeManager.instance.today();
  DateTime stayDay = TimeManager.instance.today();
  DateTime checkOutDate = TimeManager.instance.today().add(Duration(days: 1));

  // formKey.currentState?.fields['checkOutDate']?.value = checkOutDate;

  // Boolean flags
  bool isInHouse = false;
  bool isCheckedIn = false;
  bool isCanceled = false;
  bool isNightShift = false;
  bool isSaveAndCheckIn = false;

  // Dropdown options
  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();
  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();

  // Getters for editing mode
  bool get isGuestEditing => widget.guestId != null && widget.guestId! > 0;
  bool get isReservationEditing =>
      widget.reservationId != null && widget.reservationId! > 0;

  @override
  void initState() {
    super.initState();
    if (widget.roomId != null) {
      roomIdController.text = widget.roomId.toString();
    }
    if (widget.date != null) {
      stayDay = widget.date!;
      checkInDate = widget.date!;
      checkOutDate = widget.date!.add(Duration(days: 1));
    }
    if (isGuestEditing) {
      context
          .read<GuestManageBloc>()
          .add(GuestManageRetrieveEvent(id: widget.guestId!));
    }
    if (isReservationEditing) {
      context
          .read<ReservationManageBloc>()
          .add(RetrieveReservation(id: widget.reservationId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isGuestEditing || isReservationEditing
            ? "Edit Guest & Reservation"
            : "New Guest & Reservation"),
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
              _buildActionButtons(),
              _buildAdditionalInfoSection(),
              //    if (isGuestEditing || isReservationEditing) _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Guest>> getData(filter) async {
    // late response;

//    GuestDatasourceImpl(_client).list();

    try {
      var client = await Client(
            // "http://localhost:8080/",
            "https://westwind-app-b00b64c234f3.herokuapp.com/api/",
            authenticationKeyManager: FlutterAuthenticationKeyManager(),
          )
            ..connectivityMonitor = FlutterConnectivityMonitor(),
          response = client.guest.retrieveGuestByLastName(lastName: filter);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Widget _buildGuestInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Guest Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),

        // Building  asyn field :
        DropdownSearch<Guest>(
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'Click to start searching guest',
              border: OutlineInputBorder(),
              //  hintText: 'when guest was selected then click to update the booking ! '
            ),
          ),
          items: (f, cs) => getData(f),
          suffixProps: DropdownSuffixProps(
              clearButtonProps: ClearButtonProps(isVisible: true)),
          compareFn: (item, selectedItem) {
            if (item.id == selectedItem.id) {
              phoneController.text = item.phone.toString();

              context.read<GuestManageBloc>().add(
                  GuestManageRetrieveByPhoneEvent(
                      phone: phoneController.text.trim()));
              return true;
            }

            return false;
          },
          //  onChanged: (item) => context.read<GuestManageBloc>().add(GuestManageRetrieveByPhoneEvent( phone: item!.phone)),

          dropdownBuilder: (context, selectedItem) {
            if (selectedItem == null) {
              return SizedBox.shrink();
            }

            return ListTile(
              contentPadding: EdgeInsets.only(left: 0),
              leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(selectedItem.lastName[0])),
              title: Text(selectedItem.lastName),
              //  subtitle: Text('sub'),
              subtitle: Text(
                  ' ${selectedItem.rateType} / Tel : ${selectedItem.phone}'),
            );
          },
          popupProps: PopupProps.menu(
            disableFilter: true, //data will be filtered by the backend
            showSearchBox: true,
            showSelectedItems: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                labelText: 'Type to search by guest\'s last name',
                border: OutlineInputBorder(),
              ),
            ),
            itemBuilder: (ctx, item, isDisabled, isSelected) {
              return ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(item.lastName[0])),
                selected: isSelected,
                title: Text('${item.lastName} ${item.firstName}'),
                subtitle: Text(' ${item.rateType} / Tel : ${item.phone}'),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // ENd of

        _buildTextFieldPhone(
            'phone', 'Phone', phoneController, _onPhoneChanged),
        _buildTextField('guestId', 'Guest ID', guestIdController, null,
            enabled: false),
        _buildTextField('firstName', 'First Name', firstNameController, null,
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()])),
        _buildTextField('lastName', 'Last Name', lastNameController, null,
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()])),
        _buildTextFieldOptionalEmail('email', 'Email', emailController),

        _buildTextFieldOptional('rigNumber', 'Rig Number', rigNumberController,
            keyboardType: TextInputType.number),

        //    _buildRateTypeDropdown(),

        //     _buildDropdown('rateType', 'Rate Type', _rateTypeOptions,
        //     initialValue: rateTypeController.text),

        //! when remove, the form wan't validiated
        FormBuilderSwitch(
          name: 'isInHouse',
          title: const Text('Is in House '),
          initialValue: isCanceled,
          onChanged: (val) => setState(() => isInHouse = val ?? false),
        ),

        _buildTextFieldMultiline('note', 'Note', noteController,
            keyboardType: TextInputType.multiline),
      ],
    );
  }

  Widget _buildReservationInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Reservation Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField(
            'reservationId', 'Reservation ID', reservationIdController, null,
            enabled: false),
        _buildDateTimePicker('checkInDate', 'Check In Date',
            initialValue: checkInDate),
        _buildDateTimePicker('checkOutDate', 'Check Out Date',
            initialValue: checkOutDate),
        // _buildDateTimePicker('stayDay', 'Stay Day', initialValue: stayDay),
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
        Text('Rate Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        //! Guest has rateType already
        _buildDropdown('rateType', 'Rate Type', _rateTypeOptions,
            initialValue: rateTypeController.text),
        _buildDropdown('rateReason', 'Rate Reason', _rateReasonOptions,
            initialValue: rateReasonController.text),
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
        _buildButton('Save & Check In', () {
          isSaveAndCheckIn = true;
          _saveGuestReservation();
          //      _saveGuest();
          /*  context
                .read<ReservationManageBloc>()
                .add(CheckInReservation(id: int.parse(reservationIdController.text))); */
        }),
        const SizedBox(height: 16),
        /*
        _buildButton(
            'Delete',
            () => context
                .read<ReservationManageBloc>()
                .add(DeleteReservation(id: widget.reservationId!)),
            color: Colors.red),
            */
      ],
    );
  }

/*
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
*/
  Widget _buildTextField(String name, String label,
      TextEditingController controller, void Function(String?)? onChanged,
      {bool enabled = true,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
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

  Widget _buildTextFieldOptional(
      String name, String label, TextEditingController controller,
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

  Widget _buildTextFieldOptionalEmail(
      String name, String label, TextEditingController controller) {
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

  Widget _buildTextFieldPhone(String name, String label,
      TextEditingController controller, void Function(String?)? onChanged) {
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
        validator: FormBuilderValidators.compose(
          [
            FormBuilderValidators.required(),
            FormBuilderValidators.dateTime(errorText: 'invalid datatime')
          ],
        ),
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

  /*
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
 */

/*
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
  */

  /*

  Widget _buildInHouseSwitch() {
    return FormBuilderSwitch(
      name: 'isInHouse',
      title: const  Text('Currently In House'),
      initialValue: isInHouse,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }
\*/

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

  void _onPhoneChanged(String? value) {
    if (value != null && formKey.currentState!.fields['phone']!.isValid) {
      context
          .read<GuestManageBloc>()
          .add(GuestManageRetrieveByPhoneEvent(phone: value.trim()));
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
      'roomId',
      'checkInDate',
      'checkOutDate',
      'roomId',
    ];

    return _validateFields(guestFields);
  }

  bool _validateReservationForm() {
    final reservationFields = [
      'roomId',
      'checkInDate',
      'checkOutDate',
      //   'stayDay',
      'rate',
      'rateReason',
    ];

    return _validateFields(reservationFields);
  }

  bool _validateFields(List<String> fields) {
    bool isValid = true;
    for (var field in fields) {
      if (formKey.currentState?.fields[field]?.validate() == false) {
        //    if (formKey.currentState?.fields[field]?.value == null) {
        isValid = false;
        print('Validation failed for field: $field');
        //    showSnackbar(context, 'Validation failed for field: $field');
      } else {
        //   showSnackbar(context, 'Validation for field: $field');
      }
    }
    return isValid;
  }

  void _saveGuest() {
    late int? id;
    //final id = guestIdController.text ?? null;

    //if ( formKey.currentState?.fields['guestId']?.value ) {

    //}

    if (guestIdController.text.isEmpty) {
      id = null;
    } else {
      id = int.tryParse(guestIdController.text);
    }

    final guest = Guest(
      id: id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
      email: emailController.text.isNotEmpty ? emailController.text : null,
      isInHouse: formKey.currentState!.fields['isInHouse']!.value,
      dateCreate: formKey.currentState!.fields['dateCreate']!.value,
      dateUpdate: formKey.currentState!.fields['dateUpdate']!.value,
      rateType: RateType.values
          .byName(formKey.currentState!.fields['rateType']!.value),
      staffId: 1,
      companyId: 1,
      rigNumber: rigNumberController.text.isNotEmpty
          ? int.parse(rigNumberController.text)
          : null,
      accountBalance: 0,
      note: noteController.text,
    );

    checkInDate = formKey.currentState!.fields['checkInDate']!.value;
    checkOutDate = formKey.currentState!.fields['checkOutDate']!.value;

    context.read<GuestManageBloc>().add(GuestManageSaveEvent(guest: guest));
  }

  void _saveReservation(int guestId) {
    print('Attempting to save reservation for guest ID: $guestId');

    if (_validateReservationForm()) {
      /*
      final checkOutDate = formKey.currentState?.fields['checkOutDate']?.value;
      if (checkOutDate == null) {
        showSnackbar(context, 'Please provide a valid Check Out Date');
        return;
      }
      */

      try {
        // Log each field separately with null checks
        print('Room ID: ${roomIdController.text}');
        print(
            'Is Checked In: ${formKey.currentState?.fields['isCheckedIn']?.value ?? false}');
        print(
            'Is Canceled: ${formKey.currentState?.fields['isCanceled']?.value ?? false}');
        print(
            'Is Night Shift: ${formKey.currentState?.fields['isNightShift']?.value ?? false}');
        print(
            'Date Create: ${formKey.currentState?.fields['dateCreate']?.value ?? TimeManager.instance.now()}');
        print(
            'Date Update: ${formKey.currentState?.fields['dateUpdate']?.value ?? TimeManager.instance.now()}');
        print(
            'Check In Date: ${formKey.currentState?.fields['checkInDate']?.value}');
        print(
            'Check Out Date: ${formKey.currentState?.fields['checkOutDate']?.value ?? TimeManager.instance.today().add(Duration(days: 1))}');
        print('Check Out Date: $checkOutDate');
        print(
            'Stay Day: ${formKey.currentState?.fields['stayDay']?.value ?? TimeManager.instance.today()}');
        print(
            'Rate Type: ${formKey.currentState?.fields['rateType']?.value ?? RateType.standard.name}');
        print('Rate: ${rateController.text}');
        print(
            'Rate Reason: ${formKey.currentState?.fields['rateReason']?.value ?? RateReason.single.name}');

        final reservation = Reservation(
          id: widget.reservationId == null
              ? null
              : int.tryParse(reservationIdController.text),
          guestId: guestId,
          roomId: int.tryParse(roomIdController.text) ?? 0,
          isCheckedIn:
              formKey.currentState?.fields['isCheckedIn']?.value ?? false,
          isCanceled:
              formKey.currentState?.fields['isCanceled']?.value ?? false,
          isNightShift:
              formKey.currentState?.fields['isNightShift']?.value ?? false,
          dateCreate: formKey.currentState?.fields['dateCreate']?.value ??
              TimeManager.instance.now(),
          dateUpdate: formKey.currentState?.fields['dateUpdate']?.value ??
              TimeManager.instance.now(),
          //! should I use now()

          //     checkInDate: formKey.currentState?.fields['checkInDate']?.value ?? TimeManager.instance.today(),
          //   checkInDate: formKey.currentState?.fields['checkInDate']?.value,
          //! May have a bug checkOutDate
          //         checkOutDate: formKey.currentState?.fields['checkOutDate']?.value ?? TimeManager.instance.today().add(Duration(days: 1)),
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          //! stayDay == checkInDay the first day.
          stayDay: formKey.currentState?.fields['checkInDate']?.value ??
              TimeManager.instance.today(),
          //   rateType: RateType.values.byName(formKey.currentState?.fields['rateType']?.value ?? RateType.standard.name),
          rateType: RateType.values.byName(rateTypeController.text),
          rate: double.tryParse(rateController.text) ?? 0.0,
          rateReason: RateReason.values.byName(rateReasonController.text),
          //   rateReason: RateReason.values.byName(formKey.currentState?.fields['rateReason']?.value ?? RateReason.single.name),
          note: noteController.text,
        );

        print('Reservation object created: $reservation');
        context
            .read<ReservationManageBloc>()
            .add(SaveReservation(reservation: reservation));
      } catch (e, stackTrace) {
        print('Error creating reservation object: $e');
        print('Stack trace: $stackTrace');
        showSnackbar(context, 'Error creating reservation: $e');
      }
    } else {
      print('Reservation form validation failed');
      showSnackbar(
          context, 'Please fill all required fields for the reservation');
    }
  }

  void _guestBlocListener(BuildContext context, GuestManageState state) {
    print('Current guest state: $state');
    if (state is GuestManageStateFailure) {
      print(state.message);
      showSnackbar(context, 'Failed to Guest: ${state.message}');
    } else if (state is GuestManageStateSaveSuccess) {
      print('Guest saved successfully. ID: ${state.guest.id}');
      showSnackbar(context,
          'Guest saved success : ${state.guest.lastName} ${state.guest.firstName}');
      _saveReservation(state.guest.id!);
    } else if (state is GuestManageStateRetrieveSuccess) {
      _populateGuestFields(state.guest);
    } else if (state is GuestManageStateRetrieveByPhoneSuccess) {
      _populateGuestFields(state.guest);
    }
  }

  void _reservationBlocListener(
      BuildContext context, ReservationManageState state) {
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
      _populateReservationFields(state.reservation);

      if (isSaveAndCheckIn == true) {
        context.read<ReservationManageBloc>().add(
            CheckInReservation(id: int.parse(reservationIdController.text)));
      }
    } else if (state is ReservationManageStateRetrieveSuccess) {
      _populateReservationFields(state.reservation);
    } else if (state is ReservationManageStateCheckInSuccess) {
      showSnackbar(context, 'Check in successfull ');
      context.read<RoomCalendarBloc>().add(InitializeCalendar());
      context.pop();
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
    noteController.text = guest.note;

    setState(() {
      isInHouse = guest.isInHouse;
      dateCreate = guest.dateCreate;
      dateUpdate = guest.dateUpdate ?? TimeManager.instance.now();
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
    noteController.text =
        reservation.guest == null ? "no note given" : reservation.guest!.note;
    rateTypeController.text = reservation.rateType.name;

    setState(() {
      checkInDate = reservation.checkInDate;
      checkOutDate = reservation.checkOutDate;
      //! stayDay == reservation.CheckInDate
      stayDay = reservation.checkInDate;
      isCheckedIn = reservation.isCheckedIn;
      isCanceled = reservation.isCanceled;
      isNightShift = reservation.isNightShift;
      dateCreate = reservation.dateCreate;
      dateUpdate = reservation.dateUpdate ?? TimeManager.instance.now();
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
