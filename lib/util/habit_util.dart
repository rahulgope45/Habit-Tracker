//Given a habit list of completion days
//is the habit completed today

bool isHabitCompletedToday(List<int> completedDaysMs) {
  final today = DateTime.now();
  final todayDate = DateTime(today.year, today.month, today.day);
  final todayMs = todayDate.millisecondsSinceEpoch;
  
  return completedDaysMs.contains(todayMs);
}