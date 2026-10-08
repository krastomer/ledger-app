import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/data/repositories/gallery/gallery_repository.dart';
import 'package:ledger_app/domain/models/found_slip.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_listing.dart';
import 'package:ledger_app/domain/models/gallery_query.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'setup_scan_cubit.freezed.dart';
part 'setup_scan_state.dart';

class SetupScanCubit extends Cubit<SetupScanState> {
  SetupScanCubit({
    required this._galleryRepository,
    required this._importSlip,
    required this._query,
  }) : super(const SetupScanState());

  final GalleryRepository _galleryRepository;
  final ImportSlipUseCase _importSlip;
  final GalleryQuery _query;

  Future<void> scan() async {
    final access = await _galleryRepository.requestAccess();
    if (isClosed) return;
    switch (access) {
      case Ok(value: GalleryAccess.denied):
        return emit(_failed(SetupScanError.noAccess));
      case Error():
        return emit(_failed(SetupScanError.listFailed));
      case Ok():
        break;
    }
    final listing = await _galleryRepository.list(_query);
    if (isClosed) return;
    switch (listing) {
      case Ok(:final value):
        await _check(value);
      case Error():
        emit(_failed(SetupScanError.listFailed));
    }
  }

  Future<void> _check(GalleryListing listing) async {
    emit(
      state.copyWith(
        phase: SetupScanPhase.scanning,
        libraryCount: listing.libraryCount,
        toCheck: listing.photoIds.length,
      ),
    );
    var found = const <FoundSlip>[];
    final references = <String>{};
    var checked = 0;
    for (final id in listing.photoIds) {
      final slip = await _read(id);
      if (isClosed) return;
      checked++;
      final reference = slip?.draft.parsed.slip.reference;
      if (slip != null && (reference == null || references.add(reference))) {
        found = [...found, slip];
      }
      emit(state.copyWith(checked: checked, found: found));
    }
    emit(
      state.copyWith(
        phase: SetupScanPhase.scanned,
        selected: {
          for (final slip in found)
            if (slip.importable) slip.id,
        },
      ),
    );
  }

  /// The slip in photo [id], or null when it isn't one or is already in
  /// the ledger.
  Future<FoundSlip?> _read(String id) async {
    final path = await _galleryRepository.imagePath(id);
    if (path is! Ok<String>) return null;
    final draft = await _importSlip.read(path.value);
    return switch (draft) {
      Ok(:final value) when value.duplicate == null => FoundSlip(draft: value),
      _ => null,
    };
  }

  void skip() => emit(state.copyWith(phase: SetupScanPhase.done));

  void review() => emit(state.copyWith(phase: SetupScanPhase.review));

  void toggle(String id) {
    final slip = state.found.where((s) => s.id == id).firstOrNull;
    if (slip == null || !slip.importable) return;
    emit(
      state.copyWith(
        selected: state.selected.contains(id)
            ? ({...state.selected}..remove(id))
            : {...state.selected, id},
      ),
    );
  }

  void selectAll(bool value) => emit(
    state.copyWith(
      selected: value
          ? {
              for (final slip in state.found)
                if (slip.importable) slip.id,
            }
          : const {},
    ),
  );

  Future<void> importSelected() async {
    emit(state.copyWith(phase: SetupScanPhase.saving, error: null));
    final saved = <String>{};
    for (final slip in state.found) {
      final transaction = slip.transaction;
      if (transaction == null || !state.selected.contains(slip.id)) continue;
      final result = await _importSlip.save(transaction);
      if (isClosed) return;
      if (result is Error<void>) {
        return emit(
          state.copyWith(
            phase: SetupScanPhase.review,
            error: SetupScanError.saveFailed,
            found: [
              for (final s in state.found)
                if (!saved.contains(s.id)) s,
            ],
            selected: state.selected.difference(saved),
          ),
        );
      }
      saved.add(slip.id);
    }
    emit(state.copyWith(phase: SetupScanPhase.done));
  }

  SetupScanState _failed(SetupScanError error) =>
      state.copyWith(phase: SetupScanPhase.failed, error: error);
}
