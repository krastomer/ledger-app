import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_sync_scope.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class GalleryRepository {
  /// Asks for access to the photo library, or reports the answer already
  /// given.
  Future<Result<GalleryAccess>> requestAccess();

  /// The images in [scope], newest first.
  Future<Result<GalleryListing>> list(GallerySyncScope scope);

  /// A local file path for the photo with [id].
  Future<Result<String>> imagePath(String id);
}
