import 'package:bpp/features/database_sync/domain/usecases/download_dabase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'database_sync_event.dart';
import 'database_sync_state.dart';

class DatabaseSyncBloc extends Bloc<DatabaseSyncEvent, DatabaseSyncState> {
  final DownloadDatabase downloadDatabase;

  DatabaseSyncBloc(this.downloadDatabase) : super(DatabaseSyncInitial()) {
    on<DownloadDatabaseRequested>((event, emit) async {
      emit(DatabaseSyncLoading());

      try {
        await downloadDatabase();
        emit(DatabaseSyncSuccess());
      } catch (e) {
        emit(DatabaseSyncFailure(e.toString()));
      }
    });
  }
}
