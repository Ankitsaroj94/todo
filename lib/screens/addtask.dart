import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key); // Corrected the key assignment

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser; // Changed to User and removed the parentheses

    if (user != null) {
      String uid = user.uid;
      var time = DateTime.now();
      await FirebaseFirestore.instance // Changed to FirebaseFirestore
          .collection('tasks')
          .doc(uid) // Changed to doc()
          .collection('mytask')
          .doc(time.toString()) // Changed to doc()
          .set({ // Changed setData to set
        'title': titlecontroller.text,
        'description': descriptioncontroller.text,
        'time': time.toString(),
        'timestamp':time,
      });

      Fluttertoast.showToast(msg: "Task added successfully!");

      // Clearing the TextFields after successfully adding the task
      titlecontroller.clear();
      descriptioncontroller.clear();
    } else {
      Fluttertoast.showToast(msg: "No user is currently signed in.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New-Task')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  labelText: 'Enter Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: TextField(
                controller: descriptioncontroller,
                decoration: InputDecoration(
                  labelText: 'Enter Description',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.green.shade50;
                      return Theme.of(context).primaryColor;
                    },
                  ),
                ),
                child: Text(
                  'Add Task',
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
                onPressed: addtasktofirebase, // Calling the function when the button is pressed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
