import 'package:flutter/material.dart';
import 'package:todo/screens/addtask.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(child: Text('To-Do')),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white54,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.amber,),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.push(
              context,MaterialPageRoute(builder: (BuildContext context) =>AddTask()));
        },
      ),
    );
  }
}
