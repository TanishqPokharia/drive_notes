import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthDataSource {
  Future<Either<Failure, GoogleSignInAccount?>> signInUser();
  Future<Either<Failure, bool>> isUserSignedIn();
  Future<Either<Failure, GoogleSignInAccount?>> getPreviousUser();
  Future<Either<Failure, void>> signOutUser();
  Future<Either<Failure, bool>> hasPreviousOfflineUser();
  Future<Either<Failure, void>> markAsPreviousUser(String email);
  Future<Either<Failure, String>> getPreviousOfflineUserEmail();
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<Either<Failure, void>> markAsPreviousUser(String email) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString("previous_user", email);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> hasPreviousOfflineUser() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final previousUser = sp.getString("previous_user");
      if (previousUser == null) {
        return const Right(false);
      }
      return const Right(true);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserSignedIn() async {
    try {
      final isSignedIn = await googleSignIn.isSignedIn();
      return Right(isSignedIn);
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

  @override
  Future<Either<Failure, String>> getPreviousOfflineUserEmail() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final previousUser = sp.getString("previous_user");
      if (previousUser == null) {
        return const Left(Failure('No previous user found'));
      }
      return Right(previousUser);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
