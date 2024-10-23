// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
 final Color color;
 final String text;
 final Icon icon;
 final double width;
 final double height;
  const CustomButton({
    super.key,
   
    required this.onPressed,
    required this.color,
    required this.text,
   required this.icon, 
    required this.width, 
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton
      (onPressed: onPressed,
      
      
         style: ElevatedButton.styleFrom(
         
       backgroundColor: color,
       
       
      
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
       )
      
         ),
         
       child: Row(
         children: [
          icon,
          const SizedBox(width: 8,),
           Text(text,
           style: TextStyle(fontSize: 14,
           color: Colors.white,
           fontWeight: FontWeight.bold,
           ),),
         ],
       ),
      
      ),
    );
  }
}
