import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<Either<Failure, GoogleSignInAccount?>> signInUser();
  Future<Either<Failure, bool>> isUserSignedIn();
  Future<Either<Failure, GoogleSignInAccount?>> getPreviousUser();
  Future<Either<Failure, void>> signOutUser();
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<Either<Failure, bool>> isUserSignedIn() async {
    try {
      final status = await googleSignIn.isSignedIn();
      return Right(status);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GoogleSignInAccount?>> getPreviousUser() async {
    try {
      final previousUser = await googleSignIn.signInSilently();
      return Right(previousUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GoogleSignInAccount?>> signInUser() async {
    try {
      final account = await googleSignIn.signIn();
      return Right(account);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOutUser() async {
    try {
      await googleSignIn.signOut();
      return Right(());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
