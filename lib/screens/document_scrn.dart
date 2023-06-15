import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class DocumentScreen extends StatelessWidget {
  final String id;
  const DocumentScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
      child: Text(id),
    ),
    );
  }
}