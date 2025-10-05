import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'light_mode.dart';


class ThemeProvider  extends ChangeNotifier{

     //Intially Light Mode
     ThemeData _themeData = lightMode;

     //Getting theme data
     ThemeData get themedata => _themeData;

     //Is current theme is dark mode
     bool get isDarkMode => _themeData == darkMode;

     //set theme
     set  themedata(ThemeData themedata){
      _themeData = themedata;
      notifyListeners();
     }

     //toggle theme
     void toggleTheme(){
      if (_themeData == lightMode){
        themedata = darkMode;
      }
      else{
       themedata = lightMode;
      }
     }

     void refreshTheme(){
      _themeData = _themeData == lightMode ? lightMode : darkMode;
      notifyListeners();
     }


}