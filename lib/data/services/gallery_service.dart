import 'package:flutter/services.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_album.dart';
import 'package:ledger_app/domain/models/gallery_query.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:photo_manager/photo_manager.dart';

/// Reads the device photo library through `photo_manager`.
class GalleryService {
  Future<Result<GalleryAccess>> requestAccess() async {
    try {
      final state = await PhotoManager.requestPermissionExtend();
      return Result.ok(switch (state) {
        PermissionState.authorized => GalleryAccess.granted,
        PermissionState.limited => GalleryAccess.limited,
        _ => GalleryAccess.denied,
      });
    } on PlatformException catch (e) {
      return Result.error(Exception('Could not ask for photos (${e.code})'));
    }
  }

  Future<Result<List<GalleryAlbum>>> listAlbums() async {
    try {
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );
      final albums = <GalleryAlbum>[];
      for (final path in paths) {
        final count = await path.assetCountAsync;
        if (count == 0) continue;
        albums.add(
          GalleryAlbum(
            id: path.id,
            name: path.name,
            count: count,
            kind: _kindOf(path),
          ),
        );
      }
      albums.sort((a, b) {
        final recents =
            (b.kind == GalleryAlbumKind.recents ? 1 : 0) -
            (a.kind == GalleryAlbumKind.recents ? 1 : 0);
        return recents != 0 ? recents : b.count.compareTo(a.count);
      });
      return Result.ok(albums);
    } on PlatformException catch (e) {
      return Result.error(Exception('Could not list albums (${e.code})'));
    }
  }

  Future<Result<GalleryListing>> list(
    GalleryQuery query, {
    DateTime? now,
  }) async {
    try {
      final all = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      final library = all.firstOrNull;
      if (library == null) {
        return const Result.ok(GalleryListing(libraryCount: 0, photoIds: []));
      }
      final libraryCount = await library.assetCountAsync;
      final clock = now ?? DateTime.now();
      final since = query.lookBack.since(clock);
      final paths = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          createTimeCond: DateTimeCond(
            min: since ?? DateTime.fromMillisecondsSinceEpoch(0),
            max: clock.add(const Duration(days: 1)),
            ignore: since == null,
          ),
        ),
      );
      final chosen = [
        for (final path in paths)
          if (query.albumIds.contains(path.id)) path,
      ];
      final sources = chosen.isNotEmpty
          ? chosen
          : [
              for (final path in paths)
                if (path.isAll) path,
            ];
      final assets = <String, AssetEntity>{};
      for (final path in sources) {
        final count = await path.assetCountAsync;
        if (count == 0) continue;
        for (final asset in await path.getAssetListRange(
          start: 0,
          end: count,
        )) {
          assets[asset.id] = asset;
        }
      }
      final newestFirst = assets.values.toList()
        ..sort((a, b) => b.createDateTime.compareTo(a.createDateTime));
      return Result.ok(
        GalleryListing(
          libraryCount: libraryCount,
          photoIds: [for (final asset in newestFirst) asset.id],
        ),
      );
    } on PlatformException catch (e) {
      return Result.error(Exception('Could not read photos (${e.code})'));
    }
  }

  Future<Result<void>> selectMore() async {
    try {
      await PhotoManager.presentLimited(type: RequestType.image);
      return const Result.ok(null);
    } on PlatformException catch (e) {
      return Result.error(Exception('Could not change photos (${e.code})'));
    }
  }

  /// A local copy of the image to read it from.
  Future<Result<String>> imagePath(String id) async {
    try {
      final asset = await AssetEntity.fromId(id);
      final file = await asset?.originFile;
      return file == null
          ? Result.error(Exception('Photo is not available'))
          : Result.ok(file.path);
    } on PlatformException catch (e) {
      return Result.error(Exception('Could not open the photo (${e.code})'));
    }
  }

  static GalleryAlbumKind _kindOf(AssetPathEntity path) {
    if (path.isAll) return GalleryAlbumKind.recents;
    final isScreenshots =
        path.albumTypeEx?.darwin?.subtype ==
            PMDarwinAssetCollectionSubtype.smartAlbumScreenshots ||
        path.name.toLowerCase().contains('screenshot');
    return isScreenshots
        ? GalleryAlbumKind.screenshots
        : GalleryAlbumKind.other;
  }
}
