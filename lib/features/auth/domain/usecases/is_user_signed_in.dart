import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/auth/domain/repository/auth_repository.dart';

class IsUserSignedIn implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  IsUserSignedIn(this.repository);
  @override
  Future<Either<Failure, bool>> call(Object params) {
    return repository.isUserSignedIn();
  }
}
