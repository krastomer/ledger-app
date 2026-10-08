import 'package:freezed_annotation/freezed_annotation.dart';

import 'gallery_look_back.dart';

part 'gallery_query.freezed.dart';

@freezed
abstract class GalleryQuery with _$GalleryQuery {
  const factory GalleryQuery({
    /// Empty means the whole library.
    @Default({}) Set<String> albumIds,
    @Default(GalleryLookBack.days90) GalleryLookBack lookBack,
  }) = _GalleryQuery;
}
