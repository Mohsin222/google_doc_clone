import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/local_storage/local_storage_repositary.dart';
import 'package:http/http.dart';

import '../constant.dart';

final docuementRepositary = Provider((ref) {
  return DocuementRepositary(client: Client(), localStorageRepository: LocalStorageRepository(), ref: ref);
});

class DocuementRepositary{


  final Client _client;
  final LocalStorageRepository _localStorageRepository;
  final Ref _ref;

  DocuementRepositary({
    required Client client,
    required LocalStorageRepository localStorageRepository,
    required Ref ref,
  }):
  _client =client,
  _localStorageRepository =localStorageRepository,
  _ref =ref;


  Future<Response?> postDocuments(String token)async{
    try {
          Response res = await _client.post(
        Uri.parse('$url/document/create'),
        body: jsonEncode({
          "createdAt":DateTime.now().microsecondsSinceEpoch
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
             'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
 
        print(e.toString());
      
    }
  }



    Future<Response?> getDocuments(String token)async{
    try {
          Response res = await _client.get(
        Uri.parse('$url/document/docs'),
      
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
             'Authorization': 'Bearer $token',
        },
      );

      return res;
    } catch (e) {
 
        print(e.toString());
      
    }
  }
}