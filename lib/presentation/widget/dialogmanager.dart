import 'package:flutter/material.dart';

import 'package:patroli_fakta/presentation/provider/berita_detail_notifier.dart';
import 'package:patroli_fakta/presentation/provider/berita_list_notifier.dart';

import 'package:patroli_fakta/presentation/provider/login_notifier.dart';
import 'package:patroli_fakta/presentation/provider/removeberita_notifier.dart';
import 'package:patroli_fakta/presentation/provider/status_provider.dart';
import 'package:provider/provider.dart';

class StatusDialogManager extends StatelessWidget {
  const StatusDialogManager({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginNotifier>().status;
    if (state is Isidle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });

      return const SizedBox.shrink();
    }

    if (state is StatusIsloading) {
      return const AlertDialog(
        title: Text('Loading...'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      );
    }

    if (state is Issuksesmessage) {
      return AlertDialog(
        title: Text(
          state.message,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        icon: Icon(Icons.check),
        content: const Text('Proses berhasil diselesaikan.'),
        
      );
    }

    if (state is Iserror) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(state.message),
        actions: [
          TextButton(
            onPressed: () {
              context.read<LoginNotifier>().setidle();
            },
            child: const Text('Tutup'),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}


class StatusDialogManagerAdmin extends StatelessWidget {
  const StatusDialogManagerAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<RemoveberitaNotifier>().status;
    if (state is Isidle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });

      return const SizedBox.shrink();
    }

    if (state is StatusIsloading) {
      return const AlertDialog(
        title: Text('Loading...'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      );
    }

    if (state is Issuksesmessage) {
      return AlertDialog(
        title: Text(
          state.message,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        icon: Icon(Icons.check),
        content: const Text('Proses berhasil diselesaikan.'),
        actions: [
          TextButton(onPressed: (){
            context.read<RemoveberitaNotifier>().setidle();
          }, child: const Text("ok"))
        ],
        
      );
    }

    if (state is Iserror) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(state.message),
        actions: [
          TextButton(
            onPressed: () {
              context.read<BeritaListNotifier>().fetchdatalistberita();
              context.read<RemoveberitaNotifier>().setidle();
            },
            child: const Text('Tutup'),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

