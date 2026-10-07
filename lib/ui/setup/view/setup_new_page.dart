import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/setup_cubit.dart';
import 'setup_new_view.dart';

class SetupNewPage extends StatelessWidget {
  const SetupNewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupCubit(
        importRepository: context.read(),
        ledgerRepository: context.read(),
      ),
      child: const SetupNewView(),
    );
  }
}
