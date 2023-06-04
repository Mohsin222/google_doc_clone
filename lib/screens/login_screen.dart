import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googledoc_clone/colors.dart';
import 'package:googledoc_clone/controller/auth_controller.dart';
import 'package:googledoc_clone/repositary/auth_repositary.dart';

class LoginScreen extends ConsumerWidget {
   LoginScreen({super.key});



 TextEditingController _emailController = TextEditingController(text: "bb@gmail.com");

 TextEditingController _passwordController =TextEditingController(text: '12345');


  @override
  Widget build(BuildContext context,  WidgetRef ref) {
  
    return Scaffold(
      body: Container(
    
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // color: Colors.red,
            
                child: Stack(
    children: [
      Container(
          decoration: BoxDecoration(
                  image: DecorationImage( image: NetworkImage('https://images.unsplash.com/photo-1500817487388-039e623edc21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTI2fHxhbmltYXRlZCUyMGJhY2tncm91bmR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'),fit: BoxFit.cover),
                 ),
      ),
      Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(172, 72, 123, 160),
            Color.fromARGB(122, 68, 46, 105),
            
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      )
    ],
                ),
              ),
            ),
              Expanded(
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                                                   decoration: InputDecoration(hintText: 'Email'),
                        ),
                      ),
                  const    SizedBox(height: 10,),
                        Container(
                             margin: EdgeInsets.all(10),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Password'),
                        ),
                      ),
                    const  SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){

                        final authController =
                    ref.watch(authControllerProvider.notifier);
                authController.loginUser(
                    context,
                    _emailController.text.trim().toString(),
                    _passwordController.text.trim().toString());

                      }, 
                      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150,50),
     backgroundColor: Colors.purple
      ),
                      child: Text("LOGIN"))
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}


class GooglgeButton extends StatelessWidget {
  const GooglgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(onPressed: (){
          // final authController =
          //           ref.watch(authControllerProvider.notifier);
          //       authController.loginUser(
          //           context,
          //           _emailController.text.trim().toString(),
          //           _passwordController.text.trim().toString());

      }, icon: Image.asset('./assets/images/g-logo-2.png',height: 20,),
      
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150,50),
        backgroundColor: kWhiteColor,
      ),
      
       label:const Text('Sign in with Google',style: TextStyle(
color: kBlackColor

       ),));
  }
}