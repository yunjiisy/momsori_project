import 'package:get/get.dart';

class DiaryController extends GetxController {
  late Map<DateTime, List> events;
  late Map<DateTime, List> health;
  late Map<DateTime, List> diarytext;
  late Map<DateTime, List> feeling;
  late List<dynamic> _selectedEvents;
  late DateTime selectedDay;
}
