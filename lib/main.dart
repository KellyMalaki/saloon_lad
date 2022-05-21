import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/auth.dart';
import 'package:saloon_lad/services/saloon_database.dart';
import 'package:saloon_lad/services/user_database.dart';
import 'package:saloon_lad/wrapper_saloon.dart';
import 'package:saloon_lad/wrapper_user.dart';

import 'models/saloon.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserAuthService theAccount = UserAuthService();
  bool? inSaloonMode;
  SaloonAccount? saloonAccount;
  SaloonUser? saloonUser;
  late bool loggedIn;
  if(theAccount.checkIfLoggedIn()){
    loggedIn = true;
    inSaloonMode = await theAccount.checkTheUser();
    if(inSaloonMode){
      //Get saloon's data
      saloonAccount = await SaloonDatabaseService(uid: theAccount.getUid()).getCurrentSaloonData();
    }else{
      //Get user's data
      saloonUser = await UserDatabaseService(uid: theAccount.getUid()).getCurrentUser();
    }
  }else{
    loggedIn = false;
    inSaloonMode = false;

  }
  runApp(MyApp(inSaloonMode: inSaloonMode, saloonAccount: saloonAccount, saloonUser: saloonUser, loggedIn: loggedIn));
}

class MyApp extends StatefulWidget {
  final bool inSaloonMode;
  final SaloonAccount? saloonAccount;
  final SaloonUser? saloonUser;
  final bool loggedIn;
  const MyApp({Key? key, required this.inSaloonMode, this.saloonUser, this.saloonAccount, required this.loggedIn}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool inSaloonMode;
  late SaloonAccount? saloonAccount;
  late SaloonUser? saloonUser;
  late bool loggedIn;

  @override
  void initState() {
    inSaloonMode = widget.inSaloonMode;
    saloonAccount = widget.saloonAccount;
    saloonUser = widget.saloonUser;
    loggedIn = widget.loggedIn;
  }

  void changeState(){
    setState(() {
      inSaloonMode = !inSaloonMode;
    });
  }

  void loginToAccount(SaloonAccount? saloon, SaloonUser? user){
    if(!inSaloonMode){
      setState(() {
        loggedIn = true;
        saloonUser = user;
      });
    }else{
      setState(() {
        loggedIn = true;
        saloonAccount = saloon;
      });
    }
  }
  void updateAccountData(SaloonAccount? saloon, SaloonUser? user){
    if(inSaloonMode){
      //Update the Saloon's data
      setState(() {
        saloonAccount = saloon;
      });
    }else{
      //Update user's data
      setState(() {
        saloonUser = user;
      });
    }
  }
  void logout(){
    if(inSaloonMode){
      setState(() {
        saloonAccount = null;
        loggedIn = false;
      });
    }else{
      setState(() {
        saloonUser = null;
        loggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!inSaloonMode){
      return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Saloon Lads',
            home: WrapperUser(loggedIn: loggedIn, user: saloonUser, changeType: changeState, loginFunction: loginToAccount, updateAccount: updateAccountData, logout: logout)
        );
    }else{
      return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Saloon Lads',
            home: WrapperSaloon(loggedIn: loggedIn, saloon: saloonAccount, changeType: changeState, loginFunction: loginToAccount, updateAccount: updateAccountData, logout: logout)
        );
    }
  }
}

