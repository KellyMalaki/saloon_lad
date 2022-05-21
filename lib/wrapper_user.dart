import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/authenticate_user/authenticate_user.dart';
import 'package:saloon_lad/fragments/home/user_home.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';

class WrapperUser extends StatelessWidget {
  final VoidCallback changeType;
  final VoidCallback logout;
  final SaloonUser? user;
  final bool loggedIn;
  final void Function(SaloonAccount?, SaloonUser?) loginFunction;
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  const WrapperUser({Key? key, required this.logout, required this.changeType, required this.user, required this.loggedIn, required this.loginFunction, required this.updateAccount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!loggedIn){
      return Authenticate(changeType: changeType, loginFunction: loginFunction);
    }else{
      return Home(user: user!, updateUserAccount: updateAccount, logout: logout);
    }
  }
}
