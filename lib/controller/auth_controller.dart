import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/model/error_model.dart';
import 'package:googledoc_clone/model/user_model.dart';
import 'package:googledoc_clone/repositary/auth_repositary.dart';
import 'package:googledoc_clone/screens/mainMage.dart';
import 'package:http/http.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    client: Client(),
    ref: ref,
    authApiClass: ref.read(authApiClassProvider),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthController extends StateNotifier<bool>{
  final AuthApiClass _authApiClass;
  final Client _client;

  final Ref _ref;

  AuthController(
      {required Client client,
      required AuthApiClass authApiClass,
      required Ref ref})
      : _client = client,
        _authApiClass = authApiClass,
        _ref = ref,
        super(false);

  void loginUser(BuildContext context, String email ,String password) async {


    try {
      state = true;
      final user = await _authApiClass.login(context, email, password);
      state = false;

      if (user!.statusCode == 200) {


        _ref.read(userProvider.notifier).update((state) {

             final data = jsonDecode(user.body);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()));


                      return UserModel.fromMap(data['data']);
        });
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(user.body.toString(), style: TextStyle())));
      }
    } catch (e) {
  
      ErrorModel error = ErrorModel(error: e.toString(), data: null);

      print(e.toString());
    }
  }
}
