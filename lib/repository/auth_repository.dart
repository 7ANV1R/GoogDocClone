// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googdocc/const.dart';
import 'package:googdocc/models/error_model.dart';
import 'package:googdocc/models/user_model.dart';
import 'package:googdocc/repository/local_storage_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStorageRepo: LocalStorageRepo(),
  ),
);

final userProvider = StateProvider<UserModel?>(
  (ref) => null,
);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final LocalStorageRepo _localStorageRepo;
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
    required LocalStorageRepo localStorageRepo,
  })  : _googleSignIn = googleSignIn,
        _client = client,
        _localStorageRepo = localStorageRepo;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error = ErrorModel(error: 'Some unexpected error occurred.', data: null);

    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = UserModel(
          name: user.displayName ?? '',
          email: user.email,
          profilePic: user.photoUrl ?? '',
          token: '',
          uid: '',
        );

        var response = await _client.post(Uri.parse('$host/api/signup'), body: userAcc.toJson(), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        });
        log(jsonDecode(response.body).toString());

        switch (response.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: jsonDecode(response.body)['user']['_id'],
              token: jsonDecode(response.body)['token'],
            );
            error = ErrorModel(error: null, data: newUser);
            _localStorageRepo.setToken(newUser.token);
            break;
        }
      }
    } catch (e) {
      log(e.toString());
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(error: 'Some unexpected error occurred.', data: null);

    try {
      String? token = await _localStorageRepo.getToken();

      if (token != null) {
        var response = await _client.get(Uri.parse('$host/user'), headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        });

        switch (response.statusCode) {
          case 200:
            final oldUser = UserModel.fromJson(
              jsonEncode(
                jsonDecode(response.body)['user'],
              ),
            ).copyWith(token: token);

            error = ErrorModel(error: null, data: oldUser);
            break;
        }
      }
    } catch (e) {
      log(e.toString());
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  // Future<ErrorModel> getUserData() async {
  //   ErrorModel error = ErrorModel(error: 'Some unexpected error occurred.', data: null);
  // }

  void signOut() async {
    _googleSignIn.signOut();
    _localStorageRepo.setToken('');
  }
}
