import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/controller/auth_controller.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});


    void signOut(WidgetRef ref) async{
   await ref.read(authControllerProvider.notifier).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final user = ref.watch(userProvider);
    return  Scaffold(
      appBar: AppBar(title: Text('a'),
      
      actions: [
        IconButton(onPressed: (){
          signOut(ref);
        }, icon:const Icon(Icons.logout_outlined))
      ],),
      
      body: Center(
        child: Column(children: [
              if (user?.email != null)
              Text(user!.token.toString()),
        ]),
      ),
    );
  }
}