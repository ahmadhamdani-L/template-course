import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/courses/presentation/pages/courses_page.dart';
import '../../features/courses/presentation/pages/course_detail_page.dart';
import '../../features/lessons/presentation/pages/lesson_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../scaffold/app_scaffold.dart';

/// Application router provider
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: DashboardPage());
            },
          ),
          GoRoute(
            path: '/courses',
            name: 'courses',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: CoursesPage());
            },
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: ProfilePage());
            },
          ),
        ],
      ),
      GoRoute(
        path: '/course/:id',
        name: 'course_detail',
        builder: (context, state) {
          final courseId = state.pathParameters['id']!;
          return CourseDetailPage(courseId: courseId);
        },
      ),
      GoRoute(
        path: '/lesson/:id',
        name: 'lesson',
        builder: (context, state) {
          final lessonId = state.pathParameters['id']!;
          return LessonPage(lessonId: lessonId);
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) {
          return const SettingsPage();
        },
      ),
    ],
  );
});
