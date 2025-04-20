// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_drive_note_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$offlineDriveNoteNotifierHash() =>
    r'e0b5ec7d4f5e8a55cc727b9a04391c5551aac4d0';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$OfflineDriveNoteNotifier
    extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final String email;
  late final String fileId;

  FutureOr<String> build({required String email, required String fileId});
}

/// See also [OfflineDriveNoteNotifier].
@ProviderFor(OfflineDriveNoteNotifier)
const offlineDriveNoteNotifierProvider = OfflineDriveNoteNotifierFamily();

/// See also [OfflineDriveNoteNotifier].
class OfflineDriveNoteNotifierFamily extends Family<AsyncValue<String>> {
  /// See also [OfflineDriveNoteNotifier].
  const OfflineDriveNoteNotifierFamily();

  /// See also [OfflineDriveNoteNotifier].
  OfflineDriveNoteNotifierProvider call({
    required String email,
    required String fileId,
  }) {
    return OfflineDriveNoteNotifierProvider(email: email, fileId: fileId);
  }

  @override
  OfflineDriveNoteNotifierProvider getProviderOverride(
    covariant OfflineDriveNoteNotifierProvider provider,
  ) {
    return call(email: provider.email, fileId: provider.fileId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'offlineDriveNoteNotifierProvider';
}

/// See also [OfflineDriveNoteNotifier].
class OfflineDriveNoteNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<OfflineDriveNoteNotifier, String> {
  /// See also [OfflineDriveNoteNotifier].
  OfflineDriveNoteNotifierProvider({
    required String email,
    required String fileId,
  }) : this._internal(
         () =>
             OfflineDriveNoteNotifier()
               ..email = email
               ..fileId = fileId,
         from: offlineDriveNoteNotifierProvider,
         name: r'offlineDriveNoteNotifierProvider',
         debugGetCreateSourceHash:
             const bool.fromEnvironment('dart.vm.product')
                 ? null
                 : _$offlineDriveNoteNotifierHash,
         dependencies: OfflineDriveNoteNotifierFamily._dependencies,
         allTransitiveDependencies:
             OfflineDriveNoteNotifierFamily._allTransitiveDependencies,
         email: email,
         fileId: fileId,
       );

  OfflineDriveNoteNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
    required this.fileId,
  }) : super.internal();

  final String email;
  final String fileId;

  @override
  FutureOr<String> runNotifierBuild(
    covariant OfflineDriveNoteNotifier notifier,
  ) {
    return notifier.build(email: email, fileId: fileId);
  }

  @override
  Override overrideWith(OfflineDriveNoteNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: OfflineDriveNoteNotifierProvider._internal(
        () =>
            create()
              ..email = email
              ..fileId = fileId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
        fileId: fileId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OfflineDriveNoteNotifier, String>
  createElement() {
    return _OfflineDriveNoteNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OfflineDriveNoteNotifierProvider &&
        other.email == email &&
        other.fileId == fileId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, fileId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OfflineDriveNoteNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `email` of this provider.
  String get email;

  /// The parameter `fileId` of this provider.
  String get fileId;
}

class _OfflineDriveNoteNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OfflineDriveNoteNotifier,
          String
        >
    with OfflineDriveNoteNotifierRef {
  _OfflineDriveNoteNotifierProviderElement(super.provider);

  @override
  String get email => (origin as OfflineDriveNoteNotifierProvider).email;
  @override
  String get fileId => (origin as OfflineDriveNoteNotifierProvider).fileId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
