import 'package:flutter/material.dart';
import 'package:habit_tracker/Pages/home_page.dart';
import 'package:habit_tracker/theme/theme_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) { 
    return Builder(
      builder: (context){
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeProvider.themedata,
          home: HomePage(),
         );
        
       },
      );
  }
}


  

