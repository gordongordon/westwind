/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

enum RateReason implements _i1.SerializableModel {
  single,
  share,
  triple,
  stuff,
  double,
  gohome,
  other;

  static RateReason fromJson(String name) {
    switch (name) {
      case 'single':
        return single;
      case 'share':
        return share;
      case 'triple':
        return triple;
      case 'stuff':
        return stuff;
      case 'double':
        return double;
      case 'gohome':
        return gohome;
      case 'other':
        return other;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "RateReason"');
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => name;
}
