import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/home/view_saloon_details.dart';
import 'package:saloon_lad/models/saloons_list_model.dart';

import '../../models/user.dart';

class SaloonTile extends StatelessWidget {
  final SaloonsModel saloon;
  final SaloonUser user;
  const SaloonTile({Key? key, required this.saloon, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSaloonDetails(saloonModel: saloon, user: user,))),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: const CircleAvatar(radius: 25.0,
              backgroundColor: Colors.grey ,),
            title: Text(saloon.name),
            subtitle: Row(children: [
              Expanded(child: Text("Location: ${saloon.location}")),

              const Expanded(child: Padding(padding: EdgeInsets.only(left: 5.0),child: Text("Free in: 0hrs")))
            ],),
          ),
        ),
      ),
    );
  }
}
