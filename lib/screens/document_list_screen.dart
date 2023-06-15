import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/controller/documentController.dart';
import 'package:routemaster/routemaster.dart';

class DocumentListScreen extends ConsumerWidget {
  const DocumentListScreen({super.key});



void navigateToDocument(BuildContext context, String documentId){
  Routemaster.of(context).push('/document/$documentId');
}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 final docData =   ref.watch(documentListProvider)!.data;
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(width: 600,
        
        child: ListView.builder(
          itemCount: docData!.length,
          itemBuilder: (context,index){
      
      if(docData !=null){
        return InkWell(
          onTap: ()=>navigateToDocument(context, docData[index].sId.toString()),
          child: Card(
            elevation: 10,
            child: Column(
          children: [
            Text(docData[index].title.toString()),
            Text(docData[index].createdAt.toString()),
              Text(docData[index].createdAt.toString()),
                Text(docData[index].content.toString()),
          ],
            ),
          ),
        );
      }else{
        return Text('no Data');
      }
        }),),
      ),
    );
  }
}