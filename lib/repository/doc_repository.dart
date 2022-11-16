import 'dart:convert';
import 'dart:developer';

import 'package:googdocc/const.dart';
import 'package:googdocc/models/doc_model.dart';
import 'package:googdocc/models/error_model.dart';
import 'package:http/http.dart';

class DocRepository {
  DocRepository({
    required Client client,
  }) : _client = client;
  final Client _client;

  Future<ErrorModel> createNewDoc(String token) async {
    ErrorModel error = ErrorModel(error: 'Some unexpected error occurred in creating new doc.', data: null);
    try {
      var response = await _client.post(Uri.parse('$host/doc/create'),
          body: jsonEncode({
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          });

      switch (response.statusCode) {
        case 200:
          error = ErrorModel(error: null, data: DocModel.fromJson(response.body));
          break;
      }
    } catch (e) {
      log(e.toString());
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
