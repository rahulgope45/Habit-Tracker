import 'package:isar/isar.dart';

//run cmd to generate file: dart run build_runner build
part 'habit.g.dart';

@Collection()
class Habit { 

  //habit id
  Id id = Isar.autoIncrement;

  //habit Name
  late String name;

  //Completed Days (stored as milliseconds since epoch)
  List<int> completedDays = [];
}


