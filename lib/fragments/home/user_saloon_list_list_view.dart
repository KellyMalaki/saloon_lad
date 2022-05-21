import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/home/saloon_tile.dart';
import 'package:saloon_lad/models/saloons_list_model.dart';

import '../../models/user.dart';

class SaloonListOrganiser extends StatelessWidget {
  final List<SaloonsModel>? theData;
  final SaloonUser user;
  const SaloonListOrganiser({Key? key, required this.theData, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget pleaseWaitMessage(){
      return const Text("Please wait. Saloons loading...");
    }
    if(theData == null){
      print("It is null");
      return pleaseWaitMessage();
    }else{
      if(theData!.isEmpty){
        print("It is empty");
        return pleaseWaitMessage();
      }else{
        return Expanded(
          child: ListView.builder(itemCount: theData!.length,
                itemBuilder: (context, index){
                  return SaloonTile(saloon: theData![index], user: user);
                },
          ),
        );
      }
    }
  }
}
