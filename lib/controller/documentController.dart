

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/local_storage/local_storage_repositary.dart';
import 'package:googledoc_clone/model/document_model.dart';
import 'package:googledoc_clone/repositary/document_repositary.dart';
import 'package:http/http.dart';


final documentListProvider =StateProvider<DocumentModel?>((ref)=>null);


final documentListProv =StateProvider<List<DocumentModel>?>((ref)=>[]);

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



void createDocuments()async{
try {
     String? token = await _localStorageRepository.getToken();
        state = true;
      final user = await _docuementRepositary.postDocuments(token!);
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
     final data = jsonDecode(user.body);
        var documentModel = DocumentModel.fromJson(data);

        return  DocumentModel.fromJson(data);
});
      }else{
        print(user.statusCode );
      }
} catch (e) {
  print(e.toString());
}
}



//  getDocuments(WidgetRef ref)async{
// try {
  
//      String? token = await _localStorageRepository.getToken();
//         state = true;
//       final user = await _docuementRepositary.getDocuments(token!);
//       state = false;

//       if(user!.statusCode ==200){
//        List<DocumentModel>? documents = [];
//      final data = jsonDecode(user.body);
     
//         var documentModel = DocumentModel.fromJson(data);
//    for (int i = 0; i < jsonDecode(user.body).length; i++) {
//             documents.add(DocumentModel.fromJson(jsonEncode(jsonDecode(user.body)[i])));
//           }
//           ref.read(documentListProv.notifier).update((state) => documents);
// print(documents.toString() +'aaaaaaaaa');
// return documents;
//       }else{
//         print(user.statusCode );
//       }
// } catch (e) {
//   print(e.toString());
// }
// }
}