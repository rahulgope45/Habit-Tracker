import 'package:flutter/foundation.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier{
   static late Isar isar;

   //setup

   //Intialize Database

   static Future<void> intialize() async{
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
         [HabitSchema, AppSettingsSchema],
         directory: dir.path,
         );
    
   }

   //save first date of the app
   Future<void> saveFirstLaunchDate() async {
      final existingSettings = await isar.appSettings.where().findFirst(); 
      if (existingSettings == null){
         final settings = AppSettings()..firsLaunchDate = DateTime.now();
         await isar.writeTxn(() => isar.appSettings.put(settings));
      }
   }

   //Get first date of app startup (for heatmap)
   Future<DateTime?> getFirstLaunchDate() async{
      final settings = await isar.appSettings.where().findFirst();
      return settings?.firsLaunchDate;
   }


   //Crud operations


   //List of habits
   final List<Habit> currentHabits = [];

   //Create add a new habbit 
   Future<void> addHabits(String habitName) async {
      //create a new habit
      final newHabit = Habit()..name = habitName;

      //save to db
      await isar.writeTxn(() => isar.habits.put(newHabit));

      //re-read from db
      readHabits();



   }

   //READ -read saved habits from db
   Future<void> readHabits() async {
      //fetch all habits
      List<Habit> fetchedHabits = await isar.habits.where().findAll();


      //give to current habits
      currentHabits.clear();
      currentHabits.addAll(fetchedHabits);

      //update UI
      notifyListeners();


   }

//UPDATE -check habit on and off
Future<void> updateHabitCompletion(int id, bool isCompleted) async {
  final habit = await isar.habits.get(id);

  if (habit != null) {
    await isar.writeTxn(() async {
      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);
      final todayMs = todayDate.millisecondsSinceEpoch;

      // Create a MUTABLE copy of the list (THIS IS THE FIX!)
      List<int> updatedDays = List.from(habit.completedDays);
      
      // Check if already completed today
      final isAlreadyCompleted = updatedDays.contains(todayMs);

      if (isCompleted && !isAlreadyCompleted) {
        updatedDays.add(todayMs);  // Add to the mutable copy
      } else if (!isCompleted && isAlreadyCompleted) {
        updatedDays.remove(todayMs);  // Remove from the mutable copy
      }

      // Assign the new list back to the habit
      habit.completedDays = updatedDays;
      await isar.habits.put(habit);
    });

    // refresh list & UI
    await readHabits();
  }
}
   //UPDATE -edit habit name
   Future<void> updateHabitName(int id, String newName)async{
      //find the specific habit
      final habit = await isar.habits.get(id);

      //update name
      if(habit != null){
      await isar.writeTxn(() async{
        habit.name = newName;
        //save the  updated habit back to the db
        await isar.habits.put(habit);
      });
      }
      await readHabits();
   }

   //DELETE - delete habits
   Future<void> deleteHabit(int id) async{
      //perform the delete
      await isar.writeTxn(() async{
       await isar.habits.delete(id); 
      });
     await readHabits(); 
   }





   





}