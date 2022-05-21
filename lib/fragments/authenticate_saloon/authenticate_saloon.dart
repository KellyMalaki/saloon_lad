import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/authenticate_saloon/sign_in.dart';
import 'package:saloon_lad/fragments/authenticate_saloon/sign_up.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';

class AuthenticateSaloon extends StatefulWidget {
  final VoidCallback changeType;
  final void Function(SaloonAccount?, SaloonUser?) loginFunction;
  const AuthenticateSaloon({Key? key, required this.changeType, required this.loginFunction}) : super(key: key);

  @override
  State<AuthenticateSaloon> createState() => _AuthenticateSaloonState();
}

class _AuthenticateSaloonState extends State<AuthenticateSaloon> {
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
