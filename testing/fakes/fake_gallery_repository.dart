import 'package:ledger_app/data/repositories/gallery/gallery_repository.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_sync_scope.dart';
import 'package:ledger_app/utils/result.dart';

class FakeGalleryRepository implements GalleryRepository {
  FakeGalleryRepository({
    this.photos = const {},
    this.libraryCount = 0,
    this.access = const Result.ok(GalleryAccess.granted),
    this.listError,
  });

  /// Photo id to image path; photos missing a path can't be opened.
  final Map<String, String> photos;
  final int libraryCount;
  final Result<GalleryAccess> access;
  final Exception? listError;

  GallerySyncScope? listedScope;

  @override
  Future<Result<GalleryAccess>> requestAccess() async => access;

  @override
  Future<Result<GalleryListing>> list(GallerySyncScope scope) async {
    listedScope = scope;
    final error = listError;
    if (error != null) return Result.error(error);
    return Result.ok(
      GalleryListing(
        libraryCount: libraryCount,
        photoIds: photos.keys.toList(),
      ),
    );
  }

  @override
  Future<Result<String>> imagePath(String id) async => switch (photos[id]) {
    final path? => Result.ok(path),
    null => Result.error(Exception('no photo $id')),
  };
}
