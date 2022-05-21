import 'package:flutter/material.dart';
import '../../shared/widgets.dart';

class AddAccountStyle extends StatefulWidget {
  const AddAccountStyle({Key? key}) : super(key: key);

  @override
  State<AddAccountStyle> createState() => _AddAccountStyleState();
}

class _AddAccountStyleState extends State<AddAccountStyle> {
  List<String> durationOptions = ["Minutes", "Hours"];
  late String selectedDuration;

  final _formKey = GlobalKey<FormState>();
  String name = "";
  double duration = 0.0;
  double price = 0.0;


  @override
  void initState() {
    selectedDuration = durationOptions[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add a Style"), backgroundColor: Colors.blue[800],),
      backgroundColor: Colors.blue[100],
      body: Padding(padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: saloonUpdateEditTextDecoration(hint: "Style Name"),
                validator: (data) {
                  if(data != null){
                    if(data == ""){
                      return "You need to insert a name in order to continue";
                    }
                    int divider = data.split('/,/').length;
                    int divider2 = data.split("/./").length;
                    if(divider != 1){
                      return "You cannot user the symbols '/,/' in your name";
                    }
                    if(divider2 != 1){
                      return "You cannot user the symbols '/./' in your name";
                    }
                    return null;
                }
                  return "You need to insert a name in order to continue";
                },
                  onChanged: (data){
                    setState(() {
                      name = data;
                    });
                  }
              ),
              const SizedBox(height: 20,),
              Row(children: [Expanded(
                child: TextFormField(
                  decoration: saloonUpdateEditTextDecoration(hint: "Duration"),
                  keyboardType: TextInputType.number,
                    validator: (data) {
                      if(data != null){
                        if(data == ""){
                          return "You need to insert a duration period in order to continue";
                        }
                        int divider = data.split('/,/').length;
                        int divider2 = data.split("/./").length;
                        if(divider != 1){
                          return "You cannot user the symbols '/,/' in duration";
                        }
                        if(divider2 != 1){
                          return "You cannot user the symbols '/./' in duration";
                        }
                        return null;
                      }
                      return "You need to insert a duration period in order to continue";
                    },
                    onChanged: (data){
                    if(double.tryParse(data) != null){
                      setState(() {
                        duration = double.parse(data);
                      });
                    }
                    }
                ),
              ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 2.0),
                    child: DropdownButton(icon: const Icon(Icons.keyboard_arrow_down),value: selectedDuration, items: durationOptions.map((String chosen) => DropdownMenuItem(child: Text(chosen), value: chosen)).toList(), onChanged: (String? selected){
                      setState(() {
                        selectedDuration = selected!;
                      });
                    }),
                  ),
                )
              ],),
              const SizedBox(height: 20),
              TextFormField(
                decoration: saloonUpdateEditTextDecoration(hint: "Price"),
                keyboardType: TextInputType.number,
                  validator: (data) {
                    if(data != null){
                      if(data == ""){
                        return "You need to insert a price in order to continue";
                      }
                      int divider = data.split('/,/').length;
                      int divider2 = data.split("/./").length;
                      if(divider != 1){
                        return "You cannot user the symbols '/,/' in price";
                      }
                      if(divider2 != 1){
                        return "You cannot user the symbols '/./' in price";
                      }
                      if(data == "."){
                        return "Insert a real value";
                      }
                      return null;
                    }
                    return "You need to insert a price in order to continue";
                  },
                  onChanged: (data){
                    if(double.tryParse(data) != null){
                      setState(() {
                        price = double.parse(data);
                      });
                    }
                  }
              ),
              const SizedBox(height: 20),
              TextButton(onPressed: (){
                if(_formKey.currentState != null){
                  //We are good proceed
                  if(_formKey.currentState!.validate()){
                    //Check the validation process and give the found errors
                    if(selectedDuration == durationOptions[1]){
                      duration = duration * 60;
                    }
                    List<String>? theOutput = [name, duration.toString(), price.toString()];
                    Navigator.pop(context, theOutput);
                  }
                }else{
                  //An  Unknown Error occurred

                }
              }, child: const Text("Add Style", style: TextStyle(color: Colors.white),), style: TextButton.styleFrom(backgroundColor: Colors.blue[800]), )
            ],
          ),
        )),),
    );
  }
}
