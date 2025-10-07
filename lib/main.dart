import 'package:flutter/material.dart';
import 'package:habit_tracker/Pages/home_page.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the static Isar instance
  await HabitDatabase.intialize();
  
  // Create a single HabitDatabase instance
  final habitDatabase = HabitDatabase();
  await habitDatabase.saveFirstLaunchDate();

  runApp(
    MultiProvider(
      providers: [
        // Use the SAME instance
        ChangeNotifierProvider.value(value: habitDatabase),
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


  

