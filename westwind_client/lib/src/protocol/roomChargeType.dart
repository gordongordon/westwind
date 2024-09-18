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

enum RoomChargeType implements _i1.SerializableModel {
  room,
  laundry,
  pet,
  food,
  drink,
  other;

  static RoomChargeType fromJson(String name) {
    switch (name) {
      case 'room':
        return room;
      case 'laundry':
        return laundry;
      case 'pet':
        return pet;
      case 'food':
        return food;
      case 'drink':
        return drink;
      case 'other':
        return other;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "RoomChargeType"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
