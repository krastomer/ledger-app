part of 'setup_photos_cubit.dart';

enum SetupPhotosStatus { idle, loading, ready, noAccess, failed }

@freezed
abstract class SetupPhotosState with _$SetupPhotosState {
  const factory SetupPhotosState({
    @Default(SetupPhotosStatus.idle) SetupPhotosStatus status,
    @Default([]) List<GalleryAlbum> albums,
    @Default(false) bool limited,
  }) = _SetupPhotosState;
}
