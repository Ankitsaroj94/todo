// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);


  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //---------------------------------------------

  final _formkey=GlobalKey<FormState>();
  var _email='';
  var _password='';
  var _username='';
  bool isLoginPage=false;

  //-----------------------------------------------

  startauthentication()  {
   bool validity = _formkey.currentState?.validate() ??false;
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState?.save();
      submitform(_email,_password,_username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      if (isLoginPage) {
        authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
        String? uid = authResult.user?.uid;

        if (uid != null) { // Check if uid is not null
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'username': username,
            'email': email,
          });
        } else {
          // Handle the case when uid is null (this should ideally never happen if createUserWithEmailAndPassword was successful)
          print("Error: UID is null");
          // You can also show a message to the user or log this incident for debugging.
        }
      }
    } catch (err) {
      print(err);
    }
  }

  //-----------------------------------------------
   @override
  Widget build(BuildContext context) {
    return Container(
      //------- to set height and width----

      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      
      child: ListView(
        children: [
          Container(
            //--- padding--

            padding: EdgeInsets.only(left: 10,right: 10,top: 30,),
            child: Form(
              key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //-----------username------


                      SizedBox(height: 10),
                    if(!isLoginPage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (value){
                        if(value!.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _username = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)

                          ),

                          labelText: "Enter Username",
                          labelStyle: GoogleFonts.roboto()
                      ),
                    ),

//------ email---------
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      validator: (value){
                        if(value!.isEmpty || !value.contains('@')) {
                          return 'Incorrect Email';
                        }
                        return null;
                      },
                  onSaved: (value){
                  _email = value!;
                  },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)

                      ),

                        labelText: "Enter Email",
                        labelStyle: GoogleFonts.roboto()
                    ),
                    ),


                  //--------password-----
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('password'),
                      validator: (value){
                        if(value!.isEmpty || value.length < 4) {
                          return 'Password must be at least 4 characters long';
                        }
                        return null;
                      },
                      onSaved: (value){
                        _password = value!;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)

                          ),

                          labelText: "Enter Password",
                          labelStyle: GoogleFonts.roboto()
                      ),

                    ),
                    SizedBox(height: 10),
                    SizedBox(

                      height: 70,
                      width: 150,
                       child: ElevatedButton(

                         onPressed: () {
                           startauthentication();
                         },

                         style: ElevatedButton.styleFrom(
                           textStyle: TextStyle(fontSize: 25),
                            foregroundColor: Colors.amberAccent,
                            backgroundColor: Colors.blue,
                            minimumSize: Size(88, 36),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),

                          ),
                         child: isLoginPage? Text('Login')
                             :Text('Sign Up'),

                        )
                    ),

                    SizedBox(height: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          isLoginPage=!isLoginPage;
                        });
                      },
                      child: isLoginPage?Text('Not a member?'): Text('Already a member?'),
                    ),
                  ],
                ),

            )
          )

        ],
      )
    );
  }
}
