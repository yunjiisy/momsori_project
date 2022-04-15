// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'diary_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DiaryData _$DiaryDataFromJson(Map<String, dynamic> json) {
  return _DiaryData.fromJson(json);
}

/// @nodoc
class _$DiaryDataTearOff {
  const _$DiaryDataTearOff();

  _DiaryData call(
      {required Map<DateTime, List> events,
      required Map<DateTime, List> health,
      required Map<DateTime, List> diarytext,
      required Map<DateTime, List> feeling,
      required DateTime selectedDay}) {
    return _DiaryData(
      events: events,
      health: health,
      diarytext: diarytext,
      feeling: feeling,
      selectedDay: selectedDay,
    );
  }

  DiaryData fromJson(Map<String, Object?> json) {
    return DiaryData.fromJson(json);
  }
}

/// @nodoc
const $DiaryData = _$DiaryDataTearOff();

/// @nodoc
mixin _$DiaryData {
  Map<DateTime, List> get events => throw _privateConstructorUsedError;
  Map<DateTime, List> get health => throw _privateConstructorUsedError;
  Map<DateTime, List> get diarytext => throw _privateConstructorUsedError;
  Map<DateTime, List> get feeling =>
      throw _privateConstructorUsedError; //required List<dynamic> _selectedEvents,
  DateTime get selectedDay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryDataCopyWith<DiaryData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryDataCopyWith<$Res> {
  factory $DiaryDataCopyWith(DiaryData value, $Res Function(DiaryData) then) =
      _$DiaryDataCopyWithImpl<$Res>;
  $Res call(
      {Map<DateTime, List> events,
      Map<DateTime, List> health,
      Map<DateTime, List> diarytext,
      Map<DateTime, List> feeling,
      DateTime selectedDay});
}

/// @nodoc
class _$DiaryDataCopyWithImpl<$Res> implements $DiaryDataCopyWith<$Res> {
  _$DiaryDataCopyWithImpl(this._value, this._then);

  final DiaryData _value;
  // ignore: unused_field
  final $Res Function(DiaryData) _then;

  @override
  $Res call({
    Object? events = freezed,
    Object? health = freezed,
    Object? diarytext = freezed,
    Object? feeling = freezed,
    Object? selectedDay = freezed,
  }) {
    return _then(_value.copyWith(
      events: events == freezed
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      health: health == freezed
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      diarytext: diarytext == freezed
          ? _value.diarytext
          : diarytext // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      feeling: feeling == freezed
          ? _value.feeling
          : feeling // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      selectedDay: selectedDay == freezed
          ? _value.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$DiaryDataCopyWith<$Res> implements $DiaryDataCopyWith<$Res> {
  factory _$DiaryDataCopyWith(
          _DiaryData value, $Res Function(_DiaryData) then) =
      __$DiaryDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<DateTime, List> events,
      Map<DateTime, List> health,
      Map<DateTime, List> diarytext,
      Map<DateTime, List> feeling,
      DateTime selectedDay});
}

/// @nodoc
class __$DiaryDataCopyWithImpl<$Res> extends _$DiaryDataCopyWithImpl<$Res>
    implements _$DiaryDataCopyWith<$Res> {
  __$DiaryDataCopyWithImpl(_DiaryData _value, $Res Function(_DiaryData) _then)
      : super(_value, (v) => _then(v as _DiaryData));

  @override
  _DiaryData get _value => super._value as _DiaryData;

  @override
  $Res call({
    Object? events = freezed,
    Object? health = freezed,
    Object? diarytext = freezed,
    Object? feeling = freezed,
    Object? selectedDay = freezed,
  }) {
    return _then(_DiaryData(
      events: events == freezed
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      health: health == freezed
          ? _value.health
          : health // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      diarytext: diarytext == freezed
          ? _value.diarytext
          : diarytext // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      feeling: feeling == freezed
          ? _value.feeling
          : feeling // ignore: cast_nullable_to_non_nullable
              as Map<DateTime, List>,
      selectedDay: selectedDay == freezed
          ? _value.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DiaryData implements _DiaryData {
  _$_DiaryData(
      {required this.events,
      required this.health,
      required this.diarytext,
      required this.feeling,
      required this.selectedDay});

  factory _$_DiaryData.fromJson(Map<String, dynamic> json) =>
      _$$_DiaryDataFromJson(json);

  @override
  final Map<DateTime, List> events;
  @override
  final Map<DateTime, List> health;
  @override
  final Map<DateTime, List> diarytext;
  @override
  final Map<DateTime, List> feeling;
  @override //required List<dynamic> _selectedEvents,
  final DateTime selectedDay;

  @override
  String toString() {
    return 'DiaryData(events: $events, health: $health, diarytext: $diarytext, feeling: $feeling, selectedDay: $selectedDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DiaryData &&
            const DeepCollectionEquality().equals(other.events, events) &&
            const DeepCollectionEquality().equals(other.health, health) &&
            const DeepCollectionEquality().equals(other.diarytext, diarytext) &&
            const DeepCollectionEquality().equals(other.feeling, feeling) &&
            const DeepCollectionEquality()
                .equals(other.selectedDay, selectedDay));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(events),
      const DeepCollectionEquality().hash(health),
      const DeepCollectionEquality().hash(diarytext),
      const DeepCollectionEquality().hash(feeling),
      const DeepCollectionEquality().hash(selectedDay));

  @JsonKey(ignore: true)
  @override
  _$DiaryDataCopyWith<_DiaryData> get copyWith =>
      __$DiaryDataCopyWithImpl<_DiaryData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DiaryDataToJson(this);
  }
}

abstract class _DiaryData implements DiaryData {
  factory _DiaryData(
      {required Map<DateTime, List> events,
      required Map<DateTime, List> health,
      required Map<DateTime, List> diarytext,
      required Map<DateTime, List> feeling,
      required DateTime selectedDay}) = _$_DiaryData;

  factory _DiaryData.fromJson(Map<String, dynamic> json) =
      _$_DiaryData.fromJson;

  @override
  Map<DateTime, List> get events;
  @override
  Map<DateTime, List> get health;
  @override
  Map<DateTime, List> get diarytext;
  @override
  Map<DateTime, List> get feeling;
  @override //required List<dynamic> _selectedEvents,
  DateTime get selectedDay;
  @override
  @JsonKey(ignore: true)
  _$DiaryDataCopyWith<_DiaryData> get copyWith =>
      throw _privateConstructorUsedError;
}
