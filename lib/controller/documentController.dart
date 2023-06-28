

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/local_storage/local_storage_repositary.dart';
import 'package:googledoc_clone/model/document_model.dart';
import 'package:googledoc_clone/repositary/document_repositary.dart';
import 'package:http/http.dart';


final documentListProvider =StateProvider<DocumentModel?>((ref)=>null);

final singledocument =StateProvider<Data?>((ref)=>null);
final documentListProv =StateProvider<List<Data>?>((ref)=>[]);

final documentontrollerProvider = StateNotifierProvider<DocumentController, bool>(
  (ref) => DocumentController(
    client: Client(),
    ref: ref,
    docuementRepositary: ref.read(docuementRepositary),
    localStorageRepository: LocalStorageRepository(),

  ),
);

class DocumentController extends StateNotifier<bool> {

  final Client _client;
  final LocalStorageRepository _localStorageRepository;
final DocuementRepositary _docuementRepositary;
  final Ref _ref;

  DocumentController({
    required Client client,
required DocuementRepositary docuementRepositary,
      required LocalStorageRepository localStorageRepository,
      required Ref ref
  }):
  _client = client,
     _docuementRepositary=docuementRepositary,
        _ref = ref,
        _localStorageRepository = localStorageRepository,
        super(false);



void createDocuments(var content)async{
try {
     String? token = await _localStorageRepository.getToken();
        state = true;
      final user = await _docuementRepositary.postDocuments(token!,content);
      state = false;
} catch (e) {
  print(e.toString());
}
}


  getDocuments(WidgetRef ref)async{
try {
     String? token = await _localStorageRepository.getToken();
        state = true;
      final user = await _docuementRepositary.getDocuments(token!);
      state = false;

      if(user!.statusCode ==200){
ref.read(documentListProvider.notifier).update((state) {
     var data = jsonDecode(user.body);
        var documentModel = DocumentModel.fromJson(data);

        print(documentModel.data.toString()+'aaaaaaaaaaaaaaaaaaaaaa');
        return  documentModel;
});
      }else{
        print(user.statusCode );
      }
} catch (e) {
  print(e.toString());
}
}


void updateDocuments({required String id, required String title})async{
try {
     String? token = await _localStorageRepository.getToken();
        state = true;
      final user = await _docuementRepositary.updateDocuments(token:token!,id:id,title:title);
      state = false;
} catch (e) {
  print(e.toString());
}
}


 getDocumentById(String id,WidgetRef ref)async{
try {
     String? token = await _localStorageRepository.getToken();
        state = true;
      final user = await _docuementRepositary.getDocumentsById(id: id,token: token!);
      state = false;
            if(user!.statusCode ==200){
ref.read(singledocument.notifier).update((state) {
     final data = jsonDecode(user.body);

    //  print(data);
        var dataModle = Data.fromJson(data['data']);

        // return  Data.fromJson(data);
// print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

//         print(dataModle.title);

        return dataModle;
        
});
   return user.statusCode;
      }else{

        return user.statusCode;
        print(user.statusCode );
      }


} catch (e) {
    print(e.toString());
}
}
}