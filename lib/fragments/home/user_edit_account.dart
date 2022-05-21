import 'package:flutter/material.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/user_database.dart';
import 'package:saloon_lad/shared/widgets.dart';

class UserEditAccount extends StatefulWidget {
  SaloonUser user;
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  UserEditAccount({Key? key, required this.user, required this.updateAccount}) : super(key: key);

  @override
  State<UserEditAccount> createState() => _UserEditAccountState();
}

class _UserEditAccountState extends State<UserEditAccount> {
  final _formKey = GlobalKey();
  late String _username;
  late String _phoneNumber;

  @override
  void initState() {
    _username = widget.user.name;
    _phoneNumber = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: const Text('Edit Account', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[800],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              Text("Update Your Account", style: TextStyle(fontSize: 20.0),),
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text("Name: "),
                      Expanded(
                          child: TextFormField(
                            decoration: editTextDecoration(hint: "Name"),
                            initialValue: _username,
                            onChanged: (val) => setState(() {_username = val;}),
                            validator: (data) {
                              if(data != null){
                                if(data.length > 2){
                                  if(RegExp(r"^[a-zA-Z0-9 ]+$").hasMatch(data)){
                                    return null;
                                  }else{
                                    return "Name shouldn't contain special characters";
                                  }
                                }
                              }
                              return "Name should be at least 3 characters";
                            },))
                    ],),
                    SizedBox(height: 25.0,),
                    Row(children: [
                      Text("Phone: "),
                      Expanded(
                          child: TextFormField(
                            decoration: editTextDecoration(hint: "Phone Number"),
                            initialValue: _phoneNumber,
                            onChanged: (val) => setState(() {_phoneNumber = val;}),
                            keyboardType: TextInputType.phone,
                            validator: (data) {
                              if(data != null){
                                if(data.length > 9){
                                  return null;
                                }
                              }
                              return "Enter a valid phone number";
                            },))
                    ],),
                    const SizedBox(height: 25.0,),
                    Padding(padding: const EdgeInsets.all(10.0), child: TextButton(style: TextButton.styleFrom(backgroundColor: Colors.purple[800]),onPressed: (){
                      //First update it on the database then refresh the ui
                      UserDatabaseService(uid: widget.user.uid).updateUserData(_username, _phoneNumber);
                      widget.updateAccount(null, SaloonUser(uid: widget.user.uid, name: _username, phone: _phoneNumber));
                      Navigator.of(context).pop();
                    }, child: const Text("Update", style: TextStyle(color: Colors.white),)))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
