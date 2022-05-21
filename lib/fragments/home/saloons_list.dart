 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saloon_lad/fragments/home/user_edit_account.dart';
import 'package:saloon_lad/fragments/home/user_saloon_list_list_view.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/saloons_list_model.dart';
import 'package:saloon_lad/models/user.dart';

class SaloonsList extends StatefulWidget {
  final SaloonUser user;
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  const SaloonsList({Key? key, required this.user, required this.updateAccount}) : super(key: key);

  @override
  State<SaloonsList> createState() => _SaloonsListState();
}

class _SaloonsListState extends State<SaloonsList> {
  @override
  Widget build(BuildContext context) {
    final theSaloons = Provider.of<List<SaloonsModel>>(context);
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(children: [
              Text("Welcome ${widget.user.name},", style: const TextStyle(fontSize: 18),),
              const Spacer(),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserEditAccount(user: widget.user, updateAccount: widget.updateAccount,))), child: Text("Edit Account", style: TextStyle(color: Colors.blue[800]),))
            ]),
          ),
          SaloonListOrganiser(theData: theSaloons, user: widget.user,)]
      );
  }
}
