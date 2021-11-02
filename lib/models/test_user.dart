import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_user.freezed.dart';
part 'test_user.g.dart';


@freezed
class TestUser with _$TestUser{
  factory TestUser({
    required int id,
    required String name,
    required String nickName,
    required String babyBirth,
  }) = _TestUser;

  factory TestUser.fromJson(Map<String, dynamic> json) => _$TestUserFromJson(json);
}
