// lib/core/widgets/form_fields.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:westwind_flutter/core/utils/form/app_validators.dart';


class AppFormFields {



  // Helper function to make any validator optional
  // This wraps a validator to only validate if a value is actually provided
  static String? Function(String?) makeOptional(String? Function(String?) validator) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return null; // Accept empty values
      }
      // Only validate non-empty values
      return validator(value);
    };
  }

  static Widget buildTextFieldMultiline(
    {
     required String name,
     required  String label,
     required  TextEditingController controller, 


    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onButtonPressed, // Callback for button press
    VoidCallback? onPressed, 
    }
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.save), // Add your desired button icon here
        //    onPressed: onButtonPressed ?? () {}, // Handle button action
           onPressed: onPressed,
          ),
        ),
        keyboardType: keyboardType,
        maxLines: keyboardType == TextInputType.multiline ? null : 1,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }


  // Text Input Fields
  // Modified buildTextField method with optional 'required' parameter
  static Widget buildTextField({
    required String name,
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? prefixIcon,
    Widget? suffixIcon,
    void Function(String?)? onChanged,
    String? hintText,
    bool obscureText = false,
    bool required = true, // Parameter with default value true
  }) {
    // If field is not required but has a validator, make that validator optional
    final finalValidator = required
        ? (validator ?? FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: '$label is required'),
          ]))
        : (validator != null ? makeOptional(validator) : null);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label, // Add asterisk for required fields
          hintText: hintText,
          border: OutlineInputBorder(),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          helperText: required ? 'Required' : 'Optional', // Add helper text
          helperStyle: TextStyle(
            color: required ? Colors.red.shade300 : Colors.grey,
          ),
        ),
        validator: finalValidator,
        onChanged: onChanged,
      ),
    );
  }
  
  // Name Fields
  static Widget buildNameField({
    required String name,
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    void Function(String?)? onChanged,
  }) {
    return buildTextField(
      name: name,
      label: label,
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.name,
      validator: AppValidators.requiredName,
      prefixIcon: Icons.person,
      onChanged: onChanged,
    );
  }
  
  // Phone Field
  static Widget buildPhoneField({
    required String name,
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    void Function(String?)? onChanged,
  }) {
    return buildTextField(
      name: name,
      label: label,
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      validator: AppValidators.phoneValidator,
      prefixIcon: Icons.phone,
      onChanged: onChanged,
    );
  }
  
  // Email Field
  static Widget buildEmailField({
    required String name,
    required String label,
    required TextEditingController controller,
    bool required = false,
    bool enabled = true,
    void Function(String?)? onChanged,
  }) {
    return buildTextField(
      name: name,
      label: label,
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      validator: required ? AppValidators.emailValidator : AppValidators.optionalEmailValidator,
      prefixIcon: Icons.email,
      onChanged: onChanged,
      required: required,
    );
  }
  
  // ID Fields (Room, Guest, etc.)
  static Widget buildIdField({
    required String name,
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
    bool required = true,
  }) {
    return buildTextField(
      name: name,
      label: label,
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      validator: validator ?? AppValidators.dynamicRequiredValidator(label),
      prefixIcon: Icons.tag,
      onChanged: onChanged,
      required: required,
    );
  }
  
  // Money fields (Rate, Amount, etc.)
  static Widget buildMoneyField({
    required String name,
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
    double? minValue,
    double? maxValue,
    bool required = true,
  }) {
    String? Function(String?)  validatorToUse;
    if (minValue != null && maxValue != null) {
      validatorToUse = AppValidators.rateLimitValidator(minValue, maxValue);
    } else {
      validatorToUse = validator ?? AppValidators.amountValidator;
    }
    
    return buildTextField(
      name: name,
      label: label,
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: validatorToUse,
      prefixIcon: Icons.attach_money,
      onChanged: onChanged,
      required: required,
    );
  }
  
  // Note/Description Field
  static Widget buildNoteField({
    required String name,
    required String label,
    required TextEditingController controller,
    bool required = true,
    bool enabled = true,
    int maxLines = 3,
    void Function(String?)? onChanged,
    VoidCallback? onSavePressed,
    String? Function(String?)? validator,
  }) {
    return buildTextField(
      name: name,
      label: label,
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.multiline,
      maxLines: maxLines,
      validator: validator ?? (required ? AppValidators.requiredNoteValidator : AppValidators.optionalNoteValidator),
      prefixIcon: Icons.note,
      suffixIcon: onSavePressed != null ? 
        IconButton(icon: Icon(Icons.save), onPressed: onSavePressed) : null,
      onChanged: onChanged,
      required: required,
    );
  }
  
// Updated buildDateTimePicker function
static Widget buildDateTimePicker({
  required String name,
  required String label,
  required DateTime initialValue,
  DateTime? firstDate,
  DateTime? lastDate,
  String? Function(DateTime?)? validator,
  bool enabled = true,
  InputType inputType = InputType.date,
  void Function(DateTime?)? onChanged,
  bool required = true,
}) {
  final String? Function(DateTime? p1)? finalValidator = required
      ? (validator ?? AppValidators.dynamicRequiredDateTimeValidator(label))
      : (validator != null 
          ? (DateTime? value) => value == null ? null : validator(value) 
          : null);
          
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: FormBuilderDateTimePicker(
      name: name,
      initialValue: initialValue,
      inputType: inputType,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_today),
        helperText: required ? 'Required' : 'Optional',
        helperStyle: TextStyle(
          color: required ? Colors.red.shade300 : Colors.grey,
        ),
      ),
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(2030),
      validator: finalValidator,
      onChanged: onChanged,
    ),
  );
}
  
  // Check-In/Check-Out Date Fields (with validation between them)
  static Widget buildCheckInDatePicker({
    required String name,
    required String label,
    required DateTime initialValue,
    required void Function(DateTime?) onChanged,
    bool enabled = true,
  }) {
    return buildDateTimePicker(
      name: name,
      label: label,
      initialValue: initialValue,
      enabled: enabled,
      validator: AppValidators.checkInDateValidator,
      onChanged: onChanged,
      firstDate: DateTime.now().subtract(Duration(days: 30)), // Allow backdated check-ins for 30 days
      lastDate: DateTime.now().add(Duration(days: 365)), // Allow booking up to a year in advance
    );
  }
  
  static Widget buildCheckOutDatePicker({
    required String name,
    required String label,
    required DateTime initialValue,
    required DateTime checkInDate,
    required void Function(DateTime?) onChanged,
    bool enabled = true,
  }) {
    return buildDateTimePicker(
      name: name,
      label: label,
      initialValue: initialValue,
      enabled: enabled,
      validator: AppValidators.checkOutDateValidator(checkInDate),
      onChanged: onChanged,
      firstDate: checkInDate.add(Duration(days: 1)), // Must be at least 1 day after check-in
      lastDate: checkInDate.add(Duration(days: 90)), // Maximum stay of 90 days
    );
  }
  
  // Dropdown Field
  static Widget buildDropdown({
    required String name,
    required String label,
    required List<String> options,
    required String initialValue,
    String? Function(String?)? validator,
    bool enabled = true,
    void Function(String?)? onChanged,
    IconData? prefixIcon,
    bool required = true,
  }) {
    final String? Function(String? p1)? finalValidator = required
        ? (validator ?? AppValidators.dynamicRequiredValidator(label))
        : (validator != null ? makeOptional(validator) : null);
            
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderDropdown<String>(
        name: name,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: OutlineInputBorder(),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          helperText: required ? 'Required' : 'Optional',
          helperStyle: TextStyle(
            color: required ? Colors.red.shade300 : Colors.grey,
          ),
        ),
        initialValue: initialValue,
        items: options
            .map((option) => DropdownMenuItem(value: option, child: Text(option)))
            .toList(),
        validator: finalValidator,
        onChanged: onChanged,
      ),
    );
  }
  
  // Switch Field
  static Widget buildSwitch({
    required String name,
    required String label,
    required bool initialValue,
    bool enabled = true,
    void Function(bool?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FormBuilderSwitch(
        name: name,
        title: Text(label),
        initialValue: initialValue,
        enabled: enabled,
        onChanged: onChanged,
      ),
    );
  }
  
  // Rate Type Dropdown
  static Widget buildRateTypeDropdown({
    required String name,
    required String initialValue,
    required List<String> options,
    bool enabled = true,
    void Function(String?)? onChanged,
    bool required = true,
  }) {
    return buildDropdown(
      name: name,
      label: 'Rate Type',
      options: options,
      initialValue: initialValue,
      enabled: enabled,
      onChanged: onChanged,
      prefixIcon: Icons.attach_money,
      required: required,
    );
  }
  
  // Rate Reason Dropdown
  static Widget buildRateReasonDropdown({
    required String name,
    required String initialValue,
    required List<String> options,
    bool enabled = true,
    void Function(String?)? onChanged,
    bool required = true,
  }) {
    return buildDropdown(
      name: name,
      label: 'Rate Reason',
      options: options,
      initialValue: initialValue,
      enabled: enabled,
      onChanged: onChanged,
      prefixIcon: Icons.category,
      required: required,
    );
  }
  
  // Form Section Header
  static Widget buildSectionHeader(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
  
  // Form Button
  static Widget buildActionButton({
    required String text,
    required VoidCallback onPressed,
    Color color = Colors.blue,
    bool fullWidth = true,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: fullWidth ? Size(double.infinity, 50) : null,
          padding: EdgeInsets.symmetric(
            horizontal: fullWidth ? 24 : 16,
            vertical: 12,
          ),
        ),
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon),
              SizedBox(width: 8),
            ],
            Text(text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}