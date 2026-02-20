import 'package:bpp/features/database_sync/presentation/bloc/database_sync_bloc.dart';
import 'package:bpp/features/database_sync/presentation/bloc/database_sync_event.dart';
import 'package:bpp/features/database_sync/presentation/bloc/database_sync_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseSyncPage extends StatelessWidget {
  const DatabaseSyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Database Sync")),
      body: Center(
        child: BlocConsumer<DatabaseSyncBloc, DatabaseSyncState>(
          listener: (context, state) {
            if (state is DatabaseSyncFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is DatabaseSyncLoading) {
              return const CircularProgressIndicator();
            }

            if (state is DatabaseSyncSuccess) {
              return const Text("Database Downloaded");
            }

            return ElevatedButton(
              onPressed: () {
                context.read<DatabaseSyncBloc>().add(
                  DownloadDatabaseRequested(),
                );
              },
              child: const Text("Download Database"),
            );
          },
        ),
      ),
    );
  }
}
