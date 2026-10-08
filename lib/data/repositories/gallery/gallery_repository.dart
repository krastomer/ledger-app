import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_album.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_query.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class GalleryRepository {
  /// Asks for access to the photo library, or reports the answer already
  /// given.
  Future<Result<GalleryAccess>> requestAccess();

  /// The albums that hold photos: Recents first, then the largest.
  Future<Result<List<GalleryAlbum>>> listAlbums();

  /// Lets the user share more photos when access is limited.
  Future<Result<void>> selectMore();

  /// The images [query] asks for, newest first.
  Future<Result<GalleryListing>> list(GalleryQuery query);

  /// A local file path for the photo with [id].
  Future<Result<String>> imagePath(String id);
}
