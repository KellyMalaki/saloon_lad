import 'package:flutter/material.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/saloon_auth.dart';
import 'package:saloon_lad/shared/loading.dart';
import 'package:saloon_lad/shared/widgets.dart';

class SignIn extends StatefulWidget {
  final VoidCallback changeType;
  final void Function(SaloonAccount?, SaloonUser?) loginFunction;
  final Function toggleView;
  const SignIn({Key? key, required this.toggleView, required this.changeType, required this.loginFunction}) : super(key: key);

  @override
  State<SignIn> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final SaloonAuthService _auth = SaloonAuthService();
  final _formKey = GlobalKey<FormState>();
  final passwordHeight = GlobalKey();
  FocusNode passwordFocusNode = FocusNode();
  String username = "";
  String password = "";
  bool couldntLogIn = false;
  bool loading = false;
  bool passwordObscureState = true;
  String error = "";
  IconData visibilityIcon = Icons.visibility_off;
  Color? passwordBorder = Colors.white;


  @override
  void initState() {
    passwordFocusNode.addListener(() {
      if(passwordFocusNode.hasFocus){
        setState(() {
          passwordBorder = Colors.blue[800];
        });
      }else{
        setState(() {
          passwordBorder = Colors.white;
        });
      }
    });
  }

  Widget showError(){
    if(!couldntLogIn){
      return SizedBox(height: 20.0);
    }
    return Padding(padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(error, style: TextStyle(color: Colors.red),),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future openDialog() =>  showDialog(context: context, builder: (context) => AlertDialog(title: Text("Switch to User Account"), content: Text("Select Switch if you would like to sign in to a user account."),
        actions: [TextButton(onPressed: () {
          Navigator.of(context).pop();
          widget.changeType();
        }, child: const Text("Switch")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Cancel"))
        ]
    ));
    return loading? const Loading(firstScreen: false): Scaffold(
      appBar: AppBar(
        title: const Text('Sign in', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(onPressed: openDialog, icon: const Icon(Icons.manage_accounts))
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(child: const Text("Saloon Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      decoration: saloonEditTextDecoration(hint: "Enter Saloon Name or Email"),
                      validator: (data) {
                        if(data != null){
                          if(data.length > 2){
                            return null;
                          }
                        }
                        return "Enter a valid name or email address";
                      },
                      onChanged: (data){
                        setState(() {
                          username = data;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0,),
                    Container(padding: const EdgeInsets.all(2.0), child: Container(color: Colors.white,
                        child: Padding(padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                            child:Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: TextFormField(
                                    focusNode: passwordFocusNode,
                                    decoration: const InputDecoration( border: InputBorder.none,hintText: "Password",),
                                    validator: (data) {
                                      if(data != null){
                                        if(data.length > 8){
                                          return null;
                                        }
                                      }
                                      return "Password should be at least 8 char";
                                    },
                                    obscureText: passwordObscureState,
                                    onChanged: (data){
                                      setState(() {
                                        password = data;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      onPressed: (){
                                        if(passwordObscureState){
                                          setState(() {
                                            visibilityIcon = Icons.visibility;
                                            passwordObscureState = false;
                                          });
                                        }else{
                                          setState(() {
                                            visibilityIcon = Icons.visibility_off;
                                            passwordObscureState = true;
                                          });
                                        }
                                      }, icon: Icon(visibilityIcon, color: Colors.blue[800]),
                                    )
                                )
                              ],
                            ))
                    ), color: passwordBorder),
                    const SizedBox(height: 20.0,),
                    TextButton(
                        style: TextButton.styleFrom(backgroundColor: Colors.blue[800]),
                        onPressed: () async{
                          bool usedEmail = true;
                          if(_formKey.currentState != null){
                            if(_formKey.currentState!.validate()){
                              if(!username.contains("@")){
                                usedEmail = false;
                              }
                              setState(() {
                                loading =true;
                              });
                              if(!usedEmail){
                                //First check for the user's email. Do this later
                              }
                              SaloonAccount? result = await _auth.signInWithEmailAndPassword(username, password);
                              if(result == null){
                                setState(() {
                                  loading =false;
                                  couldntLogIn = true;
                                  if(usedEmail){
                                    error = "Incorrect Email or Password. Please check try again";
                                  }else{
                                    error = "Incorrect Name or Password. Please check try again";
                                  }
                                });
                              }else{
                                //Log in success
                                widget.loginFunction(result, null);
                              }
                            }
                          }else{
                            setState(() {
                              loading =false;
                              couldntLogIn = true;
                              error = "Incorrect Name/Email or Password. Please check try again";
                            });
                          }
                        }, child: const Padding(padding: EdgeInsets.all(5.0),
                        child: Text("Sign In", style: TextStyle(color: Colors.white),))),
                    showError(),
                    TextButton(onPressed: () {
                      widget.toggleView();
                    }, child: const Text("Don't have an account yet?", style: TextStyle(fontSize: 16.0, decoration: TextDecoration.underline, color: Colors.purple),))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
