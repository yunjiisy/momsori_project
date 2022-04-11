import 'package:get/get.dart';
import 'package:momsori/models/diary_data.dart';
import 'package:momsori/screens/diary_edit.dart';

// class DiaryController extends GetxController {
//   late Map<DateTime, List> events;
//   late Map<DateTime, List> health;
//   late Map<DateTime, List> diarytext;
//   late Map<DateTime, List> feeling;
//   late List<dynamic> _selectedEvents;
//   late DateTime selectedDay;
// }

class DiaryController extends GetxController {
  DiaryData diary = DiaryData(
    events: {},
    health: {},
    diarytext: {},
    feeling: {},
    selectedDay: DateTime.now(),
  );

  Map<DateTime, List> get events => diary.events;
  Map<DateTime, List> get health => diary.health;
  Map<DateTime, List> get diarytext => diary.diarytext;
  Map<DateTime, List> get feeling => diary.feeling;
  DateTime get selectedDay => diary.selectedDay;

  set health(Map health) {}
  set events(Map events) {}
  set diarytext(Map diarytext) {}
  set feeling(Map feeling) {}
  set selectedDay(DateTime selectedDay) {}
}
