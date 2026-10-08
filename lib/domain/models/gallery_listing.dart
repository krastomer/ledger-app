import 'package:freezed_annotation/freezed_annotation.dart';

part 'gallery_listing.freezed.dart';

@freezed
abstract class GalleryListing with _$GalleryListing {
  const factory GalleryListing({
    /// Every image on the device, whatever the scope.
    required int libraryCount,

    /// Images in the scope to check, newest first.
    required List<String> photoIds,
  }) = _GalleryListing;
}
