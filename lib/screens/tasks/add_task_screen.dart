import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/date_utils.dart';
import '../../data/mock_data.dart';
import '../../l10n/kk_strings.dart';
import '../../models/task_item.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_snackbar.dart';
import '../../widgets/app_text_field.dart';

/// UI showcase: nothing is saved.
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _deadlineController = TextEditingController();
  String? _subject;
  TaskPriority _priority = TaskPriority.medium;
  bool _reminder = true;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      helpText: KkStrings.selectDate,
      cancelText: KkStrings.cancel,
    );
    if (picked == null || !mounted) return;
    _deadlineController.text = KkDate.withYear(picked);
  }

  void _save() {
    showAppSnackBar(context, KkStrings.taskAdded);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text(KkStrings.addTask)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Gaps.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: KkStrings.taskTitle,
                controller: _titleController,
                textInputAction: TextInputAction.next,
                prefixIcon: Icons.title_rounded,
              ),
              const SizedBox(height: Gaps.l),
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
              AppTextField(
                label: KkStrings.description,
                controller: _descController,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: Gaps.l),
              AppTextField(
                label: KkStrings.deadline,
                controller: _deadlineController,
                readOnly: true,
                onTap: _pickDate,
                prefixIcon: Icons.event_outlined,
              ),
              const SizedBox(height: Gaps.l),
              const Text(
                KkStrings.priority,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: Gaps.s),
              SegmentedButton<TaskPriority>(
                showSelectedIcon: false,
                segments: [
                  for (final p in TaskPriority.values)
                    ButtonSegment(value: p, label: Text(p.label)),
                ],
                selected: {_priority},
                onSelectionChanged: (s) => setState(() => _priority = s.first),
              ),
              const SizedBox(height: Gaps.s),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(KkStrings.reminder),
                value: _reminder,
                activeThumbColor: AppColors.primary,
                onChanged: (v) => setState(() => _reminder = v),
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
