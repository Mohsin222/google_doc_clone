import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:googledoc_clone/colors.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:googledoc_clone/components/loader.dart';
import 'package:googledoc_clone/controller/documentController.dart';
import 'package:googledoc_clone/repositary/socket_repositary.dart';

import '../model/document_model.dart';
class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
   DocumentScreen({super.key, required this.id});

  @override
  ConsumerState<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
TextEditingController titleController =TextEditingController(text: 'Untitled Documents');

// quill.QuillController _controller = quill.QuillController.basic();
quill.QuillController? _controller ;

SocketRepositary socketRepositary = SocketRepositary();
@override
  void initState() {
  
    // TODO: implement initState
    super.initState();
          getDocument();
    socketRepositary.joinRoom(widget.id);

//  socketRepositary.changeListener((data) {
//    _controller?.compose(
//         quill.Delta.fromJson(data['delta']),
//         _controller?.selection ?? const TextSelection.collapsed(offset: 0),
//         quill.ChangeSource.REMOTE,
//       );
//  });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
_controller!.dispose();

    socketRepositary.changeListener((data) => null);
  }

  void updateTitle(WidgetRef ref, String title){
      ref.read(documentontrollerProvider.notifier).updateDocuments(id: widget.id, title: title);
  }


getDocument()async{

int status = await ref.read(documentontrollerProvider.notifier).getDocumentById(widget.id, ref);

 var data= ref.watch(singledocument);


  if(status ==200){
    print('INSIDE');
   var singleDocData=  ref.watch(singledocument);
   print(singleDocData!.title!);
    titleController.text =singleDocData.title!;
    print('TITLE CONTROLLER '+titleController.text.toString());
    _controller =quill.QuillController(
      document: data!.content!.isEmpty ?  quill.Document() :quill.Document.fromDelta(quill.Delta.fromJson(data.content!)),
    selection: const TextSelection.collapsed(offset: 0)
    );
    setState(() {
      log('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
        });

  }else{
    print('NO STATUS');
  }
     _controller!.document.changes.listen((event) {
      if (event.item3 == quill.ChangeSource.LOCAL) {
        Map<String, dynamic> map = {
          'delta': event.item2,
          'room': widget.id,
        };
        socketRepositary.typing(map);
      }
    });
    
}
  @override
  Widget build(BuildContext context) {


    if(titleController.text =='Untitled Documents'){
return Scaffold(
  appBar: AppBar(
    title: Text(titleController.text),
  ),
  body:Loader()
);
    }
   else{ return  Scaffold(
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
              onSubmitted: (value)=> updateTitle(ref, value),
            )),
          ],),
        ),

        bottom: PreferredSize(child: Container(decoration: BoxDecoration(border: Border.all(color:kGrayColor,width: 0.1 )),), preferredSize:const Size.fromHeight(1)),
      ),
      body:Center(
        child: Column(
        children: [
         const SizedBox(height: 10,),
          quill.QuillToolbar.basic(controller: _controller!),
          Expanded(
        child: SizedBox(
          width: 750,
          child: Card(
            color: kWhiteColor,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: quill.QuillEditor.basic(
                controller: _controller!,
                readOnly: false, // true for view only mode
              ),
            ),
          ),
        ),
          )
        ],
      ),
      )
    
    );
   }
  }
}



// new


// import 'dart:async';


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:googledoc_clone/colors.dart';
// import 'package:googledoc_clone/components/loader.dart';
// import 'package:googledoc_clone/controller/documentController.dart';
// import 'package:googledoc_clone/repositary/socket_repositary.dart';
// import 'package:routemaster/routemaster.dart';

// import '../model/document_model.dart';

// class DocumentScreen extends ConsumerStatefulWidget {
//   final String id;
//   const DocumentScreen({
//     Key? key,
//     required this.id,
//   }) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _DocumentScreenState();
// }

// class _DocumentScreenState extends ConsumerState<DocumentScreen> {
//   TextEditingController titleController = TextEditingController(text: 'Untitled Document');
//   quill.QuillController? _controller;

//   SocketRepositary socketRepository = SocketRepositary();

//   @override
//   void initState() {
//     super.initState();
//     socketRepository.joinRoom(widget.id);
//     fetchDocumentData();

//     socketRepository.changeListener((data) {
//       _controller?.compose(
//         quill.Delta.fromJson(data['delta']),
//         _controller?.selection ?? const TextSelection.collapsed(offset: 0),
//         quill.ChangeSource.REMOTE,
//       );
//     });

//     // Timer.periodic(const Duration(seconds: 2), (timer) {
//     //   socketRepository.autoSave(<String, dynamic>{
//     //     'delta': _controller!.document.toDelta(),
//     //     'room': widget.id,
//     //   });
//     // });
//   }

//   void fetchDocumentData() async {
//     print('MOJSON');
//      var data=  ref.read(documentontrollerProvider.notifier).getDocumentById(widget.id, ref);
// print(data.sId);
//     // errorModel = await ref.read(documentRepositoryProvider).getDocumentById(
//     //       ref.read(userProvider)!.token,
//     //       widget.id,
//     //     );

//     // if (errorModel!.data != null) {
//     //   titleController.text = (errorModel!.data as DocumentModel).title;
//     //   _controller = quill.QuillController(
//     //     document: errorModel!.data.content.isEmpty
//     //         ? quill.Document()
//     //         : quill.Document.fromDelta(
//     //             quill.Delta.fromJson(errorModel!.data.content),
//     //           ),
//     //     selection: const TextSelection.collapsed(offset: 0),
//     //   );
//     //   setState(() {});
//     // }

//     // _controller!.document.changes.listen((event) {
//     //   if (event.item3 == quill.ChangeSource.LOCAL) {
//     //     Map<String, dynamic> map = {
//     //       'delta': event.item2,
//     //       'room': widget.id,
//     //     };
//     //     socketRepository.typing(map);
//     //   }
//     // });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     titleController.dispose();
//   }

//   void updateTitle(WidgetRef ref, String title) {
//     // ref.read(documentRepositoryProvider).updateTitle(
//     //       token: ref.read(userProvider)!.token,
//     //       id: widget.id,
//     //       title: title,
//     //     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     fetchDocumentData();
//     if (_controller == null) {
//       return  Scaffold(
        
//         appBar: AppBar(
//           title: Text(ref.watch(singledocument)!.title.toString()),
//         ),
//         body: Loader());
//     }
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kWhiteColor,
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 Clipboard.setData(ClipboardData(text: 'http://localhost:3000/#/document/${widget.id}')).then(
//                   (value) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text(
//                           'Link copied!',
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               icon: const Icon(
//                 Icons.lock,
//                 size: 16,
//               ),
//               label: const Text('Share'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//               ),
//             ),
//           ),
//         ],
//         title: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 9.0),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Routemaster.of(context).replace('/');
//                 },
//                 child: Image.asset(
//                   'assets/images/docs-logo.png',
//                   height: 40,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               SizedBox(
//                 width: 180,
//                 child: TextField(
//                   controller: titleController,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     contentPadding: EdgeInsets.only(left: 10),
//                   ),
//                   onSubmitted: (value) => updateTitle(ref, value),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey,
//                 width: 0.1,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             quill.QuillToolbar.basic(controller: _controller!),
//             const SizedBox(height: 10),
//             Expanded(
//               child: SizedBox(
//                 width: 750,
//                 child: Card(
//                   color: kWhiteColor,
//                   elevation: 5,
//                   child: Padding(
//                     padding: const EdgeInsets.all(30.0),
//                     child: quill.QuillEditor.basic(
//                       controller: _controller!,
//                       readOnly: false,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }