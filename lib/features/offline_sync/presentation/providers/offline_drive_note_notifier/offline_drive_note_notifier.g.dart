// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_drive_note_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$offlineDriveNoteNotifierHash() =>
    r'64e5097870fb3f04f1c3731a30321b79b30099b8';

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
  late final ContentFile file;

  FutureOr<String> build({required ContentFile file});
}

/// See also [OfflineDriveNoteNotifier].
@ProviderFor(OfflineDriveNoteNotifier)
const offlineDriveNoteNotifierProvider = OfflineDriveNoteNotifierFamily();

/// See also [OfflineDriveNoteNotifier].
class OfflineDriveNoteNotifierFamily extends Family<AsyncValue<String>> {
  /// See also [OfflineDriveNoteNotifier].
  const OfflineDriveNoteNotifierFamily();

  /// See also [OfflineDriveNoteNotifier].
  OfflineDriveNoteNotifierProvider call({required ContentFile file}) {
    return OfflineDriveNoteNotifierProvider(file: file);
  }

  @override
  OfflineDriveNoteNotifierProvider getProviderOverride(
    covariant OfflineDriveNoteNotifierProvider provider,
  ) {
    return call(file: provider.file);
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
  OfflineDriveNoteNotifierProvider({required ContentFile file})
    : this._internal(
        () => OfflineDriveNoteNotifier()..file = file,
        from: offlineDriveNoteNotifierProvider,
        name: r'offlineDriveNoteNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$offlineDriveNoteNotifierHash,
        dependencies: OfflineDriveNoteNotifierFamily._dependencies,
        allTransitiveDependencies:
            OfflineDriveNoteNotifierFamily._allTransitiveDependencies,
        file: file,
      );

  OfflineDriveNoteNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.file,
  }) : super.internal();

  final ContentFile file;

  @override
  FutureOr<String> runNotifierBuild(
    covariant OfflineDriveNoteNotifier notifier,
  ) {
    return notifier.build(file: file);
  }

  @override
  Override overrideWith(OfflineDriveNoteNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: OfflineDriveNoteNotifierProvider._internal(
        () => create()..file = file,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        file: file,
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
    return other is OfflineDriveNoteNotifierProvider && other.file == file;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, file.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OfflineDriveNoteNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `file` of this provider.
  ContentFile get file;
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
  ContentFile get file => (origin as OfflineDriveNoteNotifierProvider).file;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
