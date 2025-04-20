import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  Future<Either<Failure, GoogleSignInAccount?>> signInUser();
  Future<Either<Failure, bool>> isUserSignedIn();
  Future<Either<Failure, GoogleSignInAccount?>> getPreviousUser();
  Future<Either<Failure, void>> signOutUser();
}
