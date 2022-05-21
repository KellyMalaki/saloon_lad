import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/authenticate_user/sign_in.dart';
import 'package:saloon_lad/fragments/authenticate_user/sign_up.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';

class Authenticate extends StatefulWidget {
  final VoidCallback changeType;
  final void Function(SaloonAccount?, SaloonUser?) loginFunction;
  const Authenticate({Key? key, required this.changeType, required this.loginFunction}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool alreadyOwnAnAccount = true;
  void toggleView(){
    setState(() {
      alreadyOwnAnAccount = !alreadyOwnAnAccount;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(alreadyOwnAnAccount){
      return SignIn(toggleView: toggleView, changeType: widget.changeType, loginFunction: widget.loginFunction);
    }else{
      return SignUp(toggleView: toggleView, changeType: widget.changeType, loginFunction: widget.loginFunction);
    }
  }
}
