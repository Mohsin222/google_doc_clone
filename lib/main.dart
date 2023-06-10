import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/controller/auth_controller.dart';

import 'package:googledoc_clone/model/error_model.dart';
import 'package:googledoc_clone/router.dart';

import 'package:googledoc_clone/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
 ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.


    ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    var data = await ref.read(authControllerProvider.notifier).getUserModelData();

    if (data != null ) {
      ref.read(userProvider.notifier).update((state) => jsonDecode(data['data']));

      print(jsonDecode(data['data']));
    }
  }

  @override
  Widget build(BuildContext context) {
     final user = ref.watch(userProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
  
        primarySwatch: Colors.blue,
      ),
      
      // home:  user != null && user.token!.isNotEmpty?
      //  LoginScreen()
      // :LoginScreen()
      routerDelegate: RoutemasterDelegate(routesBuilder: (context){
        // final user = ref.watch(userProvider);
        // if(user !=null && user.token!.isNotEmpty){}
  final user = ref.watch(userProvider);
        if (user != null && user.token!.isNotEmpty && user.token! !='') {
          return loggedInRoute;
        }
   return loggedOutRoute;
      }),

      routeInformationParser: const RoutemasterParser(),
    );
  }
}

