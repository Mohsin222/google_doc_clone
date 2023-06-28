import 'dart:convert';

import 'dart:io' as File1;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/controller/documentController.dart';
import 'package:googledoc_clone/screens/auth/down.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:googledoc_clone/colors.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
class CreateDocument extends ConsumerStatefulWidget {
  const CreateDocument({super.key});

  @override
  ConsumerState<CreateDocument> createState() => _CreateDocumentState();
}

class _CreateDocumentState extends ConsumerState<CreateDocument> {
  List<QuillController> quillData=[];
quill.QuillController _controller = quill.QuillController.basic();
var d='';

var newContent=[
                {
                    "insert": "fasafaddddddddddddddafffffffffffffff\nafffffffffffffffff"
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "header": 1
                    }
                },
                {
                    "insert": "addddddddddddd"
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "list": "ordered"
                    }
                },
                {
                    "insert": "affffffffffffff"
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "list": "ordered"
                    }
                },
                {
                    "insert": "affffffffffffffff"
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "list": "ordered"
                    }
                },
                {
                    "insert": "faaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                    "attributes": {
                        "italic": true
                    }
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "list": "ordered"
                    }
                },
                {
                    "insert": "afffffffffffffffff"
                },
                {
                    "insert": "afffffffffffffffffffffffffff",
                    "attributes": {
                        "color": "#e57373"
                    }
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "list": "ordered"
                    }
                },
                {
                    "insert": "affffffffffffffffffff"
                },
                {
                    "insert": "faaaaaaaaaaaaaaaaaaaaafaaaaaaaaaaaaaaaaaaaaaaaa",
                    "attributes": {
                        "size": "large"
                    }
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "header": 3
                    }
                },
                {
                    "insert": "afffffffffffffffffffaffffffffffffffff"
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "list": "bullet"
                    }
                },
                {
                    "insert": "affffffffffffffffffffff"
                },
                {
                    "insert": "\n",
                    "attributes": {
                        "list": "bullet"
                    }
                }
            ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        // title: Text('CreateDocumentPage'),
        actions: [

        IconButton(onPressed: ()async{

          // print(jsonEncode(_controller.document.toDelta().toJson()));

//           final image = pw.MemoryImage(
//  File1.File('test.webp').readAsBytesSync(),
// );
//  final pdf = pw.Document();
//  pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text('aaaaaaaaaaa'),
//       ),
//     ),
//   );
//   final file = File1.File('example.pdf');
  // await file.writeAsBytes(await pdf.save());
//  List<int> bytes = await   file.writeAsBytes(await pdf.save());



var data = _controller.document.toDelta().toJson();


 ref.read(documentontrollerProvider.notifier).createDocuments(data);
print(data.runtimeType);

// quillData.add(_controller);

 d =_controller.document.toPlainText();
 var dddd=_controller.document.querySegmentLeafNode(0);
// print(dddd);
var data1 =jsonEncode( _controller.document.toDelta().toJson());
// List<String> stringList = data.split(',');
// a.add(data1);
// print(stringList);
setState(() {
  
});


   PdfDocument document = PdfDocument();
    //Add a page and draw text
    document.pages.add().graphics.drawString(
       data.toString(), PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(20, 60, 150, 30));    
     List<int> bytes = await document.save();
  //   AnchorElement(
  //   href:
  //       "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
  // ..setAttribute("download", "output.pdf")
  // ..click();
//  Navigator.push(context, MaterialPageRoute(builder: (context)=> DOWN()));
        }, icon: Icon(Icons.save)),

        IconButton(onPressed: (){
          
        }, icon: Icon(Icons.add_a_photo_outlined)),
        SizedBox(width: 39,),
      ]),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
                height: MediaQuery.of(context).size.height,
            child: Column(
            children: [
             const SizedBox(height: 10,),
              quill.QuillToolbar.basic(controller: _controller),
              Expanded(
            child: SizedBox(
              width: 750,
              height: 200,
              child: Card(
                color: kWhiteColor,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: quill.QuillEditor.basic(
                    controller: _controller,
                    readOnly: false, // true for view only mode
                  ),
                ),
              ),
            ),
              ),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: quillData.length,
              itemBuilder: (context,index){
return Card(
            elevation: 10,
            child: Container(color: Colors.red,
            height: 400,
            width: 200,
            child:QuillEditor(
              controller:_controller,
              readOnly: true,
              scrollController: ScrollController(),
              focusNode: FocusNode(),
              autoFocus: false, expands: true, padding: EdgeInsets.all(9), scrollable: true,
            ),),
          );

            }),
          )
              
            ],
                ),
          ),
        ),
      ),
    );
  }
}


