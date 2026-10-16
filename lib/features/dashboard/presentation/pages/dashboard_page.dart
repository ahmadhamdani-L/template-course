import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/bootstrap.dart';
import '../../../../core/localization/app_localizations.dart';

/// Dynamic dashboard page built from configuration
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    // Get dashboard configuration
    final dashboardConfig = config.navigation.dashboard;
    final enabledSections = dashboardConfig.sections
        .where((section) => section.enabled)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    
    return Scaffold(
      appBar: AppBar(
        title: Text(config.identity.displayName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (dashboardConfig.showWelcomeHeader)
            _buildWelcomeHeader(context, config, theme),
          const SizedBox(height: 24),
          
          // Dynamically build sections from configuration
          ...enabledSections.map((section) {
            return _buildSection(context, section, l10n, theme);
          }),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(
    BuildContext context,
    dynamic config,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back!',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Continue your learning journey',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    dynamic section,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getSectionTitle(section.titleKey, l10n),
                style: theme.textTheme.titleLarge,
              ),
              if (section.navigationRoute != null)
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to section route
                  },
                  child: const Text('View All'),
                ),
            ],
          ),
        ),
        _buildSectionContent(context, section, theme),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSectionContent(
    BuildContext context,
    dynamic section,
    ThemeData theme,
  ) {
    // Render different section types
    switch (section.type.toString().split('.').last) {
      case 'continueLearning':
        return _buildContinueLearningSection(theme);
      case 'recommendedCourses':
        return _buildRecommendedCoursesSection(theme);
      case 'learningStreak':
        return _buildLearningStreakSection(theme);
      default:
        return _buildPlaceholderSection(section.titleKey, theme);
    }
  }

  Widget _buildContinueLearningSection(ThemeData theme) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.play_arrow,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: const Text('Getting Started with Go'),
        subtitle: const Text('Lesson 3 of 10 • 45% complete'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: Navigate to lesson
        },
      ),
    );
  }

  Widget _buildRecommendedCoursesSection(ThemeData theme) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    color: theme.colorScheme.primaryContainer,
                    child: Center(
                      child: Icon(
                        Icons.code,
                        size: 40,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Course ${index + 1}',
                          style: theme.textTheme.titleSmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '12 lessons',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLearningStreakSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.local_fire_department,
                size: 32,
                color: theme.colorScheme.onTertiaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '7 Day Streak!',
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    'Keep it up! Learn today to continue',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderSection(String titleKey, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Section: $titleKey (Implementation pending)',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  String _getSectionTitle(String key, AppLocalizations l10n) {
    switch (key) {
      case 'continue_learning':
        return l10n.continueLearning;
      case 'recommended_courses':
        return l10n.recommendedCourses;
      default:
        return key;
    }
  }
}
