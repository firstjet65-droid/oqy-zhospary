import 'package:flutter/material.dart';

class Subject {
  const Subject({
    required this.id,
    required this.name,
    required this.teacher,
    required this.color,
  });

  final String id;
  final String name;
  final String teacher;
  final Color color;
}
