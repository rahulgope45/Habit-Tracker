
import 'package:flutter/material.dart';
import 'package:habit_tracker/componets/my_drawer.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  final TextEditingController textControler = TextEditingController();

void createNewHabit(){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: TextField(
        controller: textControler,
      ),
    )
    );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Tracker'),
        
      ),
      drawer: const MyDrawer(),
      //floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add),
        
        ),

      
    );
  }
}