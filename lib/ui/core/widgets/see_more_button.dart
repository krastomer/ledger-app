import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

/// "See all ›" link at the end of a section header. No end padding, so
/// the chevron lines up with the content below.
class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        iconSize: 16,
        padding: const EdgeInsetsDirectional.only(start: Dimens.gapS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [Text(label), const Icon(Icons.chevron_right)],
      ),
    );
  }
}
