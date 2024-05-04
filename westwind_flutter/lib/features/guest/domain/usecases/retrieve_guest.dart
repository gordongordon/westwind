

import 'package:flutter/rendering.dart';
import 'package:fpdart/src/either.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class RetrieveGuestUseCase implements UseCase<Guest,  RetrieveGuestParams> {

   final GuestRepository guestRepository;

   const RetrieveGuestUseCase( this.guestRepository ); 


  @override
  Future<Either<Failure, Guest>> call( RetrieveGuestParams params) async {
    return await guestRepository.retrieve(params.id );
  }
}

class RetrieveGuestParams {
   final int id;
   const RetrieveGuestParams( {required this.id} );
}