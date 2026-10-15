import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../models/lesson.dart';
import '../models/notification_item.dart';
import '../models/subject.dart';
import '../models/task_item.dart';

/// All fake data of the UI showcase lives here.
class MockData {
  MockData._();

  static const _math = Color(0xFF4F46E5);
  static const _physics = Color(0xFF14B8A6);
  static const _it = Color(0xFF0EA5E9);
  static const _literature = Color(0xFFEC4899);
  static const _english = Color(0xFFF59E0B);
  static const _history = Color(0xFF8B5CF6);

  static const subjects = [
    Subject(
      id: 's1',
      name: 'Математика',
      teacher: 'Серік Нұрланұлы',
      color: _math,
    ),
    Subject(
      id: 's2',
      name: 'Физика',
      teacher: 'Айгүл Мұратқызы',
      color: _physics,
    ),
    Subject(
      id: 's3',
      name: 'Информатика',
      teacher: 'Данияр Асқарұлы',
      color: _it,
    ),
    Subject(
      id: 's4',
      name: 'Қазақ әдебиеті',
      teacher: 'Гүлмира Серікқызы',
      color: _literature,
    ),
    Subject(
      id: 's5',
      name: 'Ағылшын тілі',
      teacher: 'Әсел Қайратқызы',
      color: _english,
    ),
    Subject(
      id: 's6',
      name: 'Тарих',
      teacher: 'Бауыржан Төлеуұлы',
      color: _history,
    ),
  ];

  static Lesson _lesson(
    int weekday,
    int subjectIndex,
    int sh,
    int sm,
    int eh,
    int em,
    String room,
  ) {
    final s = subjects[subjectIndex];
    return Lesson(
      subject: s.name,
      weekday: weekday,
      startHour: sh,
      startMinute: sm,
      endHour: eh,
      endMinute: em,
      room: room,
      teacher: s.teacher,
      color: s.color,
    );
  }

  static final List<Lesson> lessons = [
    _lesson(1, 0, 9, 0, 10, 30, '204'),
    _lesson(1, 2, 10, 45, 12, 15, '311'),
    _lesson(1, 4, 13, 0, 14, 30, '107'),
    _lesson(2, 1, 9, 0, 10, 30, '215'),
    _lesson(2, 3, 10, 45, 12, 15, '102'),
    _lesson(2, 5, 13, 0, 14, 30, '409'),
    _lesson(3, 2, 9, 0, 10, 30, '311'),
    _lesson(3, 0, 10, 45, 12, 15, '204'),
    _lesson(3, 4, 13, 0, 14, 30, '107'),
    _lesson(4, 5, 9, 0, 10, 30, '409'),
    _lesson(4, 1, 10, 45, 12, 15, '215'),
    _lesson(4, 3, 13, 0, 14, 30, '102'),
    _lesson(5, 0, 9, 0, 10, 30, '204'),
    _lesson(5, 4, 10, 45, 12, 15, '107'),
    _lesson(5, 2, 13, 0, 14, 30, '311'),
    _lesson(6, 1, 9, 0, 10, 30, '215'),
    _lesson(6, 5, 10, 45, 12, 15, '409'),
    _lesson(6, 3, 13, 0, 14, 30, '102'),
  ];

  static List<Lesson> lessonsForDay(int weekday) =>
      lessons.where((l) => l.weekday == weekday).toList();

  /// Deadlines are relative to now, so the data always looks current.
  static List<TaskItem> get tasks {
    final now = DateTime.now();
    DateTime inDays(int d, [int hour = 23]) =>
        DateTime(now.year, now.month, now.day + d, hour, 59);

    return [
      TaskItem(
        id: '1',
        title: 'Интегралдар бойынша есептер',
        subject: 'Математика',
        description:
            'Оқулықтағы 5.2 тарау: 12-25 есептерді шығарып, дәптерге жазу.',
        deadline: inDays(1),
        priority: TaskPriority.high,
        status: TaskStatus.active,
        progress: 0.4,
      ),
      TaskItem(
        id: '2',
        title: 'Зертханалық жұмыс №3 есебі',
        subject: 'Физика',
        description: 'Тербелмелі қозғалыс бойынша өлшеу нәтижелерін рәсімдеу.',
        deadline: inDays(2),
        priority: TaskPriority.medium,
        status: TaskStatus.active,
        progress: 0.7,
      ),
      TaskItem(
        id: '3',
        title: 'Flutter жобасының презентациясы',
        subject: 'Информатика',
        description: '10 слайдтан тұратын жоба презентациясын дайындау.',
        deadline: inDays(4),
        priority: TaskPriority.high,
        status: TaskStatus.active,
        progress: 0.2,
      ),
      TaskItem(
        id: '4',
        title: 'Абай жолы: эссе',
        subject: 'Қазақ әдебиеті',
        description: '«Абай жолы» романынан таңдаған бөлім бойынша эссе жазу.',
        deadline: inDays(6),
        priority: TaskPriority.low,
        status: TaskStatus.active,
        progress: 0.1,
      ),
      TaskItem(
        id: '5',
        title: 'Жаңа сөздер тізімі',
        subject: 'Ағылшын тілі',
        description: '3-бөлім бойынша 40 жаңа сөзді жаттау.',
        deadline: inDays(-2),
        priority: TaskPriority.medium,
        status: TaskStatus.overdue,
        progress: 0.5,
      ),
      TaskItem(
        id: '6',
        title: 'Тарихи тұлғалар кестесі',
        subject: 'Тарих',
        description:
            'XV-XVIII ғасырлардағы қазақ хандары туралы кесте құрастыру.',
        deadline: inDays(-5),
        priority: TaskPriority.low,
        status: TaskStatus.done,
        progress: 1,
      ),
      TaskItem(
        id: '7',
        title: 'Тест: Квадрат теңдеулер',
        subject: 'Математика',
        description: 'Онлайн тестті өту, нәтижесін оқытушыға жіберу.',
        deadline: inDays(-1),
        priority: TaskPriority.medium,
        status: TaskStatus.done,
        progress: 1,
      ),
    ];
  }

  static TaskItem? taskById(String id) {
    for (final t in tasks) {
      if (t.id == id) return t;
    }
    return null;
  }

  static const notifications = [
    NotificationItem(
      title: 'Мерзім жақындап келеді',
      body: '«Интегралдар бойынша есептер» тапсырмасының мерзімі ертең аяқталады.',
      time: '10 минут бұрын',
      icon: Icons.alarm_rounded,
      color: AppColors.danger,
    ),
    NotificationItem(
      title: 'Сабақ басталады',
      body: 'Информатика сабағы 311 аудиториясында 30 минутта басталады.',
      time: '1 сағат бұрын',
      icon: Icons.school_rounded,
      color: AppColors.primary,
    ),
    NotificationItem(
      title: 'Тапсырма орындалды',
      body: '«Тарихи тұлғалар кестесі» тапсырмасы сәтті аяқталды.',
      time: 'Кеше',
      icon: Icons.check_circle_rounded,
      color: AppColors.success,
    ),
    NotificationItem(
      title: 'Кесте өзгерді',
      body: 'Бейсенбі күнгі Физика сабағының аудиториясы өзгертілді.',
      time: 'Кеше',
      icon: Icons.edit_calendar_rounded,
      color: AppColors.warning,
    ),
    NotificationItem(
      title: 'Апталық есеп дайын',
      body: 'Өткен аптада 12 тапсырма орындалды. Жарайсыз!',
      time: '2 күн бұрын',
      icon: Icons.insights_rounded,
      color: AppColors.accent,
    ),
  ];

  /// Completed task counts for Mon..Sun.
  static const weeklyActivity = [3, 5, 2, 6, 4, 1, 2];

  static const statCompleted = 18;
  static const statLate = 3;
  static const statPlanned = 7;
  static const overallProgress = 0.65;
  static const mostActiveSubject = 'Математика';
}
