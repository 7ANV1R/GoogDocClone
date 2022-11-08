import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/repository/auth_repository.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  void signInWithGoogle(WidgetRef ref) {
    ref.read(authRepoProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => signInWithGoogle(ref),
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
