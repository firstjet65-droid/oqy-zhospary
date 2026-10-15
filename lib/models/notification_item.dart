import 'package:flutter/material.dart';

class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.color,
  });

  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color color;
}
