import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_sync_scope.dart';
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

  Future<Result<GalleryListing>> list(GallerySyncScope scope) async {
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
      final album = switch (scope) {
        GallerySyncScope.all => library,
        GallerySyncScope.screenshots => await _screenshots(),
      };
      final count = album == null ? 0 : await album.assetCountAsync;
      final assets = album == null || count == 0
          ? const <AssetEntity>[]
          : await album.getAssetListRange(start: 0, end: count);
      return Result.ok(
        GalleryListing(
          libraryCount: libraryCount,
          photoIds: [for (final asset in assets) asset.id],
        ),
      );
    } on PlatformException catch (e) {
      return Result.error(Exception('Could not read photos (${e.code})'));
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

  static Future<AssetPathEntity?> _screenshots() async {
    final albums = await PhotoManager.getAssetPathList(
      hasAll: false,
      type: RequestType.image,
      pathFilterOption: Platform.isIOS
          ? const PMPathFilter(
              darwin: PMDarwinPathFilter(
                type: [PMDarwinAssetCollectionType.smartAlbum],
                subType: [PMDarwinAssetCollectionSubtype.smartAlbumScreenshots],
              ),
            )
          : const PMPathFilter(),
    );
    if (Platform.isIOS) return albums.firstOrNull;
    return albums
        .where((album) => album.name.toLowerCase() == 'screenshots')
        .firstOrNull;
  }
}
