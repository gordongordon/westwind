// lib/core/utils/form_helpers.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:westwind_flutter/core/utils/show_snackbar.dart';

class FormHelpers {
  /// Validates a form and returns whether it was successful
  static bool validateForm(GlobalKey<FormBuilderState> formKey, BuildContext context) {
    final isValid = formKey.currentState?.saveAndValidate() ?? false;
    
    if (!isValid) {
      // Get all the errors from the form
      Map<String, dynamic> formErrors = {};
      formKey.currentState?.fields.forEach((key, field) {
        if (field.hasError) {
          formErrors[key] = field.errorText;
        }
      });
      
      if (formErrors.isNotEmpty) {
        // Get the first error message to show in a snackbar
        final firstErrorText = formErrors.values.first ?? 'Please check the form for errors';
        showSnackbar(context, firstErrorText);
      } else {
        showSnackbar(context, 'Please check the form for errors');
      }
    }
    
    return isValid;
  }

  
  
  /// Updates calculated values based on form field changes
  static void calculateRoomTransactionTotal({
    required TextEditingController amountController,
    required TextEditingController tax1Controller,
    required TextEditingController tax2Controller,
    required TextEditingController totalController,
  }) {
    try {
      final amount = double.tryParse(amountController.text) ?? 0.0;
      final tax1 = double.tryParse(tax1Controller.text) ?? 0.0;
      final tax2 = double.tryParse(tax2Controller.text) ?? 0.0;
      
      final total = amount + tax1 + tax2;
      totalController.text = total.toStringAsFixed(2);
    } catch (_) {
      // Handle parsing errors
      totalController.text = "0.00";
    }
  }
  
  /// Calculates GST (tax1) and levy (tax2) for a room rate automatically
  static void calculateTaxesFromAmount({
    required TextEditingController amountController,
    required TextEditingController tax1Controller,
    required TextEditingController tax2Controller,
    required TextEditingController totalController,
    double gstRate = 0.05, // 5% GST
    double levyRate = 0.04, // 4% tourism levy
  }) {
    try {
      final amount = double.tryParse(amountController.text) ?? 0.0;
      
      final tax1 = amount * gstRate;
      final tax2 = amount * levyRate;
      final total = amount + tax1 + tax2;
      
      tax1Controller.text = tax1.toStringAsFixed(2);
      tax2Controller.text = tax2.toStringAsFixed(2);
      totalController.text = total.toStringAsFixed(2);
    } catch (_) {
      // Handle parsing errors
      tax1Controller.text = "0.00";
      tax2Controller.text = "0.00";
      totalController.text = "0.00";
    }
  }
  
  /// Sets up listeners for automatic calculation of totals
  static void setupTaxCalculationListeners({
    required TextEditingController amountController,
    required TextEditingController tax1Controller,
    required TextEditingController tax2Controller,
    required TextEditingController totalController,
    required bool calculateTaxesAutomatically,
  }) {
    // Remove any existing listeners first
    amountController.removeListener(() {});
    tax1Controller.removeListener(() {});
    tax2Controller.removeListener(() {});
    
    if (calculateTaxesAutomatically) {
      // If automatic, calculate taxes when amount changes
      amountController.addListener(() {
        calculateTaxesFromAmount(
          amountController: amountController,
          tax1Controller: tax1Controller,
          tax2Controller: tax2Controller,
          totalController: totalController,
        );
      });
    } else {
      // If manual, calculate total when any value changes
      amountController.addListener(() {
        calculateRoomTransactionTotal(
          amountController: amountController,
          tax1Controller: tax1Controller,
          tax2Controller: tax2Controller,
          totalController: totalController,
        );
      });
      
      tax1Controller.addListener(() {
        calculateRoomTransactionTotal(
          amountController: amountController,
          tax1Controller: tax1Controller,
          tax2Controller: tax2Controller,
          totalController: totalController,
        );
      });
      
      tax2Controller.addListener(() {
        calculateRoomTransactionTotal(
          amountController: amountController,
          tax1Controller: tax1Controller,
          tax2Controller: tax2Controller,
          totalController: totalController,
        );
      });
    }
  }
  
  /// Clean up listeners to prevent memory leaks
  static void cleanupTaxCalculationListeners({
    required TextEditingController amountController,
    required TextEditingController tax1Controller,
    required TextEditingController tax2Controller,
  }) {
    amountController.removeListener(() {});
    tax1Controller.removeListener(() {});
    tax2Controller.removeListener(() {});
  }
}