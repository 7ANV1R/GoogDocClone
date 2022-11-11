import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepo {
  void setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('jwtToken', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('jwtToken');
    return token;
  }
}
