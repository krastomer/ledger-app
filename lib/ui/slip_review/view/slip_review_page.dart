import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import '../bloc/slip_review_bloc.dart';
import 'slip_review_view.dart';

class SlipReviewPage extends StatelessWidget {
  const SlipReviewPage({super.key, required this.imagePaths});

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SlipReviewBloc(
        imagePaths: imagePaths,
        importSlip: ImportSlipUseCase(
          slipRepository: context.read(),
          ledgerRepository: context.read(),
          keepSlipImages: context
              .read<SettingsCubit>()
              .state
              .settings
              .keepSlipImages,
        ),
      )..add(const SlipReviewStarted()),
      child: const SlipReviewView(),
    );
  }
}
