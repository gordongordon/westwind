/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

enum RoomNumber with _i1.SerializableEntity {
  Rm101,
  Rm102,
  Rm103,
  Rm104,
  Rm105,
  Rm106,
  Rm107,
  Rm108,
  Rm110,
  Rm111,
  Rm201,
  Rm202,
  Rm203,
  Rm330;

  static RoomNumber? fromJson(String name) {
    switch (name) {
      case 'Rm101':
        return Rm101;
      case 'Rm102':
        return Rm102;
      case 'Rm103':
        return Rm103;
      case 'Rm104':
        return Rm104;
      case 'Rm105':
        return Rm105;
      case 'Rm106':
        return Rm106;
      case 'Rm107':
        return Rm107;
      case 'Rm108':
        return Rm108;
      case 'Rm110':
        return Rm110;
      case 'Rm111':
        return Rm111;
      case 'Rm201':
        return Rm201;
      case 'Rm202':
        return Rm202;
      case 'Rm203':
        return Rm203;
      case 'Rm330':
        return Rm330;
      default:
        return null;
    }
  }

  @override
  String toJson() => name;
  @override
  String toString() => toJson();
}
