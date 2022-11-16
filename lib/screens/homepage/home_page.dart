import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/repository/auth_repository.dart';
import 'package:googdocc/repository/doc_repository.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void signOut(WidgetRef ref) {
    ref.read(authRepoProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createNewDoc(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackBar = ScaffoldMessenger.of(context);

    final errorModel = await ref.read(docRepoProvider).createNewDoc(token);

    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackBar.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userProvider)!.name;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => createNewDoc(context, ref),
            icon: const Icon(
              Icons.add,
            ),
          ),
          IconButton(
            onPressed: () => signOut(ref),
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome $name'),
      ),
    );
  }
}
