import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {},
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
