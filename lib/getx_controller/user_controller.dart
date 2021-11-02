import 'package:get/get.dart';
import 'package:momsori/models/test_user.dart';

class UserController extends GetxController {
  TestUser user = TestUser(
    id: 1,
    name: '엄마',
    nickName: '우리 아기',
    babyBirth: '2021.12.31',
  );

  updateUserName(String name, String nickName, String babyBirth) {
    user = user.copyWith(
      name: name,
      nickName: nickName,
      babyBirth: babyBirth,
    );
    update();
  }

  int babyDay() {
    String _data = user.babyBirth.replaceAll('.', '-');
    DateTime date = DateTime.parse(_data);

    return DateTime(
      date.year,
      date.month,
      date.day,
    )
        .difference(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ))
        .inDays;
  }

  int babyWeek() => (40 - babyDay() ~/ 7);

  int babyMonth() => (babyWeek() ~/ 4 + 1);

  String get userName => user.name;
  String get babyNickname => user.nickName;
  String get babyBirth => user.babyBirth;
}
