import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/utils/form/app_validators.dart';
import 'package:westwind_flutter/core/utils/form/form_helpers.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';
import 'package:westwind_flutter/core/utils/timeManager.dart';
import 'package:westwind_flutter/core/widgets/app_form_fields.dart';
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
  State<GuestEditPage> createState() => _GuestEditPageState();
}

class _GuestEditPageState extends State<GuestEditPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController idController = TextEditingController(text: "0");
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController rigNumberController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime dateCreate = TimeManager.instance.now();
  DateTime dateUpdate = TimeManager.instance.now();
  bool isInHouse = false;

  final List<String> _rateTypeOptions =
      RateType.values.map((e) => e.name).toList();

  bool get isEditing => widget.guestId != null && widget.guestId! > 0;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      context
          .read<GuestManageBloc>()
          .add(GuestManageRetrieveEvent(id: widget.guestId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Guest" : "New Guest"),
        actions: [
          IconButton(
            onPressed: _saveGuest,
            icon: Icon(Icons.save),
            tooltip: 'Save Guest',
          ),
        ],
      ),
      body: BlocConsumer<GuestManageBloc, GuestManageState>(
        listener: _blocListener,
        builder: (context, state) {
          if (state is GuestManageStateLoading) {
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
              _buildPersonalInfoSection(),
              _buildContactInfoSection(),
              _buildAdditionalInfoSection(),
              if (isEditing) _buildDeleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Personal Information'),
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
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Contact Information'),
        AppFormFields.buildPhoneField(
          name: 'phone',
          label: 'Phone Number',
          controller: phoneController,
          onChanged: _onPhoneChanged,
        ),
        AppFormFields.buildEmailField(
          name: 'email',
          label: 'Email Address',
          controller: emailController,
          required: false,
        ),
      ],
    );
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormFields.buildSectionHeader(context, 'Additional Information'),
        AppFormFields.buildRateTypeDropdown(
          name: 'rateType',
          initialValue: _rateTypeOptions.first,
          options: _rateTypeOptions,
          onChanged: (value) => {},
        ),
        AppFormFields.buildIdField(
          name: 'rigNumber',
          label: 'Rig Number',
          controller: rigNumberController,
          validator: AppValidators.rigNumberValidator,
          required: false,
        ),
        AppFormFields.buildSwitch(
          name: 'isInHouse',
          label: 'Currently In House',
          initialValue: isInHouse,
          onChanged: (value) => setState(() => isInHouse = value ?? false),
        ),
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
        AppFormFields.buildNoteField(
          name: 'note',
          label: 'Note to Guest',
          controller: noteController,
          required: false,
        ),
      ],
    );
  }

  Widget _buildDeleteButton() {
    return AppFormFields.buildActionButton(
      text: 'Delete Guest',
      onPressed: () {
        context
            .read<GuestManageBloc>()
            .add(GuestManageDeleteEvent(id: widget.guestId!));
      },
      color: Colors.red,
    );
  }

  void _showValidationErrors(FormBuilderState formState) {
    // This will force the form to show error messages
    formState.validate();

    // You can also manually traverse the form fields
    formState.fields.forEach((key, formFieldState) {
      if (formFieldState.hasError) {
        print("Field '$key' error: ${formFieldState.errorText}");
      }
    });
  }

  void _saveGuest() {
    final formState = formKey.currentState;

    if (formState != null) {
      bool isValid = FormHelpers.validateForm(formKey, context);
      if (isValid) {
        final guest = Guest(
          id: widget.guestId,
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

        context.read<GuestManageBloc>().add(GuestManageSaveEvent(guest: guest));
      } else {
        // Form validation is now handled by FormHelpers.validateForm
      }
    } else {
      print("Form state is null");
    }
  }

  void _onPhoneChanged(String? value) {
    if (value != null && value.isNotEmpty && 
        formKey.currentState?.fields['phone']?.valueIsValid == true) {
      context
          .read<GuestManageBloc>()
          .add(GuestManageRetrieveByPhoneEvent(phone: value.trim()));
    }
  }

  void _blocListener(BuildContext context, GuestManageState state) {
    if (state is GuestManageStateFailure) {
      showSnackbar(context, state.message);
    } else if (state is GuestManageStateSaveSuccess) {
      context.read<GuestListBloc>().add(FetchGuestsEvent());
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
    } else if (state is GuestManageStateRetrieveSuccess ||
        state is GuestManageStateRetrieveByPhoneSuccess) {
      _populateFormFields(state is GuestManageStateRetrieveSuccess
          ? state.guest
          : (state as GuestManageStateRetrieveByPhoneSuccess).guest);
    }
  }

  void _populateFormFields(Guest guest) {
    idController.text = guest.id.toString();
    firstNameController.text = guest.firstName;
    lastNameController.text = guest.lastName;
    emailController.text = guest.email ?? "";
    phoneController.text = guest.phone;
    isInHouse = guest.isInHouse;
    dateCreate = guest.dateCreate;
    dateUpdate = guest.dateUpdate!;
    rigNumberController.text = guest.rigNumber?.toString() ?? "";
    noteController.text = guest.note;
    
    // Update the dropdown value
    formKey.currentState?.patchValue({'rateType': guest.rateType.name});
    
    // Update the switch
    formKey.currentState?.patchValue({'isInHouse': guest.isInHouse});
    
    // Force a rebuild to show updated values
    setState(() {});
  }
}