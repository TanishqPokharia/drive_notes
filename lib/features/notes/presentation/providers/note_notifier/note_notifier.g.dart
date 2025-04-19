// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$noteNotifierHash() => r'7b025d08415beeea08be7557e4f28fecff559f86';

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

abstract class _$NoteNotifier extends BuildlessAsyncNotifier<String> {
  late final String noteId;

  FutureOr<String> build({required String noteId});
}

/// See also [NoteNotifier].
@ProviderFor(NoteNotifier)
const noteNotifierProvider = NoteNotifierFamily();

/// See also [NoteNotifier].
class NoteNotifierFamily extends Family<AsyncValue<String>> {
  /// See also [NoteNotifier].
  const NoteNotifierFamily();

  /// See also [NoteNotifier].
  NoteNotifierProvider call({required String noteId}) {
    return NoteNotifierProvider(noteId: noteId);
  }

  @override
  NoteNotifierProvider getProviderOverride(
    covariant NoteNotifierProvider provider,
  ) {
    return call(noteId: provider.noteId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'noteNotifierProvider';
}

/// See also [NoteNotifier].
class NoteNotifierProvider
    extends AsyncNotifierProviderImpl<NoteNotifier, String> {
  /// See also [NoteNotifier].
  NoteNotifierProvider({required String noteId})
    : this._internal(
        () => NoteNotifier()..noteId = noteId,
        from: noteNotifierProvider,
        name: r'noteNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$noteNotifierHash,
        dependencies: NoteNotifierFamily._dependencies,
        allTransitiveDependencies:
            NoteNotifierFamily._allTransitiveDependencies,
        noteId: noteId,
      );

  NoteNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.noteId,
  }) : super.internal();

  final String noteId;

  @override
  FutureOr<String> runNotifierBuild(covariant NoteNotifier notifier) {
    return notifier.build(noteId: noteId);
  }

  @override
  Override overrideWith(NoteNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: NoteNotifierProvider._internal(
        () => create()..noteId = noteId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        noteId: noteId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<NoteNotifier, String> createElement() {
    return _NoteNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NoteNotifierProvider && other.noteId == noteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, noteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NoteNotifierRef on AsyncNotifierProviderRef<String> {
  /// The parameter `noteId` of this provider.
  String get noteId;
}

class _NoteNotifierProviderElement
    extends AsyncNotifierProviderElement<NoteNotifier, String>
    with NoteNotifierRef {
  _NoteNotifierProviderElement(super.provider);

  @override
  String get noteId => (origin as NoteNotifierProvider).noteId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
