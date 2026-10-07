import 'package:flutter/material.dart';

class ChoiceDialog<T> extends StatelessWidget {
  const ChoiceDialog({
    super.key,
    required this.title,
    required this.selected,
    required this.options,
  });

  final String title;
  final T selected;
  final List<(T, String)> options;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        RadioGroup<T>(
          groupValue: selected,
          onChanged: (value) => Navigator.of(context).pop(value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final (value, label) in options)
                RadioListTile<T>(value: value, title: Text(label)),
            ],
          ),
        ),
      ],
    );
  }
}
