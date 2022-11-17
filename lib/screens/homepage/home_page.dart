import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/models/doc_model.dart';
import 'package:googdocc/models/error_model.dart';
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
    // final name = ref.watch(userProvider)!.name;
    final String token = ref.watch(userProvider)!.token;
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
      //fix this
      body: FutureBuilder<ErrorModel>(
        future: ref.watch(docRepoProvider).getAllDoc(
              token,
            ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(
              child: Text(error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<DocModel> allDoc = snapshot.data!.data;
            return ListView.builder(
              itemCount: allDoc.length,
              itemBuilder: (context, index) {
                DocModel doc = snapshot.data!.data[index];
                return Card(
                  child: Text(doc.id),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
