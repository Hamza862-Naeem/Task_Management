// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
 final Color color;
 final String text;
 final Icon? icon;
 final double width;
 final double height;
  const CustomButton({
    Key? key,
   
    required this.onPressed,
    required this.color,
    required this.text,
    this.icon, 
    required this.width, 
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton
    (onPressed: onPressed,
   style: ElevatedButton.styleFrom(
   
     backgroundColor: color,

     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5)
     )

   ),
     child: Text(text,
     style: TextStyle(fontSize: 14,
     color: Colors.white,
     fontWeight: FontWeight.bold,
     ),),

    );
  }
}
