import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bookedClients.dart';

class SaloonRecords{
  final String saloonUid;
  final String saloonName;
  late CollectionReference saloonUserHolder;
  final CollectionReference allUsers = FirebaseFirestore.instance.collection("user");
  SaloonRecords({required this.saloonUid, required this.saloonName}){
    saloonUserHolder = FirebaseFirestore.instance.collection("${saloonUid}Records");
  }

  Future updateUsersBooking(String userUid, String name, String style, String phone) async{
    return await saloonUserHolder.doc(userUid).set({
      'name':  name,
      'style': style,
      'phone': phone}
    );
  }

  List<BookedClients> _getBookedClientsInModel(QuerySnapshot snapshot){
    return snapshot.docs.map((document) {
      return BookedClients(style: document.get('style'), name: document.get("name"), phone: document.get("phone"));
    }).toList();
  }
  Stream<List<BookedClients>> get getBookedClients{
    return saloonUserHolder.snapshots().map(_getBookedClientsInModel);
  }


}