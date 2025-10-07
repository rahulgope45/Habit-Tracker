import 'package:flutter/material.dart';
import 'package:habit_tracker/Pages/home_page.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:provider/provider.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  //intialize Database
  await HabitDatabase.intialize();
  await HabitDatabase().saveFirstLaunchDate();



  runApp(
    MultiProvider(providers: [
      //habit provider
      ChangeNotifierProvider(create: (context) => HabitDatabase()),

      //theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),

    ],
    child: const MyApp(),
    
    )
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


  

