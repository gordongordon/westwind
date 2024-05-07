
import 'package:fpdart/fpdart.dart';
import 'package:westwind_flutter/core/error/failure.dart';
import 'package:westwind_flutter/core/usecases/usecase.dart';
import 'package:westwind_flutter/features/guest/domain/repositories/guest_repository.dart';

class DeleteGuestUseCase implements UseCase<bool,  DeleteGuestParams> {

   final GuestRepository guestRepository;

   const DeleteGuestUseCase( this.guestRepository ); 


  @override
  Future<Either<Failure, bool>> call( DeleteGuestParams params) async {
    return await guestRepository.delete(params.id);
  }
}

class DeleteGuestParams {
   final int id;
   const DeleteGuestParams( {required this.id} );
}