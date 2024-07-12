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
  State<GuestEditPage> createState() => _GuestEditPageState();
}

class _GuestEditPageState extends State<GuestEditPage> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController idController = TextEditingController(text: "0");
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController rateTypeController = TextEditingController();
  final TextEditingController rigNumberController = TextEditingController();

  DateTime dateCreate = DateTime.now();
  DateTime dateUpdate = DateTime.now();
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
        Text('Personal Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('firstName', 'First Name', firstNameController),
        _buildTextField('lastName', 'Last Name', lastNameController),
        // _buildTextField('firstName', 'First Name', firstNameController),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Contact Information',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        _buildTextField('phone', 'Phone Number', phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            onChanged: _onPhoneChanged),
   _buildTextFieldOptionalEmail('email','Email Address', emailController,         
      //  _buildTextField('email', 'Email Address', emailController,
            keyboardType: TextInputType.emailAddress),
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
        _buildRateTypeDropdown(),
        const SizedBox(height: 16),
        _buildTextFieldOptional('rigNumber', 'Rig Number', rigNumberController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        _buildInHouseSwitch(),
        const SizedBox(height: 16),
        _buildDateField('dateCreate', 'Date Created', dateCreate),
        _buildDateField('dateUpdate', 'Date Updated', dateUpdate),
      ],
    );
  }

  Widget _buildTextField(
      String name, String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      int? maxLength,
      Function(String)? onChanged}) {
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
        validator: FormBuilderValidators.compose([
          if (name != 'email' && name != 'rigNumber')
            FormBuilderValidators.required(),
          if (name == 'email') FormBuilderValidators.email(),
          if (name == 'phone') FormBuilderValidators.numeric(),
        ]),
      ),
    );
  }


  Widget _buildTextFieldOptionalEmail(
      String name, String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      int? maxLength,
      Function(String)? onChanged}) {
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
         validator: FormBuilderValidators.compose([
          FormBuilderValidators.email()
         ]),
      ),
    );
  }


  Widget _buildTextFieldOptional(
      String name, String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      int? maxLength,
      Function(String)? onChanged}) {
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

  Widget _buildRateTypeDropdown() {
    return FormBuilderDropdown<String>(
      name: 'rateType',
      initialValue: rateTypeController.text,
      decoration: InputDecoration(
        labelText: 'Rate Type',
        border: OutlineInputBorder(),
      ),
      items: _rateTypeOptions
          .map((rateType) =>
              DropdownMenuItem(value: rateType, child: Text(rateType)))
          .toList(),
      validator:
          FormBuilderValidators.compose([FormBuilderValidators.required()]),
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

  Widget _buildDateField(String name, String label, DateTime initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderDateTimePicker(
        name: name,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        initialValue: initialValue,
        inputType: InputType.date,
        enabled: false,
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          context
              .read<GuestManageBloc>()
              .add(GuestManageDeleteEvent(id: widget.guestId!));
        },
        child: Text('Delete Guest'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
        ),
      ),
    );
  }


  void _showValidationErrors(FormBuilderState formState) {
  // This will force the form to show error messages
  formState.validate();
  
  // You can also manually traverse the form fields

  formState.fields.forEach((key, formFieldState) {
    if (formFieldState.hasError) {
      print("Field '${key}' error: ${formFieldState.errorText}");
    }
  });
}

  void _saveGuest() {

final formState = formKey.currentState;

  

if (formState != null) {
  bool isValid = formState.validate();
        _showValidationErrors(formState);
  if (isValid) {
      final guest = Guest(
        id: widget.guestId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
        email: emailController.text,
        isInHouse: formKey.currentState!.fields['isInHouse']!.value,
        dateCreate: formKey.currentState!.fields['dateCreate']!.value,
        dateUpdate: formKey.currentState!.fields['dateUpdate']!.value,
        rateType: RateType.values
            .byName(formKey.currentState!.fields['rateType']!.value),
        staffId: 1,
        companyId: 1,
        rigNumber: int.parse(rigNumberController.text),
        accountBalance: 0,
      );
          _showValidationErrors(formState);

      context.read<GuestManageBloc>().add(GuestManageSaveEvent(guest: guest));
  } else {
    // Handle invalid form
    _showValidationErrors(formState);
  }
} else {
  
  print("Form state is null");
}

/*

    if ( formKey.currentState?.saveAndValidate() ?? false ) {
      final guest = Guest(
        id: widget.guestId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
        email: emailController.text,
        isInHouse: formKey.currentState!.fields['isInHouse']!.value,
        dateCreate: formKey.currentState!.fields['dateCreate']!.value,
        dateUpdate: formKey.currentState!.fields['dateUpdate']!.value,
        rateType: RateType.values
            .byName(formKey.currentState!.fields['rateType']!.value),
        staffId: 1,
        companyId: 1,
        rigNumber: int.parse(rigNumberController.text),
        accountBalance: 0,
      );

      context.read<GuestManageBloc>().add(GuestManageSaveEvent(guest: guest));
    }
    */
  }

  void _onPhoneChanged(String value) {
    if (formKey.currentState!.fields['phone']!.valueIsValid) {
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
    if (guest.email != null) {
      emailController.text = guest.email!;
    } else {
      emailController.text = "";
    }
    phoneController.text = guest.phone;
    rateTypeController.text = guest.rateType.toString();
    isInHouse = guest.isInHouse;
    dateCreate = guest.dateCreate;
    dateUpdate = guest.dateUpdate!;
    if (guest.rigNumber == null) {
      rigNumberController.text = "";
    } else {
      rigNumberController.text = guest.rigNumber.toString();
    }

    //  formKey.currentState?.patchValue({'rateType': guest.rateType.name});
  }
}
