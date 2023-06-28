import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:convert';

class DOWN extends StatefulWidget {
  const DOWN({super.key});

  @override
  State<DOWN> createState() => _DOWNState();
}

class _DOWNState extends State<DOWN> {

Future<void> _createPDF() async {
    //Create a PDF document.

    
    PdfDocument document = PdfDocument();
    //Add a page and draw text
    document.pages.add().graphics.drawString(
        'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(20, 60, 150, 30));    
    //Save the document
    List<int> bytes = await document.save();

  //   AnchorElement(
  //   href:
  //       "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
  // ..setAttribute("download", "output.pdf")
  // ..click();
    //Dispose the document
    document.dispose();
 }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text('SYNC'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            child: Text(
              'Generate PDF',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.blue)),
            onPressed: _createPDF,
          )
        ],
      ),
    ),
  );
  }
}