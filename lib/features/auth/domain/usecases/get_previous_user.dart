import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/auth/domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GetPreviousUser implements UseCase<GoogleSignInAccount?, NoParams> {
  final AuthRepository repository;

  GetPreviousUser(this.repository);

  @override
  Future<Either<Failure, GoogleSignInAccount?>> call(NoParams params) {
    return repository.getPreviousUser();
  }
}
