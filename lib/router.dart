import 'package:flutter/material.dart';
import 'package:googledoc_clone/screens/login_screen.dart';
import 'package:googledoc_clone/screens/mainMage.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute= RouteMap(routes: {
  '/':(route) =>  MaterialPage(child: LoginScreen())
});


final loggedInRoute= RouteMap(routes: {
  '/':(route) =>  MaterialPage(child:  LoginScreen()),

    '/mainPage': (route) => MaterialPage(
        child: MainPage(

        ),
      ),
});