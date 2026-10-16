import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_localizations.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.courses),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.book,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text('Course ${index + 1}'),
              subtitle: Text('${10 + index} lessons • Beginner'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                context.push('/course/course_${index + 1}');
              },
            ),
          );
        },
      ),
    );
  }
}
