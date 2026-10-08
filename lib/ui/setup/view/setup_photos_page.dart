import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import '../bloc/setup_photos_cubit.dart';
import 'setup_photos_view.dart';

class SetupPhotosPage extends StatelessWidget {
  const SetupPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SetupPhotosCubit(galleryRepository: context.read());
        if (context.read<SettingsCubit>().state.settings.syncGallery) {
          cubit.load();
        }
        return cubit;
      },
      child: const SetupPhotosView(),
    );
  }
}
