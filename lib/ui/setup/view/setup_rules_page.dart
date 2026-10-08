import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/rules/bloc/rules_cubit.dart';

import 'setup_rules_view.dart';

class SetupRulesPage extends StatelessWidget {
  const SetupRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RulesCubit(repository: context.read()),
      child: const SetupRulesView(),
    );
  }
}
