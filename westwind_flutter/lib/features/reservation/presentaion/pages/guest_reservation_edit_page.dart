import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/exception.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/core/widgets/app_form_fields.dart';
import 'package:westwind_flutter/core/utils/form/app_validators.dart';
import 'package:westwind_flutter/core/utils/form/form_helpers.dart';
import 'package:westwind_flutter/core/widgets/loader.dart';
import 'package:westwind_flutter/features/guest/presentation/bloc/guest_manage/guest_manage_bloc.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/reservation_manage/bloc/reservation_manage_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';

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
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Guest>> getDataByName(filter) async {
    try {
      var client = Client(
        "https://westwind-app-b00b64c234f3.herokuapp.com/api/",
        authenticationKeyManager: FlutterAuthenticationKeyManager(),
      )
        ..connectivityMonitor = FlutterConnectivityMonitor();

      var response = client.guest.retrieveGuestByName(name: filter);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }


  Future<List<Guest>> getDataByLastName(filter) async {
    try {
      var client = await Client(
        "https://westwind-app-b00b64c234f3.herokuapp.com/api/",
        authenticationKeyManager: FlutterAuthenticationKeyManager(),
      )
        ..connectivityMonitor = FlutterConnectivityMonitor();

      var response = client.guest.retrieveGuestByLastName(lastName: filter);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<List<Guest>> getDataByFirstName(filter) async {
    try {
      var client = await Client(
        "https://westwind-app-b00b64c234f3.herokuapp.com/api/",
        authenticationKeyManager: FlutterAuthenticationKeyManager(),
      )
        ..connectivityMonitor = FlutterConnectivityMonitor();

      var response = client.guest.retrieveGuestByFirstName(firstName: filter);
      return response;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Widget _buildGuestInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Guest Information'),

        // Guest Search Dropdown
        DropdownSearch<Guest>(
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              labelText: 'Click to search guest by last or first name',
              border: OutlineInputBorder(),
            ),
          ),
          items: (f, cs) => getDataByName(f),
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
          dropdownBuilder: (context, selectedItem) {
            if (selectedItem == null) {
              return SizedBox.shrink();
            }

            return ListTile(
              contentPadding: EdgeInsets.only(left: 0),
              leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(selectedItem.lastName[0])),
              title: Text('${selectedItem.lastName}, ${selectedItem.firstName}'),
              subtitle: Text(
                  ' ${selectedItem.rateType} / Tel : ${selectedItem.phone}'),
            );
          },

          popupProps: PopupProps.menu(
            disableFilter: true,
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
                title: Text('${item.lastName}, ${item.firstName}'),
                subtitle: Text(' ${item.rateType} / Tel : ${item.phone}'),
              );
            },
          ),
        ),


        const SizedBox(height: 16),

        // Phone Field
        AppFormFields.buildPhoneField(
          name: 'phone',
          label: 'Phone',
          controller: phoneController,
          onChanged: _onPhoneChanged,
        ),

        // Guest ID Field
        AppFormFields.buildIdField(
          name: 'guestId',
          label: 'Guest ID',
          controller: guestIdController,
          enabled: false,
          required: false,
        ),

        // Name Fields
        AppFormFields.buildNameField(
          name: 'firstName',
          label: 'First Name',
          controller: firstNameController,
        ),

        AppFormFields.buildNameField(
          name: 'lastName',
          label: 'Last Name',
          controller: lastNameController,
        ),

        // Email Field
        AppFormFields.buildEmailField(
          name: 'email',
          label: 'Email',
          controller: emailController,
          required: false,
        ),

        // Rig Number Field
        AppFormFields.buildIdField(
          name: 'rigNumber',
          label: 'Rig Number',
          controller: rigNumberController,
          validator: AppValidators.rigNumberValidator,
          required: false,
        ),

        // Is In House Switch
        AppFormFields.buildSwitch(
          name: 'isInHouse',
          label: 'Is in House',
          initialValue: isInHouse,
          onChanged: (val) => setState(() => isInHouse = val ?? false),
        ),

        // Notes Field
        AppFormFields.buildNoteField(
          name: 'note',
          label: 'Note',
          controller: noteController,
          required: false,
        ),
      ],
    );
  }

  Widget _buildReservationInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Reservation Information'),

        // Reservation ID Field
        AppFormFields.buildIdField(
          name: 'reservationId',
          label: 'Reservation ID',
          controller: reservationIdController,
          enabled: false,
          required: false,
        ),

        // Check-in Date
        AppFormFields.buildCheckInDatePicker(
          name: 'checkInDate',
          label: 'Check In Date',
          initialValue: checkInDate,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                checkInDate = val;
                // Update check-out date to be at least one day after check-in
                if (checkOutDate.isBefore(checkInDate.add(Duration(days: 1)))) {
                  checkOutDate = checkInDate.add(Duration(days: 1));
                  formKey.currentState?.fields['checkOutDate']
                      ?.didChange(checkOutDate);
                }
              });
            }
          },
        ),

        // Check-out Date
        AppFormFields.buildCheckOutDatePicker(
          name: 'checkOutDate',
          label: 'Check Out Date',
          initialValue: checkOutDate,
          checkInDate: checkInDate,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                checkOutDate = val;
              });
            }
          },
        ),

        // Room ID Field
        AppFormFields.buildIdField(
          name: 'roomId',
          label: 'Room ID',
          controller: roomIdController,
          validator: AppValidators.roomIdValidator,
        ),

        // Status Switches
        AppFormFields.buildSwitch(
          name: 'isCheckedIn',
          label: 'Is Checked In',
          initialValue: isCheckedIn,
          onChanged: (val) => setState(() => isCheckedIn = val ?? false),
        ),

        AppFormFields.buildSwitch(
          name: 'isCanceled',
          label: 'Is Canceled',
          initialValue: isCanceled,
          onChanged: (val) => setState(() => isCanceled = val ?? false),
        ),

        AppFormFields.buildSwitch(
          name: 'isNightShift',
          label: 'Is Night Shift',
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
        AppFormFields.buildSectionHeader(context, 'Rate Information'),

        // Rate Type Dropdown
        AppFormFields.buildRateTypeDropdown(
          name: 'rateType',
          initialValue: rateTypeController.text,
          options: _rateTypeOptions,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                rateTypeController.text = val;
              });
            }
          },
        ),

        // Rate Reason Dropdown
        AppFormFields.buildRateReasonDropdown(
          name: 'rateReason',
          initialValue: rateReasonController.text,
          options: _rateReasonOptions,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                rateReasonController.text = val;
              });
            }
          },
        ),

        // Rate Amount Field
        AppFormFields.buildMoneyField(
          name: 'rate',
          label: 'Rate',
          controller: rateController,
          validator: AppValidators.rateValidator,
          minValue: 0,
          maxValue: 999.99,
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Additional Information'),

        // Created/Updated Date Fields
        AppFormFields.buildDateTimePicker(
          name: 'dateCreate',
          label: 'Date Created',
          initialValue: dateCreate,
          enabled: false,
        ),

        AppFormFields.buildDateTimePicker(
          name: 'dateUpdate',
          label: 'Date Updated',
          initialValue: dateUpdate,
          enabled: false,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 24),

        // Save & Check In button
        AppFormFields.buildActionButton(
          text: 'Save & Check In',
          onPressed: () {
            isSaveAndCheckIn = true;
            _saveGuestReservation();
          },
          icon: Icons.save_outlined,
        ),

        // Delete button (if in edit mode)
        if (isReservationEditing)
          AppFormFields.buildActionButton(
            text: 'Delete Reservation',
            onPressed: () => context
                .read<ReservationManageBloc>()
                .add(DeleteReservation(id: widget.reservationId!)),
            color: Colors.red,
            icon: Icons.delete_outline,
          ),
      ],
    );
  }

  void _onPhoneChanged(String? value) {
    if (value != null && formKey.currentState!.fields['phone']!.isValid) {
      context
          .read<GuestManageBloc>()
          .add(GuestManageRetrieveByPhoneEvent(phone: value.trim()));
    }
  }

  void _saveGuestReservation() {
    if (FormHelpers.validateForm(formKey, context) && _validateGuestForm()) {
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
    ];

    return _validateFields(guestFields);
  }

  bool _validateReservationForm() {
    final reservationFields = [
      'roomId',
      'checkInDate',
      'checkOutDate',
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
    int? id;
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
      try {
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
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          stayDay: formKey.currentState?.fields['checkInDate']?.value ??
              TimeManager.instance.today(),
          rateType: RateType.values.byName(rateTypeController.text),
          rate: double.tryParse(rateController.text) ?? 0.0,
          rateReason: RateReason.values.byName(rateReasonController.text),
          note: noteController.text,
        );

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
      _populateReservationFields(state.reservation);

      if (isSaveAndCheckIn == true) {
        context.read<ReservationManageBloc>().add(
            CheckInReservation(id: int.parse(reservationIdController.text)));
      }
    } else if (state is ReservationManageStateRetrieveSuccess) {
      _populateReservationFields(state.reservation);
    } else if (state is ReservationManageStateCheckInSuccess) {
      showSnackbar(context, 'Check in successful');
      context.read<RoomCalendarBloc>().add(InitializeCalendar());
      context.pop();
    }
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
