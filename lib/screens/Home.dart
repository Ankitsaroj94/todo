// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/screens/addtask.dart';
import 'package:todo/screens/description.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  String uid = '';
  String? username;

  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      final usernameDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        uid = user.uid;
        username = usernameDocument.get('username') as String?;
      });
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _showUsername() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Username: $username'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('To-Do')),
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _showUsername,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.lime[50],
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('tasks')
              .doc(uid)
              .collection('mytask')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                 var time=(docs[index]['timestamp']as Timestamp)
                     .toDate();

                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)
                          =>Description(
                              title:docs[index]['title'],
                              description: docs[index]['description'],
                          )));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 7),
                      decoration: BoxDecoration(

                        color: Colors.indigo[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 90,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                  child: Text(docs[index]['title'],
                                  style: GoogleFonts.roboto(fontSize: 25),)),
                            SizedBox(height: 5,),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(DateFormat.yMd().add_jm()
                                .format(time))
                            ),

                            ],
                          ),
                          Container(child: IconButton(
                            icon: Icon(
                              Icons.delete,color: Colors.red[300],),
                            onPressed: ()async{
                          await FirebaseFirestore
                              .instance
                              .collection('tasks')
                              .doc(uid)
                              .collection('mytask')
                              .doc(docs[index]['time'])
                              .delete();
                            },
                          ),)
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (BuildContext context) => AddTask()));
        },
        child: Icon(Icons.add, color: Colors.amber,),
      ),
    );
  }
}
