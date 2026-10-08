import 'package:ledger_app/data/services/gallery_service.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_album.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_query.dart';
import 'package:ledger_app/utils/result.dart';

import 'gallery_repository.dart';

class PhotoGalleryRepository implements GalleryRepository {
  PhotoGalleryRepository({required this._gallery});

  final GalleryService _gallery;

  @override
  Future<Result<GalleryAccess>> requestAccess() => _gallery.requestAccess();

  @override
  Future<Result<List<GalleryAlbum>>> listAlbums() => _gallery.listAlbums();

  @override
  Future<Result<void>> selectMore() => _gallery.selectMore();

  @override
  Future<Result<GalleryListing>> list(GalleryQuery query) =>
      _gallery.list(query);

  @override
  Future<Result<String>> imagePath(String id) => _gallery.imagePath(id);
}
