import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_lad/fragments/home/saloons_list.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/saloons_list_model.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/auth.dart';
import 'package:saloon_lad/services/saloon_database.dart';

class Home extends StatelessWidget {
  final UserAuthService _auth = UserAuthService();
  final VoidCallback logout;
  final void Function(SaloonAccount?, SaloonUser?) updateUserAccount;
  final SaloonUser user;
  Home({Key? key, required this.user, required this.updateUserAccount, required this.logout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SaloonsModel>>.value(
      value: SaloonDatabaseService().getSaloonsData,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple[800],
          actions: [
            IconButton(onPressed: () async {
              await _auth.logout();
              logout();
            }, icon: const Icon(Icons.logout))
          ],
        ),
        backgroundColor: Colors.purple[100],
        body: SaloonsList(user: user, updateAccount: updateUserAccount),
      ),
    );
  }
}
