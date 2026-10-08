import 'package:flutter/material.dart';

enum SetupLogLevel { ok, working, fail }

class SetupLogLine extends StatelessWidget {
  const SetupLogLine({super.key, required this.level, required this.text});

  final SetupLogLevel level;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final muted = TextStyle(color: scheme.onSurfaceVariant);
    final (label, color) = switch (level) {
      SetupLogLevel.ok => ('  OK  ', scheme.tertiary),
      SetupLogLevel.working => (' ...  ', scheme.primary),
      SetupLogLevel.fail => (' FAIL ', scheme.error),
    };
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '[', style: muted),
          TextSpan(
            text: label,
            style: TextStyle(color: color),
          ),
          TextSpan(text: '] ', style: muted),
          TextSpan(text: text),
        ],
      ),
    );
  }
}
