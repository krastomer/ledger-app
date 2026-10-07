import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/setup_cubit.dart';
import 'setup_import_view.dart';

class SetupImportPage extends StatelessWidget {
  const SetupImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupCubit(
        importRepository: context.read(),
        ledgerRepository: context.read(),
      ),
      child: const SetupImportView(),
    );
  }
}
