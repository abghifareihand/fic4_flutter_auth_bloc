import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/login_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/register_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/login_response_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/profile_response_model.dart';
import 'package:fic4_flutter_auth_bloc/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDatasources {
  Future<RegisterResponeModel> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      body: registerModel.toMap(),
    );

    return RegisterResponeModel.fromJson(response.body);
    //return result;
  }

  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
      body: loginModel.toMap(),
    );

    return LoginResponseModel.fromJson(response.body);
    //return result;
  }

  Future<ProfileResponeModel> getProfile() async {
    final token = await AuthLocalStorage().getToken();
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
      headers: headers,
    );

    return ProfileResponeModel.fromJson(response.body);
    //return result;
  }
}
