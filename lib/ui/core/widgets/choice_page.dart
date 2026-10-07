import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';

/// Opens a full-screen picker and returns the chosen value, or null if the
/// user goes back.
Future<T?> pickChoice<T>(
  BuildContext context, {
  required String title,
  required T selected,
  required List<(T, String)> options,
  bool searchable = false,
}) {
  return Navigator.of(context).push<T>(
    MaterialPageRoute(
      builder: (context) => ChoicePage<T>(
        title: title,
        selected: selected,
        options: options,
        searchable: searchable,
      ),
    ),
  );
}

/// With [searchable], a filter field is shown and labels like `a:b` are
/// grouped under a `# a` heading.
class ChoicePage<T> extends StatefulWidget {
  const ChoicePage({
    super.key,
    required this.title,
    required this.selected,
    required this.options,
    this.searchable = false,
  });

  final String title;
  final T selected;
  final List<(T, String)> options;
  final bool searchable;

  @override
  State<ChoicePage<T>> createState() => _ChoicePageState<T>();
}

class _ChoicePageState<T> extends State<ChoicePage<T>> {
  String _query = '';

  List<(T, String)> get _visible {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return widget.options;
    return [
      for (final option in widget.options)
        if (option.$2.toLowerCase().contains(query)) option,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;
    final selected = widget.selected;
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                Dimens.pagePadding,
                Dimens.gapS,
                Dimens.pagePadding,
                0,
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: TuiButton(
                  keyHint: 'q',
                  label: context.l10n.back,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  padding: 0,
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.pagePadding,
                  Dimens.gapL,
                  Dimens.pagePadding,
                  Dimens.pagePadding,
                ),
                children: [
                  if (widget.searchable) ...[
                    _FilterField(
                      count: '${visible.length}/${widget.options.length}',
                      onChanged: (value) => setState(() => _query = value),
                    ),
                    const SizedBox(height: Dimens.panelGap),
                  ],
                  TuiPanel(
                    title: widget.title,
                    accent: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.panelPadding,
                      vertical: Dimens.gapS,
                    ),
                    child: RadioGroup<T>(
                      groupValue: selected,
                      onChanged: (value) => Navigator.of(context).pop(value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (visible.isEmpty)
                            Text(
                              '# ${context.l10n.noMatches}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          for (final (index, (value, label))
                              in visible.indexed) ...[
                            if (widget.searchable &&
                                _group(label) != null &&
                                (index == 0 ||
                                    _group(visible[index - 1].$2) !=
                                        _group(label)))
                              _GroupHeading(_group(label)!),
                            _ChoiceRow(
                              label: widget.searchable && _group(label) != null
                                  ? label.substring(label.indexOf(':') + 1)
                                  : label,
                              prefix: widget.searchable && _group(label) != null
                                  ? '${_group(label)}:'
                                  : null,
                              isSelected: value == selected,
                              onTap: () => Navigator.of(context).pop(value),
                            ),
                          ],
                        ],
                      ),
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

  static String? _group(String label) {
    final colon = label.indexOf(':');
    return colon > 0 ? label.substring(0, colon) : null;
  }
}

class _FilterField extends StatelessWidget {
  const _FilterField({required this.count, required this.onChanged});

  final String count;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      height: Dimens.tapTarget,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.panelPadding),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        spacing: Dimens.gapS,
        children: [
          ExcludeSemantics(
            child: Text('/', style: TextStyle(color: scheme.primary)),
          ),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration.collapsed(
                hintText: context.l10n.filterHint,
                hintStyle: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
          ),
          Text(count, style: TextStyle(color: scheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _GroupHeading extends StatelessWidget {
  const _GroupHeading(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.gapXS),
      child: Text(
        '# $name',
        style: theme.textTheme.bodySmall?.copyWith(
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.prefix,
  });

  final String label;
  final String? prefix;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      selected: isSelected,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
          child: Row(
            spacing: Dimens.gapS,
            children: [
              ExcludeSemantics(
                child: Text(
                  isSelected ? '>' : ' ',
                  style: TextStyle(color: scheme.primary),
                ),
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      if (prefix != null)
                        TextSpan(
                          text: prefix,
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      TextSpan(text: label),
                    ],
                  ),
                  style: TextStyle(
                    color: isSelected ? scheme.primary : scheme.onSurface,
                  ),
                ),
              ),
              ExcludeSemantics(
                child: Text(
                  isSelected ? '[x]' : '[ ]',
                  style: TextStyle(
                    color: isSelected
                        ? scheme.primary
                        : scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
