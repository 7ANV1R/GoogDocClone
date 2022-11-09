// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/const.dart';
import 'package:googdocc/models/error_model.dart';
import 'package:googdocc/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
  ),
);

final userProvider = StateProvider<UserModel?>(
  (ref) => null,
);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(error: 'Some Error', data: null);

    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
            name: user.displayName!, email: user.email, profilePic: user.photoUrl!, token: '', uid: '');

        var response = await _client.post(Uri.parse('$host/api/signup'), body: userAcc.toJson(), headers: {
          'Content-Type': 'application/Json; charset=UTF-8',
        });

        switch (response.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(uid: jsonDecode(response.body)['users']['_id']);
            error = ErrorModel(error: null, data: newUser);
            break;
        }
      } else {
        log('not found');
      }
    } catch (e) {
      log(e.toString());
    }
    return error;
  }
}
