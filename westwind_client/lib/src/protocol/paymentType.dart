/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum PaymentType with _i1.SerializableEntity {
  visa,
  master,
  debit,
  cash,
  bill,
  other;

  static PaymentType? fromJson(String name) {
    switch (name) {
      case 'visa':
        return visa;
      case 'master':
        return master;
      case 'debit':
        return debit;
      case 'cash':
        return cash;
      case 'bill':
        return bill;
      case 'other':
        return other;
      default:
        return null;
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => toJson();
}
