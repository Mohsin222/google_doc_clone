import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/colors.dart';
import 'package:googledoc_clone/controller/documentController.dart';
import 'package:routemaster/routemaster.dart';

class DocumentListScreen extends ConsumerStatefulWidget {




  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
void navigateToDocument(BuildContext context, String documentId){
  Routemaster.of(context).push('/document/$documentId');
}

TextEditingController titleController =TextEditingController(text: 'Untitled Documents');

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
 final docData =   ref.watch(documentListProvider)!.data;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.lock,size: 16,), label: Text('Share'),
            
            style: ElevatedButton.styleFrom(
              backgroundColor: kBluekColor
            ),
            ),
          )
        ],

        title: Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 9),
          child: Row(children: [
           Image.asset('assets/images/docs-logo.png',height: 40,),
           SizedBox(width: 10,),
        
           SizedBox(
            width: 150,
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(border: InputBorder.none,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: kBluekColor)),
              contentPadding: EdgeInsets.only(left: 10)
              ),
            )),
          ],),
        ),

        bottom: PreferredSize(child: Container(decoration: BoxDecoration(border: Border.all(color:kGrayColor,width: 0.1 )),), preferredSize:const Size.fromHeight(1)),
      ),
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