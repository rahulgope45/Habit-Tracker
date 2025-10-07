import 'package:isar/isar.dart';

//run cmd to genrate file: dart run build_runner build
part 'habit.g.dart';

@Collection()
class Habit { 

  //habbit id
  Id id = Isar.autoIncrement;

  //habbit Name
  late String name;

  //Completed Days
  List<DateTime> completedDays = [
  //DateTime{year,month, day},
  //DateTime{2025,1, 1},
  //DateTime{2025,1, 2},
 ];
}


