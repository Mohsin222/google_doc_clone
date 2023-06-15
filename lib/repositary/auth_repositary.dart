import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/model/error_model.dart';
import 'package:googledoc_clone/model/user_model.dart';
import 'package:googledoc_clone/local_storage/local_storage_repositary.dart';
import 'package:http/http.dart';

import '../constant.dart';

final authApiClassProvider = Provider((ref) {
  return AuthApiClass(
      client: Client(),
      localStorageRepository: LocalStorageRepository(),
      ref: ref);
});

class AuthApiClass {
  final Client _client;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

  AuthApiClass({
    required Client client,
    required Ref ref,
    required LocalStorageRepository localStorageRepository,
  })  : _client = client,
        _ref = ref,
        _localStorageRepository = localStorageRepository;

  Future<Response?> login(
      BuildContext context, String email, String password) async {
    try {
      UserModel userModel = UserModel(
        email: email,

        password: password,

        name: '',
        profilePic: '',
        token: '',
        uid: '',

        // patientData: user.patientData
      );

      Response res = await _client.post(
        Uri.parse('http://localhost:3000/auth/login'),
        body: userModel.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      return res;
    } catch (e) {
      ErrorModel errorModel=ErrorModel(error: e.toString(), data: '');
print(e.toString());
    }
  }

  //get user data if token is present
  Future<Response?> getUserData(String token) async {
    print(token);
    try {
      Response res = await _client.get(
        Uri.parse('http://localhost:3000/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'x-auth-token':token,
          // 'Bearer':token
               'Authorization': 'Bearer $token',
        },
      );
          print('Token : ${token}');

print(res.statusCode);
      return res;
    } catch (e) {
      // ErrorModel errorModel=ErrorModel(error: e.toString(), data: '');
      print(e);
    }
  }



    Future<Response?> getDocuments(String? token) async {
    try {
      Response res = await _client.get(
        Uri.parse('http://localhost:3000/documents/docs'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'x-auth-token': token,
        },
      );

      return res;
    } catch (e) {
      // ErrorModel errorModel=ErrorModel(error: e.toString(), data: '');
      print(e.toString());
    }
  }
}
