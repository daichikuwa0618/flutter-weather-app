// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Request {
  String get area => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  DateTime get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$RequestCopyWith<_Request> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$RequestCopyWith<$Res> {
  factory _$RequestCopyWith(_Request value, $Res Function(_Request) then) =
      __$RequestCopyWithImpl<$Res, _Request>;
  @useResult
  $Res call({String area, @JsonKey(name: 'date') DateTime dateTime});
}

/// @nodoc
class __$RequestCopyWithImpl<$Res, $Val extends _Request>
    implements _$RequestCopyWith<$Res> {
  __$RequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestDataImplCopyWith<$Res>
    implements _$RequestCopyWith<$Res> {
  factory _$$RequestDataImplCopyWith(
          _$RequestDataImpl value, $Res Function(_$RequestDataImpl) then) =
      __$$RequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String area, @JsonKey(name: 'date') DateTime dateTime});
}

/// @nodoc
class __$$RequestDataImplCopyWithImpl<$Res>
    extends __$RequestCopyWithImpl<$Res, _$RequestDataImpl>
    implements _$$RequestDataImplCopyWith<$Res> {
  __$$RequestDataImplCopyWithImpl(
      _$RequestDataImpl _value, $Res Function(_$RequestDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? area = null,
    Object? dateTime = null,
  }) {
    return _then(_$RequestDataImpl(
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$RequestDataImpl implements _RequestData {
  const _$RequestDataImpl(
      {required this.area, @JsonKey(name: 'date') required this.dateTime});

  @override
  final String area;
  @override
  @JsonKey(name: 'date')
  final DateTime dateTime;

  @override
  String toString() {
    return '_Request(area: $area, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestDataImpl &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, area, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestDataImplCopyWith<_$RequestDataImpl> get copyWith =>
      __$$RequestDataImplCopyWithImpl<_$RequestDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequestDataImplToJson(
      this,
    );
  }
}

abstract class _RequestData implements _Request {
  const factory _RequestData(
          {required final String area,
          @JsonKey(name: 'date') required final DateTime dateTime}) =
      _$RequestDataImpl;

  @override
  String get area;
  @override
  @JsonKey(name: 'date')
  DateTime get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$RequestDataImplCopyWith<_$RequestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
