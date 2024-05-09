

import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class SaveGuestUseCase implements UseCase<Guest,  SaveGuestParams> {

   final GuestRepository guestRepository;

   const SaveGuestUseCase( this.guestRepository ); 


  @override
  Future<Either<Failure, Guest>> call( SaveGuestParams params) async {
    return await guestRepository.save(params.guest);
  }
}

class SaveGuestParams {
   final Guest guest;
   const SaveGuestParams( {required this.guest} );
}