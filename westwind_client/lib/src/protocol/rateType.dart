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
  acp,
  bullitt,
  clear,
  darkstar,
  devita,
  element,
  ensign,
  expedia,
  fmt,
  force_inspection,
  global,
  horizon,
  ironhand,
  kurgeon,
  k_rite,
  markhoe,
  massey_mechanical,
  maxx_north,
  online,
  other,
  paragon,
  performance,
  PWS_Frontier,
  savanah,
  spectre,
  staff,
  standard,
  strike,
  team_snb,
  wsk;

  static RateType fromJson(String name) {
    switch (name) {
      case 'acp':
        return acp;
      case 'bullitt':
        return bullitt;
      case 'clear':
        return clear;
      case 'darkstar':
        return darkstar;
      case 'devita':
        return devita;
      case 'element':
        return element;
      case 'ensign':
        return ensign;
      case 'expedia':
        return expedia;
      case 'fmt':
        return fmt;
      case 'force_inspection':
        return force_inspection;
      case 'global':
        return global;
      case 'horizon':
        return horizon;
      case 'ironhand':
        return ironhand;
      case 'kurgeon':
        return kurgeon;
      case 'k_rite':
        return k_rite;
      case 'markhoe':
        return markhoe;
      case 'massey_mechanical':
        return massey_mechanical;
      case 'maxx_north':
        return maxx_north;
      case 'online':
        return online;
      case 'other':
        return other;
      case 'paragon':
        return paragon;
      case 'performance':
        return performance;
      case 'PWS_Frontier':
        return PWS_Frontier;
      case 'savanah':
        return savanah;
      case 'spectre':
        return spectre;
      case 'staff':
        return staff;
      case 'standard':
        return standard;
      case 'strike':
        return strike;
      case 'team_snb':
        return team_snb;
      case 'wsk':
        return wsk;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "RateType"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
