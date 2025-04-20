import 'package:drive_notes_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:drive_notes_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:drive_notes_app/features/auth/domain/repository/auth_repository.dart';
import 'package:drive_notes_app/features/auth/domain/usecases/get_previous_user.dart';
import 'package:drive_notes_app/features/auth/domain/usecases/is_user_signed_in.dart';
import 'package:drive_notes_app/features/auth/domain/usecases/sign_in_user.dart';
import 'package:drive_notes_app/features/auth/domain/usecases/sign_out_user.dart';
import 'package:drive_notes_app/features/home/data/datasource/home_datasource.dart';
import 'package:drive_notes_app/features/home/data/repository/home_repository_impl.dart';
import 'package:drive_notes_app/features/home/domain/repository/home_repository.dart';
import 'package:drive_notes_app/features/home/domain/usecases/create_drive_notes_folder.dart';
import 'package:drive_notes_app/features/home/domain/usecases/get_drive_notes_files.dart';
import 'package:drive_notes_app/features/notes/data/datasource/note_datasource.dart';
import 'package:drive_notes_app/features/notes/data/repository/note_repository_impl.dart';
import 'package:drive_notes_app/features/notes/domain/repository/note_repository.dart';
import 'package:drive_notes_app/features/home/domain/usecases/create_note.dart';
import 'package:drive_notes_app/features/home/domain/usecases/delete_note.dart';
import 'package:drive_notes_app/features/notes/domain/usecases/get_note_content.dart';
import 'package:drive_notes_app/features/notes/domain/usecases/update_note.dart';
import 'package:drive_notes_app/features/offline_sync/data/datasource/local_files_datasource.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/local_files_repository.dart';
import 'package:drive_notes_app/features/offline_sync/domain/repository/offline_sync_repository.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/check_offline_notes_exist.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/delete_note_from_local.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/get_local_notes.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/save_note_to_local.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/sync_drive_notes.dart';
import 'package:drive_notes_app/features/offline_sync/domain/usecases/update_note_in_local.dart';
import 'package:drive_notes_app/main.dart';
import 'package:drive_notes_app/features/offline_sync/data/repository/local_files_repository_impl.dart';
import 'package:drive_notes_app/features/offline_sync/data/repository/offline_sync_repository_impl.dart';

void registerDependencies() async {
  registerDatasources();
  registerRepositories();
  registerUsecases();
}

void registerDatasources() {
  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  getIt.registerLazySingleton<HomeDataSource>(() => HomeDataSourceImpl());
  getIt.registerLazySingleton<NoteDataSource>(() => NoteDataSourceImpl());
  getIt.registerLazySingleton<LocalFilesDataSource>(
    () => SharedPreferencesStorageFilesDataSourceImpl(),
  );
}

void registerRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<LocalFilesRepository>(
    () => LocalFilesRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<OfflineSyncRepository>(
    () => OfflineSyncRepositoryImpl(getIt(), getIt()),
  );
}

void registerUsecases() {
  // auth
  getIt.registerFactory(() => SignInUser(getIt()));
  getIt.registerFactory(() => IsUserSignedIn(getIt()));
  getIt.registerFactory(() => GetPreviousUser(getIt()));
  getIt.registerFactory(() => SignOutUser(getIt()));

  // home
  getIt.registerFactory(() => CreateDriveNotesFolder(getIt()));
  getIt.registerFactory(() => CreateNote(getIt()));
  getIt.registerFactory(() => DeleteNote(getIt()));
  getIt.registerLazySingleton(() => GetDriveNotesFiles(getIt()));

  // note
  getIt.registerFactory(() => UpdateNote(getIt()));
  getIt.registerFactory(() => GetNoteContent(getIt()));

  // offline sync
  getIt.registerFactory(() => SyncDriveNotes(getIt()));
  getIt.registerFactory(() => SaveNoteToLocal(getIt()));
  getIt.registerFactory(() => DeleteNoteFromLocal(getIt()));
  getIt.registerLazySingleton(() => GetLocalNotes(getIt()));
  getIt.registerFactory(() => UpdateNoteInLocal(getIt()));
  getIt.registerFactory(() => CheckOfflineNotesExist(getIt()));
}
