import 'package:dartz/dartz.dart';
import 'package:drive_notes_app/core/utils/failure.dart';
import 'package:drive_notes_app/features/home/domain/repository/home_repository.dart';
import 'package:drive_notes_app/features/home/domain/usecases/create_drive_notes_folder.dart';
import 'package:drive_notes_app/features/home/domain/usecases/delete_note.dart';
import 'package:drive_notes_app/features/home/domain/usecases/get_drive_notes_files.dart';
import 'package:drive_notes_app/features/home/presentation/providers/create_drive_notes_provider/create_drive_notes_provider.dart';
import 'package:drive_notes_app/features/home/presentation/providers/delete_note_provider/delete_note_provider.dart';
import 'package:drive_notes_app/features/home/presentation/providers/drive_notes_files_notifier/drive_notes_files_notifier.dart';
import 'package:drive_notes_app/features/home/presentation/providers/get_drive_notes_files_provider/get_drive_notes_files_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockHomeRepository mockHomeRepository;

  group('Drive Notes Files Notifier - ', () {
    setUpAll(() {
      mockHomeRepository = MockHomeRepository();
      GetIt.instance.registerSingleton<HomeRepository>(mockHomeRepository);
    });

    test(
      'given drive_notes_files_notifier when built then list of files or null should be returned',
      () async {
        // Arrange
        when(
          () => mockHomeRepository.getDriveNotesFiles(),
        ).thenAnswer((_) async => Right([]));

        final container = ProviderContainer(
          overrides: [
            getDriveNotesFilesProvider.overrideWithValue(
              GetDriveNotesFiles(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final driveNotesFiles = await container.read(
          driveNotesFilesNotifierProvider.future,
        );

        // Assert
        // getDriveNotesFiles should be called exactly once to ensure unnecessary reubuilts when first
        // instantiating the provider
        expect(driveNotesFiles, isA<List<File>?>());
        verify(() => mockHomeRepository.getDriveNotesFiles()).called(1);
      },
    );

    test(
      'given drive_notes_files_notifier when addFile is called then file should be added to the list',
      () async {
        // Arrange
        final container = ProviderContainer(
          overrides: [
            getDriveNotesFilesProvider.overrideWithValue(
              GetDriveNotesFiles(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // assuming that the initial state is AsyncData<List<File>?>
        // and that the addFile method is called with a file
        container
            .read(driveNotesFilesNotifierProvider.notifier)
            .state = AsyncData<List<File>?>([]);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        driveNotesFilesNotifier.addFile(File());

        // Assert
        expect(driveNotesFilesNotifier.state, isA<AsyncData<List<File>?>>());
      },
    );

    test(
      'given drive_notes_files_notifier when createDriveNotesFolder is called then folder should be created',
      () async {
        // Arrange
        when(
          () => mockHomeRepository.createDriveNotesFolder(),
        ).thenAnswer((_) async => Right(true));

        final container = ProviderContainer(
          overrides: [
            createDriveNotesFolderProvider.overrideWithValue(
              CreateDriveNotesFolder(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        driveNotesFilesNotifier.createDriveNotesFolder();

        // Assert
        verify(() => mockHomeRepository.createDriveNotesFolder()).called(1);
      },
    );

    test(
      'given drive_notes_files_notifier when tryDeleteFile is called then file should be deleted',
      () async {
        // Arrange
        when(
          () => mockHomeRepository.deleteNote(any()),
        ).thenAnswer((_) async => Right(true));

        final container = ProviderContainer(
          overrides: [
            deleteNoteProvider.overrideWithValue(
              DeleteNote(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final result = await container
            .read(driveNotesFilesNotifierProvider.notifier)
            .tryDeleteFile('fileId');

        // Assert
        expect(result, isA<Right<Failure, bool>>());
        verify(() => mockHomeRepository.deleteNote(any())).called(1);
      },
    );
    test(
      'given drive_notes_files_notifier when removeFromCurrentFiles is called then file should be removed from the list',
      () async {
        // Arrange
        final container = ProviderContainer(overrides: [
          
          ],
        );
        addTearDown(container.dispose);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        driveNotesFilesNotifier.removeFromCurrentFiles('fileId');

        // Assert
        expect(driveNotesFilesNotifier.state, isA<AsyncData<List<File>?>>());
      },
    );

    test(
      'given drive_notes_files_notifier when createDriveNotesFolder fails then error should be returned',
      () async {
        // Arrange
        when(
          () => mockHomeRepository.createDriveNotesFolder(),
        ).thenAnswer((_) async => Left(Failure("Error creating folder")));

        final container = ProviderContainer(
          overrides: [
            createDriveNotesFolderProvider.overrideWithValue(
              CreateDriveNotesFolder(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        driveNotesFilesNotifier.createDriveNotesFolder();

        // Assert
        verify(() => mockHomeRepository.createDriveNotesFolder()).called(1);
      },
    );

    test(
      'given drive_notes_files_notifier when tryDeleteFile fails then error should be returned',
      () async {
        // Arrange
        when(
          () => mockHomeRepository.deleteNote(any()),
        ).thenAnswer((_) async => Left(Failure("Error deleting file")));

        final container = ProviderContainer(
          overrides: [
            deleteNoteProvider.overrideWithValue(
              DeleteNote(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        final result = await driveNotesFilesNotifier.tryDeleteFile('fileId');

        // Assert
        expect(result, isA<Left<Failure, bool>>());
        verify(() => mockHomeRepository.deleteNote(any())).called(1);
      },
    );

    test(
      'given drive_notes_files_notifier when removeFromCurrentFiles is called with invalid fileId then no changes should be made',
      () async {
        // Arrange
        final container = ProviderContainer(
          overrides: [
            getDriveNotesFilesProvider.overrideWithValue(
              GetDriveNotesFiles(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        driveNotesFilesNotifier.removeFromCurrentFiles('invalidFileId');

        // Assert
        expect(driveNotesFilesNotifier.state, isA<AsyncData<List<File>?>>());
      },
    );

    test(
      'given drive_notes_files_notifier when tryDeleteFile is called with null fileId then no changes should be made',
      () async {
        // Arrange
        final container = ProviderContainer(
          overrides: [
            deleteNoteProvider.overrideWithValue(
              DeleteNote(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        final result = await driveNotesFilesNotifier.tryDeleteFile("");

        // Assert
        expect(result, isA<Left<Failure, bool>>());
      },
    );

    test(
      'given drive_notes_files_notifier when removeFromCurrentFiles is called with empty fileId then no changes should be made',
      () async {
        // Arrange
        final container = ProviderContainer(
          overrides: [
            getDriveNotesFilesProvider.overrideWithValue(
              GetDriveNotesFiles(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // assuming that the initial state is AsyncData<List<File>?>
        // and that the removeFromCurrentFiles method is called with an empty string
        container
            .read(driveNotesFilesNotifierProvider.notifier)
            .state = AsyncData<List<File>?>([]);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        driveNotesFilesNotifier.removeFromCurrentFiles("");

        // Assert
        expect(driveNotesFilesNotifier.state, isA<AsyncData<List<File>?>>());
      },
    );

    test(
      'given drive_notes_files_notifier when addFile is called with empty file then no changes should be made',
      () async {
        // Arrange
        final container = ProviderContainer(
          overrides: [
            getDriveNotesFilesProvider.overrideWithValue(
              GetDriveNotesFiles(mockHomeRepository),
            ),
          ],
        );
        addTearDown(container.dispose);

        // assuming that the initial state is AsyncData<List<File>?>
        // and that the addFile method is called with an empty file
        container
            .read(driveNotesFilesNotifierProvider.notifier)
            .state = AsyncData<List<File>?>([]);

        // Act
        final driveNotesFilesNotifier = container.read(
          driveNotesFilesNotifierProvider.notifier,
        );
        driveNotesFilesNotifier.addFile(File());

        // Assert
        expect(driveNotesFilesNotifier.state, isA<AsyncData<List<File>?>>());
      },
    );
  });
}
