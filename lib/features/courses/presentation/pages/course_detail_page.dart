import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CourseDetailPage extends ConsumerWidget {
  final String courseId;

  const CourseDetailPage({
    required this.courseId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.code,
                size: 80,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Title',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Learn the fundamentals and build real-world projects',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      context.push('/lesson/lesson_1');
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Learning'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Course Content',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(8, (index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text('Lesson ${index + 1}'),
                      subtitle: const Text('10 min'),
                      trailing: const Icon(Icons.play_circle_outline),
                      onTap: () {
                        context.push('/lesson/lesson_${index + 1}');
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
