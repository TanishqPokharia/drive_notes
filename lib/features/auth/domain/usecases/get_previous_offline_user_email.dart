import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/core/utils/no_params.dart';
import 'package:drive_notes_app/core/utils/usecase.dart';
import 'package:drive_notes_app/features/auth/domain/repository/auth_repository.dart';

class GetPreviousOfflineUserEmail implements UseCase<String, NoParams> {
  final AuthRepository repository;

  GetPreviousOfflineUserEmail(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) {
    return repository.getPreviousOfflineUserEmail();
  }
}
