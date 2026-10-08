import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/data/repositories/gallery/gallery_repository.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_album.dart';
import 'package:ledger_app/utils/result.dart';

part 'setup_photos_cubit.freezed.dart';
part 'setup_photos_state.dart';

class SetupPhotosCubit extends Cubit<SetupPhotosState> {
  SetupPhotosCubit({required this._galleryRepository})
    : super(const SetupPhotosState());

  final GalleryRepository _galleryRepository;

  Future<void> load() async {
    emit(state.copyWith(status: SetupPhotosStatus.loading));
    final access = await _galleryRepository.requestAccess();
    if (isClosed) return;
    switch (access) {
      case Ok(value: GalleryAccess.denied):
        return emit(state.copyWith(status: SetupPhotosStatus.noAccess));
      case Error():
        return emit(state.copyWith(status: SetupPhotosStatus.failed));
      case Ok(:final value):
        final albums = await _galleryRepository.listAlbums();
        if (isClosed) return;
        emit(switch (albums) {
          Ok(value: final list) => state.copyWith(
            status: SetupPhotosStatus.ready,
            albums: list,
            limited: value == GalleryAccess.limited,
          ),
          Error() => state.copyWith(status: SetupPhotosStatus.failed),
        });
    }
  }

  Future<void> selectMore() async {
    await _galleryRepository.selectMore();
    if (isClosed) return;
    await load();
  }
}
