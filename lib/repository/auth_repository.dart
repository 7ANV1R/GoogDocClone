// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepository(googleSignIn: GoogleSignIn()),
);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  void signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        log(user.email);
        log(user.photoUrl!);
        log(user.displayName!);
      } else {
        log('not found');
        print('not found');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
