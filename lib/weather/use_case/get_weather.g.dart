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

String _$getWeatherHash() => r'd213c84b8d556a43f26ff96163e469ac370ec236';

/// See also [getWeather].
@ProviderFor(getWeather)
final getWeatherProvider = AutoDisposeProvider<GetWeatherUseCase>.internal(
  getWeather,
  name: r'getWeatherProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getWeatherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetWeatherRef = AutoDisposeProviderRef<GetWeatherUseCase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
