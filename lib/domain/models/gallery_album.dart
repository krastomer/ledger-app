import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_album.freezed.dart';

enum GalleryAlbumKind { recents, screenshots, other }

@freezed
abstract class GalleryAlbum with _$GalleryAlbum {
  const GalleryAlbum._();

  const factory GalleryAlbum({
    required String id,
    required String name,
    required int count,
    required GalleryAlbumKind kind,
  }) = _GalleryAlbum;

  static const _bankNames = [
    'k plus',
    'kplus',
    'scb',
    'krungthai',
    'krungsri',
    'bualuang',
    'ttb',
    'kma',
    'gsb',
    'kkp',
    'dime',
    'bangkok bank',
    'paotang',
    'mymo',
  ];

  bool get isSuggested =>
      kind == GalleryAlbumKind.other &&
      _bankNames.any(name.toLowerCase().contains);
}
