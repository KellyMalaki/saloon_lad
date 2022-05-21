import 'package:flutter/material.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/saloon_auth.dart';
import '../../shared/loading.dart';
import '../../shared/widgets.dart';

class SignUp extends StatefulWidget {
  final VoidCallback changeType;
  final void Function(SaloonAccount?, SaloonUser?) loginFunction;
  final Function toggleView;
  const SignUp({required this.toggleView, Key? key, required this.changeType, required this.loginFunction}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SaloonAuthService _auth = SaloonAuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password1 = "";
  String password2 = "";
  String name = "";
  String phone = "";
  String location = "";

  String error = "";
  bool couldntCreateAccount = false;
  bool loading = false;
  bool showPassword = false;
  TextEditingController passwordController = TextEditingController();

  Widget showError(){
    if(!couldntCreateAccount){
      return SizedBox(height: 20.0);
    }
    print("We got a problem");
    return Padding(padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(error, style: TextStyle(color: Colors.red),),
    );
  }
  void switchFlipped(bool theSwitchState){
    if(theSwitchState){
      setState(() {
        showPassword = true;
      });
    }else{
      setState(() {
        showPassword = false;
      });
    }
  }
  Widget passwordInputState(){
    if(showPassword){
      return TextFormField(
        controller: passwordController,
        decoration: saloonEditTextDecoration(hint: "Enter Password"),
        obscureText: false,
        validator: (data) {
          if(data != null){
            if(data.length > 8){
              return null;
            }
          }
          return "Password should be at least 8 char";
        },
        onChanged: (data){
          setState(() {
            password1 = data;
          });
        },
      );
    }else{
      return Column(
        children: [
          TextFormField(
            controller: passwordController,
            decoration: saloonEditTextDecoration(hint: "Enter Password"),
            obscureText: true,
            validator: (data) {
              if(data != null){
                if(data.length > 8){
                  return null;
                }
              }
              return "Password should be at least 8 char";
            },
            onChanged: (data){
              setState(() {
                password1 = data;
              });
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            decoration: saloonEditTextDecoration(hint: "Confirm Password"),
            obscureText: true,
            validator: (data) {
              if(data != null){
                if(data.length > 8){
                  return null;
                }
              }
              return "Password should be at least 8 char";
            },
            onChanged: (data){
              setState(() {
                password2 = data;
              });
            },
          ),
        ],
      );
    }
  }
  void createAccount() async{
    setState(() {
      loading =true;
    });
    SaloonAccount? result = await _auth.registerWithEmailAndPassword(email, name, phone, location, password1);
    if(result == null){
      setState(() {
        loading =false;
        couldntCreateAccount = true;
        error = "An error occured. Check if your email is the right fomat";
      });
    }else{
      //Sign in successful
      widget.loginFunction(result, null);
    }

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
        title: const Text('Register', style: TextStyle(color: Colors.white),),
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
              const Padding(child: Text("Saloon Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),),padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: saloonEditTextDecoration(hint: "Email"),
                        validator: (data) {
                          if(data != null){
                            if(data.length > 5){
                              return null;
                            }
                          }
                          return "Enter a valid email address";
                        },
                        onChanged: (data){
                          setState(() {
                            email = data;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        decoration: saloonEditTextDecoration(hint: "Saloon Name"),
                        validator: (data) {
                          if(data != null){
                            if(data.length > 2){
                              if(RegExp(r"^[a-zA-Z0-9 ]+$").hasMatch(data)){
                                return null;
                              }else{
                                return "Name shouldn't contain special characters";
                              }
                              return null;
                            }
                          }
                          return "Name should be at least 3 characters";
                        },
                        onChanged: (data){
                          setState(() {
                            name = data;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        decoration: saloonEditTextDecoration(hint: "Business Phone Number"),
                        keyboardType: TextInputType.phone,
                        validator: (data) {
                          if(data != null){
                            if(data.length > 9){
                              return null;
                            }
                          }
                          return "Enter a valid phone number";
                        },
                        onChanged: (data){
                          setState(() {
                            phone = data;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        decoration: saloonEditTextDecoration(hint: "Saloon's Location"),
                        validator: (data) {
                          if(data != null){
                            if(data.length > 2){
                              return null;
                            }
                          }
                          return "Location should be at least 3 characters";
                        },
                        onChanged: (data){
                          setState(() {
                            location = data;
                          });
                        },
                      ),
                      const SizedBox(height: 30.0,),
                      Row(children: [
                        Text("Show Password", style: TextStyle(fontSize: 15.0),),
                        Switch(value: showPassword,
                            onChanged: switchFlipped,
                          activeColor: Colors.blue[800],
                          activeTrackColor: Colors.blue[300],
                        ),
                      ]),
                      passwordInputState(),
                      const SizedBox(height: 20.0),
                      TextButton(
                          style: TextButton.styleFrom(backgroundColor: Colors.blue[800]),
                          onPressed: () async{
                            if(_formKey.currentState != null){
                              if(_formKey.currentState!.validate()){
                                if(showPassword){
                                  createAccount();
                                }else{
                                  if(password1 == password2){
                                    createAccount();
                                  }else{
                                    //Password does not match
                                    setState(() {
                                      loading =false;
                                      couldntCreateAccount = true;
                                      error = "Inserted password does not match on both fields.";
                                    });
                                  }
                                }

                              }
                            }else{
                              setState(() {
                                loading =false;
                                couldntCreateAccount = true;
                                error = "Something went wrong somewhere, try again";
                              });
                            }
                          }, child: const Padding(padding: EdgeInsets.all(5.0),
                          child: Text("Sign Up", style: TextStyle(color: Colors.white),))),
                      showError(),
                      TextButton(onPressed: () {
                        widget.toggleView();
                      }, child: const Text("Already have an account?", style: TextStyle(fontSize: 16.0, decoration: TextDecoration.underline, color: Colors.purple),))
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}