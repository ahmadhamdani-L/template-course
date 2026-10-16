import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/localization/app_localizations.dart';
import '../bootstrap.dart';

/// Main application scaffold with bottom navigation
class AppScaffold extends ConsumerWidget {
  final Widget child;

  const AppScaffold({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final l10n = AppLocalizations.of(context)!;
    
    // Get enabled destinations from configuration
    final destinations = config.navigation.destinations
        .where((dest) => dest.enabled)
        .toList();
    
    // Determine current index
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _getCurrentIndex(location, destinations);
    
    return Scaffold(
      body: child,
      bottomNavigationBar: destinations.length > 1
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                final destination = destinations[index];
                context.go(destination.route);
              },
              destinations: destinations.map((dest) {
                return NavigationDestination(
                  icon: _getIcon(dest.icon),
                  selectedIcon: _getIcon(dest.icon, selected: true),
                  label: _getLabel(l10n, dest.labelKey),
                );
              }).toList(),
            )
          : null,
    );
  }

  int _getCurrentIndex(String location, List<dynamic> destinations) {
    for (var i = 0; i < destinations.length; i++) {
      if (location == destinations[i].route || 
          (location == '/' && destinations[i].route == '/')) {
        return i;
      }
    }
    return 0;
  }

  Widget _getIcon(String iconName, {bool selected = false}) {
    // Map icon names to Material icons
    IconData iconData;
    
    switch (iconName) {
      case 'home':
        iconData = selected ? Icons.home : Icons.home_outlined;
        break;
      case 'courses':
      case 'library':
        iconData = selected ? Icons.library_books : Icons.library_books_outlined;
        break;
      case 'learning':
      case 'school':
        iconData = selected ? Icons.school : Icons.school_outlined;
        break;
      case 'profile':
      case 'person':
        iconData = selected ? Icons.person : Icons.person_outlined;
        break;
      case 'bookmark':
        iconData = selected ? Icons.bookmark : Icons.bookmark_outlined;
        break;
      case 'search':
        iconData = selected ? Icons.search : Icons.search_outlined;
        break;
      default:
        iconData = selected ? Icons.circle : Icons.circle_outlined;
    }
    
    return Icon(iconData);
  }

  String _getLabel(AppLocalizations l10n, String labelKey) {
    // Map label keys to localized strings
    switch (labelKey) {
      case 'home':
        return l10n.home;
      case 'courses':
        return l10n.courses;
      case 'my_learning':
        return l10n.myLearning;
      case 'profile':
        return l10n.profile;
      default:
        return labelKey;
    }
  }
}
