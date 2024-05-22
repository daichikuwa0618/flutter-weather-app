// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestDataImpl _$$RequestDataImplFromJson(Map<String, dynamic> json) =>
    _$RequestDataImpl(
      area: json['area'] as String,
      dateTime: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$RequestDataImplToJson(_$RequestDataImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.dateTime.toIso8601String(),
    };
