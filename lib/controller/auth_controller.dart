import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/local_storage/local_storage_repositary.dart';
import 'package:googledoc_clone/model/error_model.dart';
import 'package:googledoc_clone/model/user_model.dart';
import 'package:googledoc_clone/repositary/auth_repositary.dart';
import 'package:googledoc_clone/screens/mainMage.dart';
import 'package:http/http.dart';
import 'package:routemaster/routemaster.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    client: Client(),
    ref: ref,
    localStorageRepository: LocalStorageRepository(),
    authApiClass: ref.read(authApiClassProvider),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthController extends StateNotifier<bool> {
  final AuthApiClass _authApiClass;
  final Client _client;
  final LocalStorageRepository _localStorageRepository;

  final Ref _ref;

  AuthController(
      {required Client client,
      required AuthApiClass authApiClass,
      required LocalStorageRepository localStorageRepository,
      required Ref ref})
      : _client = client,
        _authApiClass = authApiClass,
        _ref = ref,
        _localStorageRepository = localStorageRepository,
        super(false);

  void loginUser(BuildContext context, String email, String password) async {
    try {
      state = true;
      final user = await _authApiClass.login(context, email, password);
      state = false;

      if (user!.statusCode == 200) {
        _ref.read(userProvider.notifier).update((state) {
          final data = jsonDecode(user.body);
          var userModel = UserModel.fromMap(data['data']);

          _localStorageRepository.setToken(userModel.token.toString());
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const MainPage()));
  //  Routemaster.of(context).push('/mainPage');

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

  Future getUserModelData() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred.',
      data: null,
    );

    try {
  
      String? token = await _localStorageRepository.getToken();



      if (token != null) {
        var res = await _authApiClass.getUserData(token);

        switch (res!.statusCode) {
          case 200:
            _ref.read(userProvider.notifier).update((state) {
              final data = jsonDecode(res.body);
              var userModel = UserModel.fromMap(data['data']);

              userModel.token != token;
                  error = ErrorModel(error: null, data: userModel);
            _localStorageRepository.setToken(userModel.token!);



              return userModel;
              
            });
            break;

          default:
            print("default ERROR");
            break;
        }
      }
    } catch (e) {
         error = ErrorModel(
        error: e.toString(),
        data: null,
      );

    }
   
  }


    signOut() async {
      _localStorageRepository.setToken('');
 
   
  }



  void getDocumens(BuildContext context, ) async {
    try {
      state = true;
      final user = await _authApiClass.getDocuments('');
      state = false;

      if (user!.statusCode == 200) {
        // _ref.read(userProvider.notifier).update((state) {
        //   final data = jsonDecode(user.body);
        //   var userModel = UserModel.fromMap(data['data']);

        //   _localStorageRepository.setToken(userModel.token.toString());
        //   // Navigator.pushReplacement(context,
        //   //     MaterialPageRoute(builder: (context) => const MainPage()));
  

        //   return UserModel.fromMap(data['data']);
        // });
        //  Routemaster.of(context).replace('/mainPage');
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
