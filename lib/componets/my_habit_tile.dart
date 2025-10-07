import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  const MyHabitTile({
    super.key,
    required this.text,
    required this.isCompleted,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
    
    child: Slidable(
      endActionPane: ActionPane
      (motion: const StretchMotion(),
       children: [
        //edit option
        SlidableAction(
          onPressed: editHabit,
          backgroundColor: Colors.grey.shade800,
          icon: Icons.settings,
          borderRadius: BorderRadius.circular(8),

          ),

        // delete option
        SlidableAction(
          onPressed: deleteHabit,
          backgroundColor: Colors.red.shade600,
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(8),

          )
       ] 
       ),

      child: Container(
        decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        
        child: ListTile(
          title: Text(text, style: TextStyle(color: isCompleted ? Colors.white : Theme.of(context).colorScheme.primary),),
          leading: Checkbox(
            value: isCompleted,
            onChanged: onChanged,
            activeColor: Colors.white,
            checkColor: Colors.black,
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ), 
      ),
    )
    );
  }
}
