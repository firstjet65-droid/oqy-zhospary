import 'package:flutter/material.dart';

import '../core/utils/date_utils.dart';

class Lesson {
  const Lesson({
    required this.subject,
    required this.weekday,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.room,
    required this.teacher,
    required this.color,
  });

  final String subject;

  /// 1 = Monday ... 7 = Sunday (same as DateTime.weekday).
  final int weekday;
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final String room;
  final String teacher;
  final Color color;

  String get timeRange =>
      '${KkDate.time(startHour, startMinute)} - ${KkDate.time(endHour, endMinute)}';
}
