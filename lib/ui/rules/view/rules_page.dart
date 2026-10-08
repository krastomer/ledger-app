import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/rules_cubit.dart';
import 'rules_view.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RulesCubit(repository: context.read())..load(),
      child: const RulesView(),
    );
  }
}
