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


  Future<Response?> postDocuments(String token ,var content)async{
    try {
          Response res = await _client.post(
        Uri.parse('$url/document/create'),
        body: jsonEncode({
          "createdAt":DateTime.now().microsecondsSinceEpoch,
          "content":content

        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
             'Authorization': 'Bearer $token',
        },
      );

      print(res.statusCode);
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


   Future<Response?> updateDocuments({required String token,id,title})async{
    try {
          Response res = await _client.post(
        Uri.parse('$url/document/create/title'),
        body: jsonEncode({
          // "createdAt":DateTime.now().microsecondsSinceEpoch
          'id':id,
          

          'title':title
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

//get documents by id
    Future<Response?> getDocumentsById({required String token, required String id})async{
    try {
          Response res = await _client.get(
        Uri.parse('$url/document/docs/$id'),
      
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
             'Authorization': 'Bearer $token',
        },
      );
// print(res.body);
      return res;
    } catch (e) {
 
        print(e.toString());
      
    }
  }

}