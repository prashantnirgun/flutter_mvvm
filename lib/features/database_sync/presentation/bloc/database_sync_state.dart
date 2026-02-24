import 'package:equatable/equatable.dart';

abstract class DatabaseSyncState extends Equatable {
  const DatabaseSyncState();

  @override
  List<Object?> get props => [];
}

class DatabaseSyncInitial extends DatabaseSyncState {
  const DatabaseSyncInitial();
}

class DatabaseSyncLoading extends DatabaseSyncState {
  const DatabaseSyncLoading();
}

class DatabaseSyncSuccess extends DatabaseSyncState {
  const DatabaseSyncSuccess();
}

class DatabaseSyncFailure extends DatabaseSyncState {
  final String message;

  const DatabaseSyncFailure(this.message);

  @override
  List<Object?> get props => [message];
}
