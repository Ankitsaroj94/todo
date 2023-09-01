// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

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

                    if(!isLoginPage)
                      SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (value){
                        if(value!.isNotEmpty){
                          return 'Incorrect Username';
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
                        if(value!.isEmpty || !value.contains('@') ){
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
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('password'),
                      validator: (value){
                        if(value!.isNotEmpty){
                          return 'Incorrect Password';
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

                         onPressed: () { },

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
                 /* SizedBox(
                      height: 60,
                      width: 150,
                      child: ElevatedButton(onPressed: () { },

                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 25),

                          backgroundColor: Colors.blue,
                          minimumSize: Size(88, 36),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),

                        ),
                        child: isLoginPage? Text('Login')
                            :Text('Sign Up'),
                      ),
                    ) */

                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                      child: const Text('Enabled'),
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
