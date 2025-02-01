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
import 'package:westwind_flutter/features/reservation/presentaion/bloc/room_Calendar/room_calendar_bloc.dart';
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
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController idController = TextEditingController(text: "0");
  final TextEditingController roomIdController = TextEditingController();
  final TextEditingController guestIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController rateTypeController = TextEditingController();
  final TextEditingController rigNumberController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController rateReasonController = TextEditingController();
  final TextEditingController reservationIdController =
      TextEditingController(); //
  final TextEditingController noteController =
      TextEditingController(text: "write messages to room guest state only");
  final TextEditingController balanceController = TextEditingController();
  // final TextEditingController noteController = TextEditingController();

  late DateTime checkInDate;
  DateTime stayDay = TimeManager.instance.today();
  DateTime updatedDate = TimeManager.instance.today();
  DateTime checkOutDate = TimeManager.instance.today();
  bool isCheckOut = false;

  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toSet().toList();

  final List<String> _rateReasonOptions =
      RateReason.values.map((e) => e.name).toList();

  bool get isEditing => widget.roomGuestId != null && widget.roomGuestId! > 0;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      context
          .read<RoomGuestManageBloc>()
          .add(RetrieveRoomGuest(widget.roomGuestId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing
            ? "Edit Room Guest :  ${lastNameController.text} , ${firstNameController.text} : Room# : ${roomIdController.text} : Balance \$${balanceController.text}"
            : "New Room Guest"),
        actions: [
          IconButton(
            onPressed: _saveRoomGuest,
            icon: Icon(Icons.save),
            tooltip: 'Save Room Guest',
          ),
        ],
      ),
      body: BlocConsumer<RoomGuestManageBloc, RoomGuestManageState>(
        listener: _blocListener,
        builder: (context, state) {
          if (state is RoomGuestManageStateLoading) {
            return const Loader();
          }
          return _buildForm();
        },
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
              _buildStayInfoSection(),
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
        Text('Note to Room Guest State only',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextFieldMultiline('note', 'Note to Room Guest', noteController,
            keyboardType: TextInputType.multiline),
        Text('Guest Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('id', 'ID', idController, enabled: false),
        _buildTextField('lastName', 'Last Name', lastNameController,
            enabled: false),
        _buildTextField('firstName', 'First Name', firstNameController,
            enabled: false),
        //   _buildTextField('guestId', 'Guest ID', guestIdController, keyboardType: TextInputType.number),
        _buildTextField('rigNumber', 'Rig Number', rigNumberController,
            keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildStayInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Stay Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildDateTimePicker('stayDay', 'Stay Day', initialValue: stayDay),
        _buildDateTimePicker('checkOutDate', 'Check Out Date',
            initialValue: checkOutDate),
        _buildTextField('roomId', 'Room ID', roomIdController,
            keyboardType: TextInputType.number),
        _buildTextField(
            'reservationId', 'Reservation ID', reservationIdController,
            enabled: false),
        FormBuilderSwitch(
          name: 'isCheckOut',
          title: const Text('Is Check Out'),
          initialValue: isCheckOut,
          onChanged: (val) => setState(() => isCheckOut = val ?? false),
        ),
      ],
    );
  }

  Widget _buildRateInfoSection() {
    print('print rateTypeOptions $_rateTypeOptions');
    print('RateTable ${RateType.values}');

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
        _buildTextField('rate', 'Rate', rateController,
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
        _buildDateTimePicker('updateDate', 'Update Date',
            initialValue: updatedDate, enabled: false),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildButton(
            'Charge & Extend',
            () => context
                .read<RoomGuestManageBloc>()
                .add(ChargeAndExtendStayDay(id: widget.roomGuestId!))),
/*
        const SizedBox(height: 16),
        _buildButton(
            'Calculate Rate',
            () => context
                .read<RoomGuestManageBloc>()
                .add(CalculateRateRoomGuest(widget.roomGuestId!))),
*/

/*
        const SizedBox(height: 16),
        _buildButton(
            'Delete',
            () => context
                .read<RoomGuestManageBloc>()
                .add(DeleteRoomGuest(widget.roomGuestId!)),
            color: Colors.red)
            */

//            ,
      ],
    );
  }

  Widget _buildTextField(
      String name, String label, TextEditingController controller,
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
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required()]),
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
    print('** Print Options : $options');

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

  void _saveRoomGuest() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final roomGuest = RoomGuest(
        id: widget.roomGuestId,
        guestId: int.parse(guestIdController.text),
        roomId: int.parse(roomIdController.text),
        stayDay: formKey.currentState!.fields['stayDay']!.value,
        updateDate: formKey.currentState!.fields['updateDate']!.value,
        // checkInDate: TimeManager.instance.now(),

        checkInDate: checkInDate,
        checkOutDate: formKey.currentState!.fields['checkOutDate']!.value,
        rateType: RateType.values
            .byName(formKey.currentState!.fields['rateType']!.value),
        rate: double.parse(rateController.text),
        rateReason: RateReason.values
            .byName(formKey.currentState!.fields['rateReason']!.value),
        roomStatus: RoomStatus.VCC,
        reservationId: int.parse(reservationIdController.text),
        isCheckOut: isCheckOut,
        note: noteController.text,
      );

      context.read<RoomGuestManageBloc>().add(SaveRoomGuest(roomGuest));
    } 
  }

  void _blocListener(BuildContext context, RoomGuestManageState state) {
    if (state is RoomGuestManageStateFailure) {
      showSnackbar(context, state.message);
    } else if (state is RoomGuestManageStateSaveSuccess) {
      context
          .read<RoomGuestManageBloc>()
          .add(CalculateRateRoomGuest(widget.roomGuestId!));
    } else if (state is RoomGuestManageStateCalculateRateSuccess ||
        state is RoomGuestManageStateDeleteSuccess ||
        state is RoomGuestManageStateChargeAndExtendStayDaySuccess) {


      //! should handle back to ButCo or with CO ?? 
      context.read<RoomGuestListBloc>().add(FetchRoomGuestsButCOEvent());

      //! Handle exit to Calendar
      context.read<RoomCalendarBloc>().add(InitializeCalendar());
      context.pop();
    } else if (state is RoomGuestManageStateRetrieveSuccess) {
      _populateFields(state.roomGuest);
    }
  }

  void _populateFields(RoomGuest roomGuest) {
    final List<RoomTransaction>? transactions = roomGuest.roomTransactions;
    double totalSum = 0;

    if (transactions != null) {
      for (RoomTransaction transaction in transactions) {
        totalSum += transaction.total;
      }
    }

    idController.text = roomGuest.id!.toString();
    guestIdController.text = roomGuest.guestId.toString();
    // roomIdController.text = roomGuest.roomId.toString();
    rateController.text = roomGuest.rate.toString();
    rateReasonController.text = roomGuest.rateReason.toString();
    rateTypeController.text = roomGuest.rateType.toString();
    firstNameController.text = roomGuest.guest!.firstName;
    lastNameController.text = roomGuest.guest!.lastName;
    reservationIdController.text = roomGuest.reservationId.toString();
    rigNumberController.text = roomGuest.guest!.rigNumber.toString();
    noteController.text = roomGuest.note;
    checkInDate = roomGuest.checkInDate;
    // balanceController.text = roomGuest.guest!.accountBalance.toString();

    setState(() {
      checkOutDate = roomGuest.checkOutDate;
      stayDay = roomGuest.stayDay;
      isCheckOut = roomGuest.isCheckOut;
      roomIdController.text = roomGuest.roomId.toString();
      //    balanceController.text = roomGuest.guest!.accountBalance.toString();
      balanceController.text =
          double.parse(totalSum.toStringAsFixed(2)).toString();
    });

    formKey.currentState?.patchValue({
      'rateType': roomGuest.rateType.name,
      'rateReason': roomGuest.rateReason.name,
    });
  }
}
