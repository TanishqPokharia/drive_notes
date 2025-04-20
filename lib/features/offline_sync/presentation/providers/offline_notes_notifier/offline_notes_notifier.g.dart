// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_notes_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$offlineNotesNotifierHash() =>
    r'15fc59cda38877c23c0a57d0b084eeea11857ec9';

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

abstract class _$OfflineNotesNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<File>?> {
  late final String email;

  FutureOr<List<File>?> build({required String email});
}

/// See also [OfflineNotesNotifier].
@ProviderFor(OfflineNotesNotifier)
const offlineNotesNotifierProvider = OfflineNotesNotifierFamily();

/// See also [OfflineNotesNotifier].
class OfflineNotesNotifierFamily extends Family<AsyncValue<List<File>?>> {
  /// See also [OfflineNotesNotifier].
  const OfflineNotesNotifierFamily();

  /// See also [OfflineNotesNotifier].
  OfflineNotesNotifierProvider call({required String email}) {
    return OfflineNotesNotifierProvider(email: email);
  }

  @override
  OfflineNotesNotifierProvider getProviderOverride(
    covariant OfflineNotesNotifierProvider provider,
  ) {
    return call(email: provider.email);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'offlineNotesNotifierProvider';
}

/// See also [OfflineNotesNotifier].
class OfflineNotesNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          OfflineNotesNotifier,
          List<File>?
        > {
  /// See also [OfflineNotesNotifier].
  OfflineNotesNotifierProvider({required String email})
    : this._internal(
        () => OfflineNotesNotifier()..email = email,
        from: offlineNotesNotifierProvider,
        name: r'offlineNotesNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$offlineNotesNotifierHash,
        dependencies: OfflineNotesNotifierFamily._dependencies,
        allTransitiveDependencies:
            OfflineNotesNotifierFamily._allTransitiveDependencies,
        email: email,
      );

  OfflineNotesNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
  }) : super.internal();

  final String email;

  @override
  FutureOr<List<File>?> runNotifierBuild(
    covariant OfflineNotesNotifier notifier,
  ) {
    return notifier.build(email: email);
  }

  @override
  Override overrideWith(OfflineNotesNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: OfflineNotesNotifierProvider._internal(
        () => create()..email = email,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OfflineNotesNotifier, List<File>?>
  createElement() {
    return _OfflineNotesNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OfflineNotesNotifierProvider && other.email == email;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OfflineNotesNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<File>?> {
  /// The parameter `email` of this provider.
  String get email;
}

class _OfflineNotesNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OfflineNotesNotifier,
          List<File>?
        >
    with OfflineNotesNotifierRef {
  _OfflineNotesNotifierProviderElement(super.provider);

  @override
  String get email => (origin as OfflineNotesNotifierProvider).email;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
