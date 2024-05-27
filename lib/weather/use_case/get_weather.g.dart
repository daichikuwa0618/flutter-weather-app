// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$$RequestDataImplToJson(_$RequestDataImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.dateTime.toIso8601String(),
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getWeatherHash() => r'df1e32eeac724b1f878cdd72e6d1d6b370d84d61';

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

/// See also [getWeather].
@ProviderFor(getWeather)
const getWeatherProvider = GetWeatherFamily();

/// See also [getWeather].
class GetWeatherFamily extends Family<Weather> {
  /// See also [getWeather].
  const GetWeatherFamily();

  /// See also [getWeather].
  GetWeatherProvider call({
    required String area,
  }) {
    return GetWeatherProvider(
      area: area,
    );
  }

  @override
  GetWeatherProvider getProviderOverride(
    covariant GetWeatherProvider provider,
  ) {
    return call(
      area: provider.area,
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
  String? get name => r'getWeatherProvider';
}

/// See also [getWeather].
class GetWeatherProvider extends AutoDisposeProvider<Weather> {
  /// See also [getWeather].
  GetWeatherProvider({
    required String area,
  }) : this._internal(
          (ref) => getWeather(
            ref as GetWeatherRef,
            area: area,
          ),
          from: getWeatherProvider,
          name: r'getWeatherProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getWeatherHash,
          dependencies: GetWeatherFamily._dependencies,
          allTransitiveDependencies:
              GetWeatherFamily._allTransitiveDependencies,
          area: area,
        );

  GetWeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.area,
  }) : super.internal();

  final String area;

  @override
  Override overrideWith(
    Weather Function(GetWeatherRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetWeatherProvider._internal(
        (ref) => create(ref as GetWeatherRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        area: area,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Weather> createElement() {
    return _GetWeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetWeatherProvider && other.area == area;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, area.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetWeatherRef on AutoDisposeProviderRef<Weather> {
  /// The parameter `area` of this provider.
  String get area;
}

class _GetWeatherProviderElement extends AutoDisposeProviderElement<Weather>
    with GetWeatherRef {
  _GetWeatherProviderElement(super.provider);

  @override
  String get area => (origin as GetWeatherProvider).area;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
