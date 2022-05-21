import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_lad/fragments/home/saloon_desktop.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/saloon_auth.dart';

import '../../models/bookedClients.dart';
import '../../services/saloon_records.dart';

class Home extends StatelessWidget {
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  final VoidCallback logout;
  final SaloonAuthService _auth = SaloonAuthService();
  final SaloonAccount saloonAccount;
  Home({Key? key, required this.saloonAccount, required this.updateAccount, required this.logout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<BookedClients>>.value(
      value: SaloonRecords(saloonName: saloonAccount.name, saloonUid: saloonAccount.uid).getBookedClients,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue[800],
          actions: [
            IconButton(onPressed: () async {
              await _auth.logout();
              logout();
            }, icon: const Icon(Icons.logout))
          ],
        ),
        backgroundColor: Colors.blue[100],
        body: SaloonDesktop(updateAccount: updateAccount, saloonAccount: saloonAccount),
      ),
    );
  }
}
