//Given a habit list of completion days
//is the habit completed today

import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(List<int> completedDaysMs) {
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  final todayMs = todayDate.millisecondsSinceEpoch;
  
  return completedDaysMs.contains(todayMs);
}


//Prepare HeatMap dataset
Map<DateTime, int> prepareHeatMapDataset(List<Habit> habits){
  Map<DateTime, int> dataset ={};

  for (var habit in habits){
    for (var dateMs in habit.completedDays){
       final date = DateTime.fromMillisecondsSinceEpoch(dateMs);

      //Normalize date to avoid time
      
      final normalizedDate = DateTime(date.year , date.month, date.day);

      //if the date already exists in the dataset, increment it's count
      if(dataset.containsKey(normalizedDate)){
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
     
      }
       else{
        //else intialize it with a count of 1;
        dataset[normalizedDate] =1;


    }
  }
  
}
return dataset;
}