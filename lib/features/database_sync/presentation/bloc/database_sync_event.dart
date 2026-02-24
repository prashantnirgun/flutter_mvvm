import 'package:equatable/equatable.dart';

abstract class DatabaseSyncEvent extends Equatable {
  const DatabaseSyncEvent();

  @override
  List<Object?> get props => [];
}

class DownloadDatabaseRequested extends DatabaseSyncEvent {
  const DownloadDatabaseRequested();
}
