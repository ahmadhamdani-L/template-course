import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LessonPage extends ConsumerWidget {
  final String lessonId;

  const LessonPage({
    required this.lessonId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    const sampleContent = '''
# Lesson Title

This is a sample lesson demonstrating the dynamic content rendering engine.

## Key Concepts

- Concept 1: Understanding the basics
- Concept 2: Practical applications
- Concept 3: Best practices

## Code Example

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

## Summary

This lesson covered the fundamental concepts. Practice what you've learned!
''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () {
              // TODO: Toggle bookmark
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Markdown(
              data: sampleContent,
              styleSheet: MarkdownStyleSheet(
                h1: theme.textTheme.headlineMedium,
                h2: theme.textTheme.titleLarge,
                p: theme.textTheme.bodyLarge,
                code: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                ),
              ),
              padding: const EdgeInsets.all(16),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                top: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Previous lesson
                    },
                    child: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      // TODO: Mark complete & next lesson
                    },
                    child: const Text('Complete'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
