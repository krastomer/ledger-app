import 'package:ledger_app/data/services/gallery_service.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_sync_scope.dart';
import 'package:ledger_app/utils/result.dart';

import 'gallery_repository.dart';

class PhotoGalleryRepository implements GalleryRepository {
  PhotoGalleryRepository({required this._gallery});

  final GalleryService _gallery;

  @override
  Future<Result<GalleryAccess>> requestAccess() => _gallery.requestAccess();

  @override
  Future<Result<GalleryListing>> list(GallerySyncScope scope) =>
      _gallery.list(scope);

  @override
  Future<Result<String>> imagePath(String id) => _gallery.imagePath(id);
}
