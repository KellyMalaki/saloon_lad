import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/home/saloon_add_account_style.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/services/saloon_database.dart';

import '../../models/user.dart';

class EditAccountStyles extends StatefulWidget {
  SaloonAccount saloonAccount;
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  EditAccountStyles({Key? key, required this.saloonAccount, required this.updateAccount}) : super(key: key);

  @override
  State<EditAccountStyles> createState() => _EditAccountStylesState();
}

class _EditAccountStylesState extends State<EditAccountStyles> {
  Widget headerText(String name){
    return Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),);
  }
  Widget itemText(String name){
    return Text(name, style: const TextStyle(fontSize: 15),);
  }
  late String theInput;
  List<List<String>> styles = [];


  @override
  void initState() {
    theInput = widget.saloonAccount.styles;
    List<String> theInstances = theInput.split("/./");
    if(theInstances.length != 1){
      for(int i =0; i<theInstances.length; i++){
        styles.add(theInstances[i].split("/,/"));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    Future confirmDeleteDialog(String name, int index) =>  showDialog(context: context, builder: (context) => AlertDialog(title: Text("Delete $name?"), content: const Text("Confirm deleting the selected style from the saloon's list."),
        actions: [TextButton(onPressed: () {
          Navigator.of(context).pop();
          setState(() {
            /*if(styles.length == 1){
              styles[0] = [];
              print("We currently have ${styles[0]}");
            }else{*/
              styles.removeAt(index);
            //}
          });
        }, child: const Text("Delete")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("Cancel"))
        ]
    ));

    Widget availableStyles(){
      if(styles.isEmpty){
        return const Text("{ No available Styles added yet. Press Add style to add one }");
      }else{
        return ListView.builder(scrollDirection: Axis.vertical, shrinkWrap: true,itemCount: styles.length ,itemBuilder: (BuildContext context, int index){
          return Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                itemText(styles[index][0]),
                itemText(styles[index][1]),
                Row(children: [itemText(styles[index][2]), IconButton(icon: const Icon(Icons.delete), color: Colors.blue[800],onPressed: () => confirmDeleteDialog(styles[index][0], index),)],
                ),
              ],
            ),);
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: const Text("Edit Styles"),
        backgroundColor: Colors.blue[800]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headerText("Name"),
                  headerText("Duration"),
                  Padding(padding: const EdgeInsets.only(right: 30), child: headerText("Price"))
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: availableStyles(),
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(onPressed: () async {
                List<String>? addedData = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAccountStyle()));
                if(addedData != null){
                  setState(() {
                    print("The data is ${styles}");
                    if(styles.isEmpty){
                      //styles[0] = addedData;
                      styles.add(addedData);
                    }else{
                      styles.add(addedData);
                    }
                  });
                }
              },
                child: const Text("Add Style", style: TextStyle(color: Colors.white),), style: TextButton.styleFrom(backgroundColor: Colors.blue[800]), ),
              const SizedBox(height: 20,),
              Center(
                child: TextButton(onPressed: (){
                  String output = "";
                  int theLength = styles.length;
                  for(int i = 0; i< theLength; i++){
                    output+= "${styles[i][0]}/,/${styles[i][1]}/,/${styles[i][2]}";
                    if(i != theLength-1){
                      output += "/./";
                    }
                  }
                  SaloonDatabaseService(uid: widget.saloonAccount.uid).updateSaloonData(widget.saloonAccount.name, widget.saloonAccount.phone, widget.saloonAccount.location, widget.saloonAccount.description, output);
                  widget.updateAccount(SaloonAccount(uid: widget.saloonAccount.uid, name: widget.saloonAccount.name, phone: widget.saloonAccount.phone, location: widget.saloonAccount.location, description: widget.saloonAccount.description, styles: output), null);
                  Navigator.of(context).pop();
                }, child: const Text("Update Changes", style: TextStyle(color: Colors.white),), style: TextButton.styleFrom(backgroundColor: Colors.blue[800]), ),
              )
            ],
          ),
        ),
      ),

    );
  }
}


