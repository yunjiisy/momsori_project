import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_data.freezed.dart';
part 'diary_data.g.dart';

@freezed
class DiaryData with _$DiaryData {
  factory DiaryData({
    required DateTime selectedDay,
    required Map<DateTime, List> events,
    required Map<DateTime, List> health,
    required Map<DateTime, List> diarytext,
    required Map<DateTime, List> feeling,
    //required List<dynamic> _selectedEvents,
  }) = _DiaryData;

  factory DiaryData.fromJson(Map<String, dynamic> json) =>
      _$DiaryDataFromJson(json);
}
