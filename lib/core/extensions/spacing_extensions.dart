import 'package:flutter/widgets.dart';

extension SpaceExtension on num {
  //hb for heightBox
  //wb for widthBox
  SizedBox get hb => SizedBox(height: toDouble());
  
 
  SizedBox get wb => SizedBox(width: toDouble());
}
