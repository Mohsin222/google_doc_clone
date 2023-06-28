import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/colors.dart';
import 'package:googledoc_clone/controller/documentController.dart';
import 'package:googledoc_clone/repositary/socket_repositary.dart';
import 'package:googledoc_clone/screens/auth/down.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
class DocumentListScreen extends ConsumerStatefulWidget {




  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
void navigateToDocument(BuildContext context, String documentId){
  Routemaster.of(context).push('/document/$documentId');
}

TextEditingController titleController =TextEditingController(text: 'Untitled Documents');

SocketRepositary socketRepositary = SocketRepositary();




@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
  }
quill.QuillController _controller = quill.QuillController.basic();
  fetchDocument()async{
     final docData =   ref.watch(documentListProvider)!.data;


    //      if (docData != null) {
    //   titleController.text =d
    //   _controller = quill.QuillController(
    //     document: errorModel!.data.content.isEmpty
    //         ? quill.Document()
    //         : quill.Document.fromDelta(
    //             quill.Delta.fromJson(errorModel!.data.content),
    //           ),
    //     selection: const TextSelection.collapsed(offset: 0),
    //   );
    //   setState(() {});
    // }

   
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
 



 
      var docData =   ref.watch(documentListProvider)!.data ;
       
      print(docData![0].content!);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.back_hand),onPressed: (){
          Navigator.pop(context);
        }),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              
            });
          }, icon: Text('aa')),
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
          itemCount: docData.length,
          itemBuilder: (context,index){

      if(docData.isNotEmpty){



  
           _controller = quill.QuillController(
  document: quill.Document.fromJson(docData[index].content!),
  selection: TextSelection.collapsed(offset: 0)
);


print(_controller.document.toDelta().toJson());
        return InkWell(
          // onTap: ()=>navigateToDocument(context, docData[index].sId.toString()),
          child: Card(
            elevation: 10,
            child: Column(
          children: [
            Container(height: 200,
            child: quill.QuillEditor.basic(
          controller: _controller,
          readOnly: true,
        ),
      
            
            ),
            // Text(docData[index].title.toString()),
            // Text(docData[index].createdAt.toString()),
            //   Text(docData[index].createdAt.toString()),
            //     Text(docData[index].content.toString()),
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