import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/repository/auth_repository.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userProvider)!.name;
    return Scaffold(
      body: Center(
        child: Text('Welcome $name'),
      ),
    );
  }
}
