// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DiaryData _$$_DiaryDataFromJson(Map<String, dynamic> json) => _$_DiaryData(
      events: (json['events'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), e as List<dynamic>),
      ),
      health: (json['health'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), e as List<dynamic>),
      ),
      diarytext: (json['diarytext'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), e as List<dynamic>),
      ),
      feeling: (json['feeling'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), e as List<dynamic>),
      ),
      selectedDay: DateTime.parse(json['selectedDay'] as String),
    );

Map<String, dynamic> _$$_DiaryDataToJson(_$_DiaryData instance) =>
    <String, dynamic>{
      'events': instance.events.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'health': instance.health.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'diarytext':
          instance.diarytext.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'feeling':
          instance.feeling.map((k, e) => MapEntry(k.toIso8601String(), e)),
      'selectedDay': instance.selectedDay.toIso8601String(),
    };
