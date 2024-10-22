import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/widgets/custom_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Todo App'),
      ),
     body:  Column(
       children: [
         Padding(
           padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 100.0),
          
              
                child: Row(
                  children: [
                    CustomButton(onPressed: (){}, color: Colors.red, text: "Login", icon:Icon(Icons.login), height: 20,width: 200,),
                  SizedBox(width: 20.0,), 
                   CustomButton(onPressed: (){}, color: Colors.blue, text: "Google", icon:Icon(Icons.golf_course), height: 20,width: 480,)
                  
                 

                  ],
                )
              
            
         ),
       ],
     ),
     

    );
  }
}
