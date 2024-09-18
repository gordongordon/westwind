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

enum RateType implements _i1.SerializableModel {
  standard,
  ironhand,
  horizon,
  clear,
  global,
  darkstar,
  devita,
  massey_mechanical,
  force_inspection,
  bullet_well,
  PWS_Frontier,
  expedia,
  online,
  staff;

  static RateType fromJson(String name) {
    switch (name) {
      case 'standard':
        return standard;
      case 'ironhand':
        return ironhand;
      case 'horizon':
        return horizon;
      case 'clear':
        return clear;
      case 'global':
        return global;
      case 'darkstar':
        return darkstar;
      case 'devita':
        return devita;
      case 'massey_mechanical':
        return massey_mechanical;
      case 'force_inspection':
        return force_inspection;
      case 'bullet_well':
        return bullet_well;
      case 'PWS_Frontier':
        return PWS_Frontier;
      case 'expedia':
        return expedia;
      case 'online':
        return online;
      case 'staff':
        return staff;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "RateType"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
