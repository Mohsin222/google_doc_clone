import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/controller/auth_controller.dart';
import 'package:googledoc_clone/controller/documentController.dart';
import 'package:googledoc_clone/model/document_model.dart';
import 'package:googledoc_clone/screens/document_list_screen.dart';

import 'package:routemaster/routemaster.dart';

import '../components/loader.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});


    void signOut(WidgetRef ref) async{
   await ref.read(authControllerProvider.notifier).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createDocument(BuildContext context, WidgetRef ref) async {
    String? token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    ref.read(documentontrollerProvider.notifier).createDocuments();

    // if (errorModel.data != null) {
    //   navigator.push('/document/${errorModel.data.id}');
    // } else {
    //   snackbar.showSnackBar(
    //     SnackBar(
    //       content: Text(errorModel.error!),
    //     ),
    //   );
    // }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
       final docsProvider = ref.watch(documentListProvider) ?? [];
   final user = ref.watch(userProvider);
   ref.read(documentontrollerProvider.notifier).getDocuments(ref );
    return  Scaffold(
      appBar: AppBar(title: Text('a'),
      
      actions: [
           IconButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>DocumentListScreen()));
        }, icon:const Icon(Icons.create)),
        IconButton(onPressed: (){
     createDocument(context, ref);
        }, icon:const Icon(Icons.create)),

        
        IconButton(onPressed: (){
          signOut(ref);
        }, icon:const Icon(Icons.logout_outlined))
      ],),
      
      // body: Center(
      //   child: Column(children: [
      //         if (user?.email != null)
      //         Text(user!.token.toString()),

      //         Text(user!.name.toString()),
      //       Container(
      //         height: 200,
      //         child: Image(image: NetworkImage(user.profilePic.toString())),)
      //   ]),
      // ),

      body: FutureBuilder(
        // future: ref.read(documentontrollerProvider.notifier).getDocuments(ref ),

        builder: (context, AsyncSnapshot snapshot) {
        
          if(snapshot.connectionState == ConnectionState.waiting){
            return Loader();
          }
          snapshot.data ?? 0;
            // final data = snapshot.data! ?? 0;
          return ListView.builder(
            // itemCount: snapshot.data!.data.length,
            itemCount: 0,
           
            itemBuilder: (context,index){
              // final   ds = snapshot.data;
                        // DocumentModel document = snapshot.data!.data[index];
// var ddd =ref.watch(documentListProv);
              
              var data = snapshot.data;
// Data docList = dataP  

// return Text(documentModel.title  ==''? 'aa':documentModel.title);
return Text(data[index].toString());
          });
        },
      ),
    );
  }
}