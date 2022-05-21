import 'package:flutter/material.dart';
import 'package:saloon_lad/models/saloons_list_model.dart';
import 'package:saloon_lad/services/saloon_records.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/user.dart';

class ViewSaloonDetails extends StatefulWidget {
  final SaloonsModel saloonModel;
  final SaloonUser user;
  const ViewSaloonDetails({Key? key, required this.saloonModel, required this.user}) : super(key: key);

  @override
  State<ViewSaloonDetails> createState() => _ViewSalooonDetailsState();
}

class _ViewSalooonDetailsState extends State<ViewSaloonDetails> {
  List<String> durationOptions = ["Minutes", "Hours"];
  late String selectedDuration;
  Widget headerText(String name){
    return Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),);
  }
  Widget itemText(String name){
    return Text(name, style: const TextStyle(fontSize: 15),);
  }

  Future _makeACall(String phone) async{
    Uri url = Uri.parse("tel:$phone");
    await launchUrl(url);
  }

  List<List<String>> styles = [];
  List<double> selectedTime = [];

  void initState() {
    selectedDuration = durationOptions[0];
    String theInput = widget.saloonModel.styles;
    List<String> theInstances = theInput.split("/./");
    if(theInstances.length != 1){
      for(int i =0; i<theInstances.length; i++){
        List<String> one = theInstances[i].split("/,/");
        styles.add(one);
        selectedTime.add(double.parse(one[1]));
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    Future selectStyleDialog(String name, int index) =>  showDialog(context: context, builder: (dialogContext) => AlertDialog(title: Text("Book $name?"), content: const Text("Are you sure you would like to book the selected style?"),
        actions: [TextButton(onPressed: () async {
          Navigator.of(dialogContext).pop();
          await SaloonRecords(saloonUid: widget.saloonModel.uid!, saloonName: widget.saloonModel.name).updateUsersBooking(widget.user.uid, widget.user.name, name, widget.user.phone);
          Navigator.of(context).pop();
        }, child: const Text("Book it")),
          TextButton(onPressed: (){
            Navigator.of(dialogContext).pop();
          }, child: const Text("Cancel"))
        ]
    ));

    Widget availableStyles(){
      if(styles[0].isEmpty){
        return Text("{ ${widget.saloonModel.name} has no available styles yet. Please come and check by later }");
      }else{
        return ListView.builder(scrollDirection: Axis.vertical, shrinkWrap: true,itemCount: styles.length ,itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: () => selectStyleDialog(styles[index][0], index),
            child: Padding(padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemText(styles[index][0]),
                  itemText(selectedTime[index].toString()),
                  itemText(styles[index][2])
                ],
              ),),
          );
        });
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Book Appointment", style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.purple[800],
    ),
    backgroundColor: Colors.purple[100],
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.saloonModel.name, style: const TextStyle(fontSize: 20.0)),
              const Spacer(),
              IconButton(onPressed: () async{
                await _makeACall(widget.saloonModel.phone);
              }, icon: const Icon(Icons.call))
            ],
          ),
          const SizedBox(height: 20.0),
          const Text("Select Service: Click on a service to book it.", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              headerText("Name"),
              Column(
                children: [
                  headerText("Duration"),
                  DropdownButton(icon: const Icon(Icons.keyboard_arrow_down),value: selectedDuration, items: durationOptions.map((String chosen) => DropdownMenuItem(child: Text(chosen), value: chosen)).toList(), onChanged: (String? selected){
                    setState(() {
                      selectedDuration = selected!;
                      if(selectedDuration == durationOptions[0]){
                        //Solve for minutes
                        for(int i =0; i<selectedTime.length; i++){
                          selectedTime[i] = selectedTime[i]*60;
                        }
                      }else{
                        //Solve for hours
                        for(int i =0; i<selectedTime.length; i++){
                          selectedTime[i] = selectedTime[i]/60;
                        }
                      }
                    });
                  })
                ],
              ),
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

        ],
      ),
    )
    );
  }
}
