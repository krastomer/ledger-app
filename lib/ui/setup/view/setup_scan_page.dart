import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import '../bloc/setup_scan_cubit.dart';
import 'setup_scan_view.dart';

class SetupScanPage extends StatelessWidget {
  const SetupScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>().state.settings;
    return BlocProvider(
      create: (context) => SetupScanCubit(
        galleryRepository: context.read(),
        importSlip: ImportSlipUseCase(
          slipRepository: context.read(),
          ledgerRepository: context.read(),
          keepSlipImages: settings.keepSlipImages,
        ),
        scope: settings.gallerySyncScope,
      )..scan(),
      child: const SetupScanView(),
    );
  }
}
