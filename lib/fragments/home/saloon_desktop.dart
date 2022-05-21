import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_lad/fragments/home/BookedClientsListView.dart';
import 'package:saloon_lad/fragments/home/saloon_edit_account.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';

import '../../models/bookedClients.dart';

class SaloonDesktop extends StatefulWidget {
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  final SaloonAccount saloonAccount;
  const SaloonDesktop({Key? key, required this.updateAccount, required this.saloonAccount}) : super(key: key);

  @override
  State<SaloonDesktop> createState() => _SaloonDesktopState();
}

class _SaloonDesktopState extends State<SaloonDesktop> {
  @override
  Widget build(BuildContext context) {
    final myClients = Provider.of<List<BookedClients>>(context);
    TextStyle headerStyle(){
      return const TextStyle(fontWeight: FontWeight.bold);
    }
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.saloonAccount.name, style: const TextStyle(fontSize: 20.0),),
                  const Spacer(),
                  TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SaloonEditAccount(saloonAccount: widget.saloonAccount, updateAccount: widget.updateAccount))), child: Text("Edit Account", style: TextStyle(color: Colors.purple[800]),))
                ],
              ),
              const SizedBox(height: 10.0,),
              const Text("Clients", style: TextStyle(fontSize: 18.0),),
              const SizedBox(height: 10.0,),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Client Name", style: headerStyle()),
                      Text("Service", style: headerStyle()),
                      Text("Call", style: headerStyle())
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5.0,),
              BookedClientsListView(myClients: myClients),
            ],
          ),
      );
  }
}

