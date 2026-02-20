abstract class DatabaseSyncState {}

class DatabaseSyncInitial extends DatabaseSyncState {}

class DatabaseSyncLoading extends DatabaseSyncState {}

class DatabaseSyncSuccess extends DatabaseSyncState {}

class DatabaseSyncFailure extends DatabaseSyncState {
  final String message;

  DatabaseSyncFailure(this.message);
}
