import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:drive_notes_app/features/auth/domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, GoogleSignInAccount?>> getPreviousUser() {
    return dataSource.getPreviousUser();
  }

  @override
  Future<Either<Failure, bool>> isUserSignedIn() {
    return dataSource.isUserSignedIn();
  }

  @override
  Future<Either<Failure, GoogleSignInAccount?>> signInUser() {
    return dataSource.signInUser();
  }

  @override
  Future<Either<Failure, void>> signOutUser() async {
    return dataSource.signOutUser();
  }
}
