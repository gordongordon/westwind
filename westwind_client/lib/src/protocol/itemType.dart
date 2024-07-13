/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum ItemType implements _i1.SerializableModel {
  room,
  food,
  laundry,
  vending,
  atm,
  pet,
  demage,
  deposite,
  other,
  visa,
  master,
  cash,
  eTransfer,
  gift_card;

  static ItemType fromJson(String name) {
    switch (name) {
      case 'room':
        return room;
      case 'food':
        return food;
      case 'laundry':
        return laundry;
      case 'vending':
        return vending;
      case 'atm':
        return atm;
      case 'pet':
        return pet;
      case 'demage':
        return demage;
      case 'deposite':
        return deposite;
      case 'other':
        return other;
      case 'visa':
        return visa;
      case 'master':
        return master;
      case 'cash':
        return cash;
      case 'eTransfer':
        return eTransfer;
      case 'gift_card':
        return gift_card;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "ItemType"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
