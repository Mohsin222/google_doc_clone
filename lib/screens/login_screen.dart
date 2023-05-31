import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/colors.dart';
import 'package:googledoc_clone/repositary/auth_repositary.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});



  void signIn(WidgetRef ref){
    ref.read(authRepositaryProvider);

  }

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
  
    return Center(

      child: ElevatedButton.icon(onPressed: ()=> signIn(ref), icon: Image.asset('./assets/images/g-logo-2.png',height: 20,),
      
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150,50),
        backgroundColor: kWhiteColor,
      ),
      
       label:const Text('Sign in with Google',style: TextStyle(
color: kBlackColor

       ),)),
    );
  }
}