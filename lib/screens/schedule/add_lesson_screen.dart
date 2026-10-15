import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/app_text_field.dart';

/// UI showcase: nothing is saved.
class AddLessonScreen extends StatefulWidget {
  const AddLessonScreen({super.key});

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final _roomController = TextEditingController();
  final _teacherController = TextEditingController();
  String? _subject;
  int _day = 1;
  TimeOfDay _start = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 10, minute: 30);
  bool _repeat = true;

  @override
  void dispose() {
    _roomController.dispose();
    _teacherController.dispose();
    super.dispose();
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _start : _end,
      helpText: KkStrings.selectTime,
    );
    if (picked == null || !mounted) return;
    setState(() => isStart ? _start = picked : _end = picked);
  }

  void _save() {
    showAppSnackBar(context, KkStrings.lessonAdded);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text(KkStrings.addLesson)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Gaps.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                initialValue: _subject,
                decoration: const InputDecoration(labelText: KkStrings.subject),
                items: [
                  for (final s in MockData.subjects)
                    DropdownMenuItem(value: s.name, child: Text(s.name)),
                ],
                onChanged: (v) => setState(() => _subject = v),
              ),
              const SizedBox(height: Gaps.l),
              DropdownButtonFormField<int>(
                initialValue: _day,
                decoration: const InputDecoration(labelText: KkStrings.day),
                items: [
                  for (var i = 0; i < 7; i++)
                    DropdownMenuItem(
                      value: i + 1,
                      child: Text(KkDate.weekdays[i]),
                    ),
                ],
                onChanged: (v) => setState(() => _day = v ?? _day),
              ),
              const SizedBox(height: Gaps.l),
              Row(
                children: [
                  Expanded(
                    child: _TimeField(
                      label: KkStrings.startTime,
                      time: _start,
                      onTap: () => _pickTime(isStart: true),
                    ),
                  ),
                  const SizedBox(width: Gaps.m),
                  Expanded(
                    child: _TimeField(
                      label: KkStrings.endTime,
                      time: _end,
                      onTap: () => _pickTime(isStart: false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Gaps.l),
              AppTextField(
                label: KkStrings.room,
                controller: _roomController,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.meeting_room_outlined,
              ),
              const SizedBox(height: Gaps.l),
              AppTextField(
                label: KkStrings.teacher,
                controller: _teacherController,
                textInputAction: TextInputAction.done,
                prefixIcon: Icons.person_outline_rounded,
              ),
              const SizedBox(height: Gaps.s),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(KkStrings.repeatWeekly),
                value: _repeat,
                activeThumbColor: AppColors.primary,
                onChanged: (v) => setState(() => _repeat = v),
              ),
              const SizedBox(height: Gaps.l),
              AppButton(label: KkStrings.save, onPressed: _save),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.access_time_rounded),
        ),
        child: Text(KkDate.time(time.hour, time.minute)),
      ),
    );
  }
}
