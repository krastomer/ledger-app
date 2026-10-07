import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/daily_spend.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/core/widgets/tui_shade.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:ledger_app/utils/money_format.dart';

const _columnGap = 4.0;
const _rowGap = 2.0;
const _shadeHeight = 14.0;
const _swatchSize = Size(8, 12);

/// A month calendar shaded by how much was spent each day.
class DailySpendPanel extends StatelessWidget {
  const DailySpendPanel({super.key, required this.dailySpend});

  final DailySpend dailySpend;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = context.localeName;
    final era = context.yearEra;
    final month = dailySpend.month;
    return TuiPanel(
      title: l10n.dailySpendTitle,
      trailing: formatMonthShortYear(month, locale, era),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Dimens.gapS,
        children: [
          Semantics(
            container: true,
            image: true,
            label: l10n.dailySpendCalendar(formatMonthYear(month, locale, era)),
            child: ExcludeSemantics(child: _Calendar(dailySpend: dailySpend)),
          ),
          const _Legend(),
          _Summary(dailySpend: dailySpend),
        ],
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar({required this.dailySpend});

  final DailySpend dailySpend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = dailySpend.days;
    final lead =
        DateTime(dailySpend.month.year, dailySpend.month.month).weekday -
        DateTime.monday;
    const week = DateTime.daysPerWeek;
    final weekCount = (lead + days.length + week - 1) ~/ week;
    return Column(
      spacing: _rowGap,
      children: [
        _Week(
          children: [
            for (final name in formatWeekdayInitials(context.localeName))
              Text(
                name.toLowerCase(),
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        for (var row = 0; row < weekCount; row++)
          _Week(
            children: [
              for (var column = 0; column < week; column++)
                switch (row * week + column - lead + 1) {
                  final day when day >= 1 && day <= days.length => _Day(
                    day: day,
                    level: DailySpend.levelOf(days[day - 1]),
                    isToday: day == dailySpend.today,
                    isFuture: dailySpend.isFuture(day),
                    isPeak: day == dailySpend.peakDay,
                  ),
                  _ => const SizedBox.shrink(),
                },
            ],
          ),
      ],
    );
  }
}

class _Week extends StatelessWidget {
  const _Week({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: _columnGap,
      children: [for (final child in children) Expanded(child: child)],
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({
    required this.day,
    required this.level,
    required this.isToday,
    required this.isFuture,
    required this.isPeak,
  });

  final int day;
  final int level;
  final bool isToday;
  final bool isFuture;
  final bool isPeak;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          day.toString().padLeft(2, '0'),
          style: theme.textTheme.labelSmall?.copyWith(
            color: isToday
                ? scheme.primary
                : isFuture
                ? scheme.outline
                : scheme.onSurfaceVariant,
          ),
        ),
        SizedBox(
          height: _shadeHeight,
          child: TuiShade(
            level: level,
            color: isPeak ? theme.moneyColors.expense : null,
          ),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final limits = DailySpend.levelLimits;
    final labels = [
      for (final limit in limits) '<${formatCompactMoney(limit)}',
      '${formatCompactMoney(limits.last)}+',
    ];
    return ExcludeSemantics(
      child: Wrap(
        spacing: Dimens.gapM,
        children: [
          for (final (index, label) in labels.indexed)
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                SizedBox.fromSize(
                  size: _swatchSize,
                  child: TuiShade(level: index + 1),
                ),
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.dailySpend});

  final DailySpend dailySpend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final month = dailySpend.month;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: l10n.dailyAverage(
              formatMoney(dailySpend.average, showSymbol: false),
            ),
          ),
          if (dailySpend case DailySpend(
            :final peakDay?,
            :final peakAmount?,
          )) ...[
            TextSpan(text: ' · ${l10n.dailyPeak} '),
            TextSpan(
              text: [
                formatMonthDay(DateTime(month.year, month.month, peakDay)),
                formatMoney(peakAmount, showSymbol: false),
                ?dailySpend.peakCategory,
              ].join(' '),
              style: TextStyle(color: theme.moneyColors.expense),
            ),
          ],
        ],
      ),
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
