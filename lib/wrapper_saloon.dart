import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/authenticate_saloon/authenticate_saloon.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';
import 'fragments/home/saloon_home.dart';

class WrapperSaloon extends StatelessWidget {
  final VoidCallback changeType;
  final VoidCallback logout;
  final SaloonAccount? saloon;
  final bool loggedIn;
  final void Function(SaloonAccount?, SaloonUser?) loginFunction;
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  const WrapperSaloon({Key? key, required this.changeType, required this.logout, required this.saloon, required this.loggedIn, required this.updateAccount, required this.loginFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(!loggedIn){
      return AuthenticateSaloon(changeType: changeType, loginFunction: loginFunction);
    }else{
      return Home(saloonAccount: saloon!, updateAccount: updateAccount, logout: logout);
    }
  }
}
