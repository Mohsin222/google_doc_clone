import 'package:flutter/material.dart';
import 'package:googledoc_clone/screens/create_document.dart';
import 'package:googledoc_clone/screens/document_list_screen.dart';
import 'package:googledoc_clone/screens/document_scrn.dart';
import 'package:googledoc_clone/screens/auth/login_screen.dart';
import 'package:googledoc_clone/screens/mainMage.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute= RouteMap(routes: {
  '/':(route) =>  MaterialPage(child: LoginScreen())
});


final loggedInRoute= RouteMap(routes: {
  '/':(route) =>  MaterialPage(child:  MainPage()),

    '/documentPage': (route) =>  MaterialPage(
        child: DocumentListScreen(

        ),
      ),
      '/document/:_id': (route) => MaterialPage(
        child: DocumentScreen(
          id: route.pathParameters['_id'] ?? '',
        ),
      ),


         '/createDocument': (route) =>  MaterialPage(
        child: CreateDocument(

        ),
      ),
});