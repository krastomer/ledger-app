import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(context.l10n.comingSoon)),
    );
  }
}
