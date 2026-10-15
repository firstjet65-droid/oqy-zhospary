import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/about_screen.dart';
import '../../screens/profile/notifications_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/profile/settings_screen.dart';
import '../../screens/profile/subjects_screen.dart';
import '../../screens/schedule/add_lesson_screen.dart';
import '../../screens/schedule/schedule_screen.dart';
import '../../screens/shell/main_shell.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/stats/stats_screen.dart';
import '../../screens/tasks/add_task_screen.dart';
import '../../screens/tasks/task_detail_screen.dart';
import '../../screens/tasks/tasks_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const schedule = '/schedule';
  static const addLesson = '/schedule/add';
  static const tasks = '/tasks';
  static const addTask = '/task/add';
  static const stats = '/stats';
  static const profile = '/profile';
  static const settings = '/settings';
  static const notifications = '/notifications';
  static const subjects = '/subjects';
  static const about = '/about';

  static String taskDetail(String id) => '/task/$id';
}

GoRouter createAppRouter(AuthProvider auth) {
  const publicRoutes = {
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.forgotPassword,
  };

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: auth,
    redirect: (context, state) {
      final location = state.matchedLocation;

      // Stay on splash until the session has been restored.
      if (!auth.initialized) {
        return location == AppRoutes.splash ? null : AppRoutes.splash;
      }
      final loggedIn = auth.isLoggedIn;
      if (location == AppRoutes.splash) {
        return loggedIn ? AppRoutes.home : AppRoutes.login;
      }
      if (!loggedIn && !publicRoutes.contains(location)) {
        return AppRoutes.login;
      }
      if (loggedIn &&
          (location == AppRoutes.login || location == AppRoutes.register)) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.schedule,
                builder: (context, state) => const ScheduleScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.tasks,
                builder: (context, state) => const TasksScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.stats,
                builder: (context, state) => const StatsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.addLesson,
        builder: (context, state) => const AddLessonScreen(),
      ),
      // Must be declared before /task/:id.
      GoRoute(
        path: AppRoutes.addTask,
        builder: (context, state) => const AddTaskScreen(),
      ),
      GoRoute(
        path: '/task/:id',
        builder: (context, state) =>
            TaskDetailScreen(taskId: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.subjects,
        builder: (context, state) => const SubjectsScreen(),
      ),
      GoRoute(
        path: AppRoutes.about,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(child: Icon(Icons.error_outline_rounded, size: 48)),
    ),
  );
}
