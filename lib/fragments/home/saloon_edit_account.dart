import 'package:flutter/material.dart';
import 'package:saloon_lad/fragments/home/saloon_edit_account_styles.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/saloon_database.dart';
import 'package:saloon_lad/shared/widgets.dart';

class SaloonEditAccount extends StatefulWidget {
  final SaloonAccount saloonAccount;
  final void Function(SaloonAccount?, SaloonUser?) updateAccount;
  const SaloonEditAccount({Key? key, required this.saloonAccount, required this.updateAccount}) : super(key: key);

  @override
  State<SaloonEditAccount> createState() => _SaloonEditAccountState();
}

class _SaloonEditAccountState extends State<SaloonEditAccount> {
  final _formKey = GlobalKey();
  late String _saloonName;
  late String _phoneNumber;
  late String _location;
  late String _description;
  late String _styles;


  @override
  void initState() {
    _saloonName = widget.saloonAccount.name;
    _phoneNumber = widget.saloonAccount.phone;
    _location = widget.saloonAccount.location;
    _description = widget.saloonAccount.description;
    _styles = widget.saloonAccount.styles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Edit Account', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[800],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20.0,),
              const Text("Update Saloon's Details", style: TextStyle(fontSize: 20.0),),
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name"),
                    const SizedBox(height: 5.0,),
                    TextFormField(
                      decoration: saloonUpdateEditTextDecoration(hint: "Saloon Name"),
                      initialValue: _saloonName,
                      onChanged: (val) => setState(() {_saloonName = val;}),
                      validator: (data) {
                        if(data != null){
                          if(data.length > 2){
                            if(RegExp(r"^[a-zA-Z0-9 ]+$").hasMatch(data)){
                              return null;
                            }else{
                              return "Name shouldn't contain special characters";
                            }
                          }
                        }
                        return "Name should be at least 3 characters";
                      },),
                    const SizedBox(height: 25.0,),
                    const Text("Phone"),
                    const SizedBox(height: 5.0,),
                    TextFormField(
                      decoration: saloonUpdateEditTextDecoration(hint: "Phone Number"),
                      initialValue: _phoneNumber,
                      onChanged: (val) => setState(() {_phoneNumber = val;}),
                      keyboardType: TextInputType.phone,
                      validator: (data) {
                        if(data != null){
                          if(data.length > 9){
                            return null;
                          }
                        }
                        return "Enter a valid phone number";
                      },),
                    const SizedBox(height: 25.0,),
                    const Text("Location"),
                    const SizedBox(height: 5.0,),
                    TextFormField(
                      decoration: saloonUpdateEditTextDecoration(hint: "Saloon's Location"),
                      initialValue: _location,
                      onChanged: (val) => setState(() {_location = val;}),
                      validator: (data) {
                        if(data != null){
                          if(data.length > 2){
                            return null;
                          }
                        }
                        return "Location should be at least 3 characters";
                      },),
                    const SizedBox(height: 25.0,),
                    const Padding(padding: EdgeInsets.only(left: 10.0),child: Text("Description")),
                    const SizedBox(height: 10.0,),
                    TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      decoration: saloonUpdateEditTextDecoration(hint: "Saloon's description"),
                      initialValue: _description,
                      onChanged: (val) => setState(() {_description = val;}),
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 25.0,),
                  ],
                ),
              ),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccountStyles(saloonAccount: widget.saloonAccount, updateAccount: widget.updateAccount))), child: const Text("Edit Styles")),
              const SizedBox(height: 25.0,),
              Padding(padding: const EdgeInsets.all(10.0), child: TextButton(style: TextButton.styleFrom(backgroundColor: Colors.blue[800]),onPressed: (){
                //First update it on the database then refresh the ui
                SaloonDatabaseService(uid: widget.saloonAccount.uid).updateSaloonData(_saloonName, _phoneNumber, _location, _description, _styles);
                widget.updateAccount(SaloonAccount(uid: widget.saloonAccount.uid, name: _saloonName, phone: _phoneNumber, location: _location, description: _description, styles: _styles), null);
                Navigator.of(context).pop();
              }, child: const Text("Update", style: TextStyle(color: Colors.white),)))
            ],
          ),
        ),
      ),
    );
  }
}

