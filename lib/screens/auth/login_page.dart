import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/repository/auth_repository.dart';
import 'package:googdocc/screens/homepage/home_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel = await ref.read(authRepoProvider).signInWithGoogle();
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      sMessenger.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => signInWithGoogle(ref, context),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(230, 56),
          ),
          icon: CachedNetworkImage(
            imageUrl: "https://pngimg.com/uploads/google/google_PNG19635.png",
            height: 30,
            width: 30,
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => const Icon(Icons.login),
          ),
          label: const Text('Sign-in with Google'),
        ),
      ),
    );
  }
}
