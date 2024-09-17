import 'package:flutter/material.dart';

class NavigationService {
  var currentPageIndex = ValueNotifier<int>(0);
  final isLoadingNotifier = ValueNotifier<bool>(false);
  final brightness = ValueNotifier<Brightness>(Brightness.light);
  final color = ValueNotifier<Color>(Colors.blue);
  void setCurrentPageIndex(int index){
    currentPageIndex.value=index;
  }
  void setBrightness(bool isLight){
    if(isLight){
      brightness.value = Brightness.light;
    } else {
      brightness.value = Brightness.dark;
    }
  }
  void setColor(Color selectedColor){
    color.value = selectedColor;
  }
}