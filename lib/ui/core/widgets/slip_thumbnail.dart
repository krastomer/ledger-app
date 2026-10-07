import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/widgets/slip_image_viewer.dart';

/// A small slip image; tap to see it full screen.
class SlipThumbnail extends StatelessWidget {
  const SlipThumbnail({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      image: true,
      label: context.l10n.viewSlipImage,
      child: GestureDetector(
        onTap: () => showSlipImage(context, imagePath),
        child: Container(
          width: 78,
          height: 118,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
