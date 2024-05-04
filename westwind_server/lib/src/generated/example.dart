/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Examplekk extends _i1.SerializableEntity {
  Examplekk._({
    required this.name,
    required this.data,
  });

  factory Examplekk({
    required String name,
    required int data,
  }) = _ExamplekkImpl;

  factory Examplekk.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Examplekk(
      name: serializationManager.deserialize<String>(jsonSerialization['name']),
      data: serializationManager.deserialize<int>(jsonSerialization['data']),
    );
  }

  String name;

  int data;

  Examplekk copyWith({
    String? name,
    int? data,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'data': data,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      'name': name,
      'data': data,
    };
  }
}

class _ExamplekkImpl extends Examplekk {
  _ExamplekkImpl({
    required String name,
    required int data,
  }) : super._(
          name: name,
          data: data,
        );

  @override
  Examplekk copyWith({
    String? name,
    int? data,
  }) {
    return Examplekk(
      name: name ?? this.name,
      data: data ?? this.data,
    );
  }
}
