
import 'package:flutter/material.dart';
import 'package:habit_tracker/componets/my_drawer.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Tracker'),
        
      ),
      drawer: MyDrawer(),
      
    );
  }
}