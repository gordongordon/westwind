  import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';

RoomGuest foldResult(Either<Failure, RoomGuest> input) {
    return input.fold(
      (failure) => throw failure, // Throw the error if it exists
      (r) => r, // Return the result if there is no error
    );
  }