import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New-Task')),
      body: Container(padding: EdgeInsets.all(10),
        child: Column(
children: [
  Container(
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Enter Title',border: OutlineInputBorder()
      ),),),
SizedBox(height: 10),
  Container(
    child: TextField(
      decoration: InputDecoration(
          labelText: 'Enter Description',border: OutlineInputBorder()
      ),),
  ),
  Container(
    width: double.infinity,
    child:

    ElevatedButton(
      style: ButtonStyle(
        backgroundColor:MaterialStateProperty.resolveWith<Color>( (Set<MaterialState>states){
          if(states.contains(MaterialState.pressed))
            ///color when i am clicking the button
            return Colors.green.shade50;
          ///color when i am not clicking the button
          return Theme.of(context).primaryColor;
        })
      ),
        child:Text('Add Task',
        style: GoogleFonts.roboto(fontSize: 18),
        ),
        onPressed: (){},)
  ),


],
        ),   ),
    );
  }
}
