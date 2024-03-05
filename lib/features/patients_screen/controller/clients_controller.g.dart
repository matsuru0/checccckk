// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$clientNotifierHash() => r'69e85c946fc77f480bea5cc8505098b600176b93';

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

abstract class _$ClientNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<ClientModel>> {
  late final String sort;

  FutureOr<List<ClientModel>> build({
    String sort = 'date',
  });
}

/// See also [ClientNotifier].
@ProviderFor(ClientNotifier)
const clientNotifierProvider = ClientNotifierFamily();

/// See also [ClientNotifier].
class ClientNotifierFamily extends Family<AsyncValue<List<ClientModel>>> {
  /// See also [ClientNotifier].
  const ClientNotifierFamily();

  /// See also [ClientNotifier].
  ClientNotifierProvider call({
    String sort = 'date',
  }) {
    return ClientNotifierProvider(
      sort: sort,
    );
  }

  @override
  ClientNotifierProvider getProviderOverride(
    covariant ClientNotifierProvider provider,
  ) {
    return call(
      sort: provider.sort,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'clientNotifierProvider';
}

/// See also [ClientNotifier].
class ClientNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ClientNotifier, List<ClientModel>> {
  /// See also [ClientNotifier].
  ClientNotifierProvider({
    String sort = 'date',
  }) : this._internal(
          () => ClientNotifier()..sort = sort,
          from: clientNotifierProvider,
          name: r'clientNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$clientNotifierHash,
          dependencies: ClientNotifierFamily._dependencies,
          allTransitiveDependencies:
              ClientNotifierFamily._allTransitiveDependencies,
          sort: sort,
        );

  ClientNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sort,
  }) : super.internal();

  final String sort;

  @override
  FutureOr<List<ClientModel>> runNotifierBuild(
    covariant ClientNotifier notifier,
  ) {
    return notifier.build(
      sort: sort,
    );
  }

  @override
  Override overrideWith(ClientNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClientNotifierProvider._internal(
        () => create()..sort = sort,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sort: sort,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ClientNotifier, List<ClientModel>>
      createElement() {
    return _ClientNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClientNotifierProvider && other.sort == sort;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sort.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ClientNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<ClientModel>> {
  /// The parameter `sort` of this provider.
  String get sort;
}

class _ClientNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ClientNotifier,
        List<ClientModel>> with ClientNotifierRef {
  _ClientNotifierProviderElement(super.provider);

  @override
  String get sort => (origin as ClientNotifierProvider).sort;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
