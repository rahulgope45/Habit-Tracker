
import 'package:flutter/material.dart';
import 'package:habit_tracker/componets/my_drawer.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/util/habit_util.dart';
import 'package:provider/provider.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  void initState(){
    //read existing habits on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();

    super.initState();
  }




//Read existing habits on  app startup 

  final TextEditingController textControler = TextEditingController();

void createNewHabit(){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: TextField(
        controller: textControler,
        decoration: const InputDecoration(
          hintText: "Create a New Habit" 
        ),
      ),
      actions: [
        //saveButton
        MaterialButton(
          onPressed: (){
        //get the new habit name
        String newHabitName = textControler.text;

        //save to db
        context.read<HabitDatabase>().addHabits(newHabitName);

        //pop box
        Navigator.pop(context);

        //clear controller
        textControler.clear();

          },
        child: const Text('save'),
          ),
        
        //cancel button
        MaterialButton(
          onPressed: () {
            //pop box
            Navigator.pop(context);

            //clear controler
            textControler.clear();
          },
          child: const Text('Cancel'),
          )

        

      ],
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

    body: _buildHabitList(),

      
    );
  }

  Widget _buildHabitList(){
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();

    List<Habit> currentHabits =habitDatabase.currentHabits;

    //current habits
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index){
        //get each individual habit
        final habit = currentHabits[index];

        //check if the habit completed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        return ListTile(
          title: Text(habit.name),
        );
      },);
  }
}