/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum BedType with _i1.SerializableEntity {
  D,
  Q,
  K,
  QQ,
  DD,
  DQ,
  QD;

  static BedType? fromJson(String name) {
    switch (name) {
      case 'D':
        return D;
      case 'Q':
        return Q;
      case 'K':
        return K;
      case 'QQ':
        return QQ;
      case 'DD':
        return DD;
      case 'DQ':
        return DQ;
      case 'QD':
        return QD;
      default:
        return null;
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => toJson();
}
