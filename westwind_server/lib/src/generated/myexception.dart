/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'errorType.dart' as _i2;

abstract class MyException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  MyException._({
    required this.message,
    required this.errorType,
  });

  factory MyException({
    required String message,
    required _i2.ErrorType errorType,
  }) = _MyExceptionImpl;

  factory MyException.fromJson(Map<String, dynamic> jsonSerialization) {
    return MyException(
      message: jsonSerialization['message'] as String,
      errorType:
          _i2.ErrorType.fromJson((jsonSerialization['errorType'] as String)),
    );
  }

  String message;

  _i2.ErrorType errorType;

  MyException copyWith({
    String? message,
    _i2.ErrorType? errorType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'errorType': errorType.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'message': message,
      'errorType': errorType.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _MyExceptionImpl extends MyException {
  _MyExceptionImpl({
    required String message,
    required _i2.ErrorType errorType,
  }) : super._(
          message: message,
          errorType: errorType,
        );

  @override
  MyException copyWith({
    String? message,
    _i2.ErrorType? errorType,
  }) {
    return MyException(
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
