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
         final settings = AppSettings()..firstLaunchDate = DateTime.now();
         await isar.writeTxn(() => isar.appSettings.put(settings));
      }
   }

   //Get first date of app startup (for heatmap)
   Future<DateTime?> getFirstLaunchDate() async{
      final settings = await isar.appSettings.where().findFirst();
      return settings?.firstLaunchDate;
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
   Future<void> updateHabitCompletion(int id, bool isCompleted) async{
      //find the specific habit
      final habit = await isar.habits.get(id);

      //update completion status
      if(habit != null){
         await isar.writeTxn(() async {
            //If habit is completed -> add the current date to the completedDays List
            if (isCompleted && !habit.completedDays.contains(DateTime.now())){
               final today = DateTime.now();

               //add the current date if it's not already in the list
               habit.completedDays.add(
                 DateTime(
                  today.year,
                  today.month,
                  today.day,
                 ),
               );
            }
            //if habit is not completed -> remove the current date from the list
            else{
               //remove the current date if the habit is marked as not complete
               habit.completedDays.retainWhere(
               (date) =>
                    date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day,
               );
            }
            //Save the updated habits back to the db
            await isar.habits.put(habit);
         });
      }
      readHabits();
   }

   //UPDATE -edit habit name



   





}