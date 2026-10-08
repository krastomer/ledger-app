import 'package:ledger_app/data/repositories/gallery/gallery_repository.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_album.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_query.dart';
import 'package:ledger_app/utils/result.dart';

class FakeGalleryRepository implements GalleryRepository {
  FakeGalleryRepository({
    this.photos = const {},
    this.libraryCount = 0,
    this.albums = const [],
    this.access = const Result.ok(GalleryAccess.granted),
    this.listError,
    this.albumsError,
  });

  /// Photo id to image path; photos missing a path can't be opened.
  final Map<String, String> photos;
  final int libraryCount;
  final List<GalleryAlbum> albums;
  final Result<GalleryAccess> access;
  final Exception? listError;
  final Exception? albumsError;

  GalleryQuery? listedQuery;
  int selectMoreCalls = 0;

  @override
  Future<Result<GalleryAccess>> requestAccess() async => access;

  @override
  Future<Result<List<GalleryAlbum>>> listAlbums() async =>
      switch (albumsError) {
        final error? => Result.error(error),
        null => Result.ok(albums),
      };

  @override
  Future<Result<void>> selectMore() async {
    selectMoreCalls++;
    return const Result.ok(null);
  }

  @override
  Future<Result<GalleryListing>> list(GalleryQuery query) async {
    listedQuery = query;
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
