
import 'package:flutter/material.dart';

List<Color>getProgressColor(double progress){
  if(progress<=25){
return [ Color.fromRGBO(39, 149, 20, 1),
      Color.fromRGBO(27, 142, 94, 1),
      Color.fromRGBO(23, 188, 34, 1),
      Color.fromRGBO(25, 144, 81, 1),
      Color.fromRGBO(48, 133, 91, 1),
      Color.fromRGBO(71, 142, 50, 1),
      Color.fromRGBO(44, 121, 75, 1),];
}else if(progress<=50){
  return[
     Color.fromRGBO(50, 88, 149, 1.0),
      Color.fromRGBO(47, 73, 142, 1.0),
      Color.fromRGBO(43, 59, 188, 1.0),
      Color.fromRGBO(45, 65, 144, 1.0),
      Color.fromRGBO(48, 74, 133, 1.0),
      Color.fromRGBO(50, 82, 142, 1.0),
      Color.fromRGBO(44, 63, 121, 1.0),
  ];

}else if(progress<=75){
  return[
     Colors.purple.shade700,
      Colors.purple.shade400,
  ];
}
else {
  return[
    Colors.blue, Colors.red
  ];
}

}
