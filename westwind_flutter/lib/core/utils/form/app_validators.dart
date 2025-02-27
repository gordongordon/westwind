// lib/core/validators/app_validators.dart
import 'package:form_builder_validators/form_builder_validators.dart';

class AppValidators {
  // Guest Information Validators
  static String? Function(String?) requiredName = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Name is required'),
    FormBuilderValidators.minLength(2, errorText: 'Name must be at least 2 characters'),
    FormBuilderValidators.maxLength(50, errorText: 'Name cannot exceed 50 characters'),
  ]);
  
  static String? Function(String?) phoneValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Phone number is required'),
    FormBuilderValidators.numeric(errorText: 'Phone must contain only numbers'),
    FormBuilderValidators.minLength(11, errorText: 'Phone number must be at least 10 digits'),
    FormBuilderValidators.maxLength(11, errorText: 'Phone number cannot exceed 11 digits'),
  ]);
  
  static String? Function(String?) emailValidator = FormBuilderValidators.compose([
    FormBuilderValidators.email(errorText: 'Please enter a valid email address'),
    // Email is optional in most forms, so no required validator
  ]);
  
  static String? Function(String?) optionalEmailValidator = FormBuilderValidators.compose([
    FormBuilderValidators.email(errorText: 'Please enter a valid email address if provided'),
  ]);
  
  static String? Function(String?) guestIdValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Guest ID is required'),
    FormBuilderValidators.integer(errorText: 'Guest ID must be a whole number'),
    FormBuilderValidators.min(1, errorText: 'Guest ID must be positive'),
  ]);
  
  static String? Function(String?) rigNumberValidator = FormBuilderValidators.compose([
    FormBuilderValidators.integer(errorText: 'Rig number must be a whole number'),
    FormBuilderValidators.min(0, errorText: 'Rig number cannot be negative'),
  ]);
  
  // Room Information Validators
  static String? Function(String?) roomIdValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Room ID is required'),
    FormBuilderValidators.integer(errorText: 'Room ID must be a whole number'),
    FormBuilderValidators.min(1, errorText: 'Room ID must be positive'),
  ]);
  
  // Financial Validators
  static String? Function(String?) rateValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Rate is required'),
    FormBuilderValidators.numeric(errorText: 'Rate must be a number'),
    FormBuilderValidators.min(0, errorText: 'Rate cannot be negative'),
  ]);
  
  static String? Function(String?) amountValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Amount is required'),
    FormBuilderValidators.numeric(errorText: 'Amount must be a number'),
    FormBuilderValidators.min(0, errorText: 'Amount cannot be negative'),
  ]);
  
  static String? Function(String?) taxValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Tax amount is required'),
    FormBuilderValidators.numeric(errorText: 'Tax must be a number'),
    FormBuilderValidators.min(0, errorText: 'Tax cannot be negative'),
  ]);
  
  static String? Function(String?) totalValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Total is required'),
    FormBuilderValidators.numeric(errorText: 'Total must be a number'),
    FormBuilderValidators.min(0, errorText: 'Total cannot be negative'),
  ]);
  
  // Reservation/Stay Validators
  static String? Function(DateTime?) checkInDateValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Check-in date is required'),
  ]);
  
  static String? Function(DateTime?) checkOutDateValidator(DateTime? checkInDate) {
    return (DateTime? checkOutDate) {
      if (checkOutDate == null) {
        return 'Check-out date is required';
      }
      
      if (checkInDate != null && checkOutDate.isBefore(checkInDate)) {
        return 'Check-out date must be after check-in date';
      }
      
      return null;
    };
  }
  
  // Note/Description Validators
  static String? Function(String?) requiredNoteValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Note is required'),
    FormBuilderValidators.minLength(3, errorText: 'Note must be at least 3 characters'),
  ]);
  
  static String? Function(String?) optionalNoteValidator = FormBuilderValidators.compose([
    FormBuilderValidators.minLength(3, errorText: 'If provided, note must be at least 3 characters'),
  ]);
  
  // Reservation ID Validator
  static String? Function(String?) reservationIdValidator = FormBuilderValidators.compose([
    FormBuilderValidators.integer(errorText: 'Reservation ID must be a whole number'),
    FormBuilderValidators.min(0, errorText: 'Reservation ID cannot be negative'),
  ]);
  
  // Transaction Validators
  static String? Function(String?) transactionIdValidator = FormBuilderValidators.compose([
    FormBuilderValidators.integer(errorText: 'Transaction ID must be a whole number'),
    FormBuilderValidators.min(0, errorText: 'Transaction ID cannot be negative'),
  ]);
  
  static String? Function(String?) approvedCodeValidator = FormBuilderValidators.compose([
    FormBuilderValidators.maxLength(10, errorText: 'Approval code cannot exceed 20 characters'),
  ]);
  
  // Custom validators
  static String? dateRangeValidator(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return 'Both start and end dates are required';
    }
    
    if (endDate.isBefore(startDate)) {
      return 'End date must be after start date';
    }
    
    // Add additional business logic if needed
    // For example, maximum stay duration
    final difference = endDate.difference(startDate).inDays;
    if (difference > 90) {
      return 'Stay duration cannot exceed 90 days';
    }
    
    return null;
  }
  
  static String? Function(String?) rateLimitValidator(double minRate, double maxRate) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Rate is required';
      }
      
      final rate = double.tryParse(value);
      if (rate == null) {
        return 'Rate must be a valid number';
      }
      
      if (rate < minRate) {
        return 'Rate cannot be less than \$${minRate.toStringAsFixed(2)}';
      }
      
      if (rate > maxRate) {
        return 'Rate cannot exceed \$${maxRate.toStringAsFixed(2)}';
      }
      
      return null;
    };
  }

 

// Add this method to your AppValidators class
static String? Function(DateTime?) dynamicRequiredDateTimeValidator(String fieldName) {
  return (DateTime? value) {
    if (value == null) {
      return '$fieldName is required';
    }
    return null;
  };
}
  
  // Dynamic validators
  static String? Function(String?) dynamicRequiredValidator(String fieldName) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: '$fieldName is required'),
    ]);
  }
}