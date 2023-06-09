import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/controller/auth_controller.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final user = ref.watch(userProvider);
    return  Scaffold(
      appBar: AppBar(title: Text('a'),),
      
      body: Center(
        child: Column(children: [
              if (user?.email != null)
              Text(user!.token.toString()),
        ]),
      ),
    );
  }
}