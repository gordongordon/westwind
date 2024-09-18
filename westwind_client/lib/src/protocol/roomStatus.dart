/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum RoomStatus implements _i1.SerializableModel {
  vacancy,
  empty,
  checkout,
  clean,
  dirty,
  make,
  makemake,
  change,
  ddd;

  static RoomStatus fromJson(String name) {
    switch (name) {
      case 'vacancy':
        return vacancy;
      case 'empty':
        return empty;
      case 'checkout':
        return checkout;
      case 'clean':
        return clean;
      case 'dirty':
        return dirty;
      case 'make':
        return make;
      case 'makemake':
        return makemake;
      case 'change':
        return change;
      case 'ddd':
        return ddd;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "RoomStatus"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
