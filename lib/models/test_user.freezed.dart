// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'test_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TestUser _$TestUserFromJson(Map<String, dynamic> json) {
  return _TestUser.fromJson(json);
}

/// @nodoc
class _$TestUserTearOff {
  const _$TestUserTearOff();

  _TestUser call(
      {required int id,
      required String name,
      required String nickName,
      required String babyBirth}) {
    return _TestUser(
      id: id,
      name: name,
      nickName: nickName,
      babyBirth: babyBirth,
    );
  }

  TestUser fromJson(Map<String, Object?> json) {
    return TestUser.fromJson(json);
  }
}

/// @nodoc
const $TestUser = _$TestUserTearOff();

/// @nodoc
mixin _$TestUser {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nickName => throw _privateConstructorUsedError;
  String get babyBirth => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestUserCopyWith<TestUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestUserCopyWith<$Res> {
  factory $TestUserCopyWith(TestUser value, $Res Function(TestUser) then) =
      _$TestUserCopyWithImpl<$Res>;
  $Res call({int id, String name, String nickName, String babyBirth});
}

/// @nodoc
class _$TestUserCopyWithImpl<$Res> implements $TestUserCopyWith<$Res> {
  _$TestUserCopyWithImpl(this._value, this._then);

  final TestUser _value;
  // ignore: unused_field
  final $Res Function(TestUser) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nickName = freezed,
    Object? babyBirth = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      babyBirth: babyBirth == freezed
          ? _value.babyBirth
          : babyBirth // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$TestUserCopyWith<$Res> implements $TestUserCopyWith<$Res> {
  factory _$TestUserCopyWith(_TestUser value, $Res Function(_TestUser) then) =
      __$TestUserCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, String nickName, String babyBirth});
}

/// @nodoc
class __$TestUserCopyWithImpl<$Res> extends _$TestUserCopyWithImpl<$Res>
    implements _$TestUserCopyWith<$Res> {
  __$TestUserCopyWithImpl(_TestUser _value, $Res Function(_TestUser) _then)
      : super(_value, (v) => _then(v as _TestUser));

  @override
  _TestUser get _value => super._value as _TestUser;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nickName = freezed,
    Object? babyBirth = freezed,
  }) {
    return _then(_TestUser(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nickName: nickName == freezed
          ? _value.nickName
          : nickName // ignore: cast_nullable_to_non_nullable
              as String,
      babyBirth: babyBirth == freezed
          ? _value.babyBirth
          : babyBirth // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TestUser implements _TestUser {
  _$_TestUser(
      {required this.id,
      required this.name,
      required this.nickName,
      required this.babyBirth});

  factory _$_TestUser.fromJson(Map<String, dynamic> json) =>
      _$$_TestUserFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String nickName;
  @override
  final String babyBirth;

  @override
  String toString() {
    return 'TestUser(id: $id, name: $name, nickName: $nickName, babyBirth: $babyBirth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TestUser &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.nickName, nickName) &&
            const DeepCollectionEquality().equals(other.babyBirth, babyBirth));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(nickName),
      const DeepCollectionEquality().hash(babyBirth));

  @JsonKey(ignore: true)
  @override
  _$TestUserCopyWith<_TestUser> get copyWith =>
      __$TestUserCopyWithImpl<_TestUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TestUserToJson(this);
  }
}

abstract class _TestUser implements TestUser {
  factory _TestUser(
      {required int id,
      required String name,
      required String nickName,
      required String babyBirth}) = _$_TestUser;

  factory _TestUser.fromJson(Map<String, dynamic> json) = _$_TestUser.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get nickName;
  @override
  String get babyBirth;
  @override
  @JsonKey(ignore: true)
  _$TestUserCopyWith<_TestUser> get copyWith =>
      throw _privateConstructorUsedError;
}
