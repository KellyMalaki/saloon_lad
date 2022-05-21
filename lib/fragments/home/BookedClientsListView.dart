import 'package:flutter/material.dart';
import 'package:saloon_lad/models/bookedClients.dart';
import 'package:url_launcher/url_launcher.dart';

class BookedClientsListView extends StatefulWidget {
  final List<BookedClients> myClients;
  const BookedClientsListView({Key? key, required this.myClients}) : super(key: key);

  @override
  State<BookedClientsListView> createState() => _BookedClientsListViewState();
}

class _BookedClientsListViewState extends State<BookedClientsListView> {
  void callMethod(int theIndex){
    //Call the phone
    _makeACall(widget.myClients[theIndex].phone);
  }
  Future _makeACall(String phone) async{
    Uri url = Uri.parse("tel:$phone");
    await launchUrl(url);
  }
  @override
  Widget build(BuildContext context) {
    Widget availableClients(){
      if(widget.myClients.isEmpty){
        return const Padding(padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),child: Center(child: Text("{ No booked clients. }", style: TextStyle(fontSize: 17.0),)));
      }else{
        return ListView.builder(itemCount: widget.myClients.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${index+1}. ${widget.myClients[index].name}"),
                Text(widget.myClients[index].style),
                IconButton(onPressed: () => callMethod(index), icon: const Icon(Icons.call),)
              ],
            ),
          ),
        );
      }
    }
    return Container(
      color: Colors.white,
      child: availableClients(),
    );
  }
}
