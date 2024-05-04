/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

enum RoomChargeType with _i1.SerializableEntity {
  room,
  laundry,
  pet,
  food,
  drink,
  other;

  static RoomChargeType? fromJson(String name) {
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
        return null;
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => toJson();
}
