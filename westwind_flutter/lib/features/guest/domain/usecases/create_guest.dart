
import 'package:fpdart/fpdart.dart';
import 'package:westwind_client/westwind_client.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class CreateGuestUseCase implements UseCase<Guest,  CreateGuestParams> {

   final GuestRepository guestRepository;

   const CreateGuestUseCase( this.guestRepository ); 


  @override
  Future<Either<Failure, Guest>> call( CreateGuestParams params) async {
    return await guestRepository.create(params.guest);
  }
}

class CreateGuestParams {
   final Guest guest;
   const CreateGuestParams( {required this.guest} );
}