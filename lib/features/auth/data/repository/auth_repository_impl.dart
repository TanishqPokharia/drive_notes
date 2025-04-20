import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:drive_notes_app/features/auth/domain/repository/auth_repository.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/local_files_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;
  final LocalFilesRepository localFilesRepository;

  AuthRepositoryImpl(this.dataSource, this.localFilesRepository);
  @override
  Future<Either<Failure, GoogleSignInAccount?>> getPreviousUser() {
    return dataSource.getPreviousUser();
  }

  @override
  Future<Either<Failure, bool>> isUserSignedIn() {
    return dataSource.isUserSignedIn();
  }

  @override
  Future<Either<Failure, GoogleSignInAccount?>> signInUser() async {
    final result = await dataSource.signInUser();
    return result.fold((failure) => Left(failure), (user) async {
      if (user != null) {
        final offlineStorageStatus = await localFilesRepository
            .initOfflineFileStorage(user.email);
        offlineStorageStatus.fold((failure) => Left(failure), (success) {
          print("Offline storage initialized");
        });
        final mark = await dataSource.markAsPreviousUser(user.email);
        mark.fold((failure) => Left(failure), (success) {
          print("User marked as previous");
        });
        return Right(user);
      } else {
        return Left(const Failure('Could not get user data'));
      }
    });
  }

  @override
  Future<Either<Failure, void>> signOutUser() async {
    return dataSource.signOutUser();
  }

  @override
  Future<Either<Failure, String>> getPreviousOfflineUserEmail() async {
    return dataSource.getPreviousOfflineUserEmail();
  }
}
