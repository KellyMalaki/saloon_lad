import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/models/saloons_list_model.dart';

class SaloonDatabaseService{
  final String? uid;
  SaloonDatabaseService({this.uid});

  final CollectionReference saloons = FirebaseFirestore.instance.collection("saloons");
  Future updateSaloonData(String name, String phone, String location, String description, String styles) async{
    /*//First create the saloon collection (table)
    bool itExists = false;
    saloons.doc(uid).get().then((value) {
      itExists = value.exists;
    });
    if(!itExists){
      //Create the saloon table now
      FirebaseFirestore.instance.collection("$name$uid");
    }*/

    //Then update it's values on the saloons collection
    return await saloons.doc(uid).set({
      'name':  name,
      'phone': phone,
    'location': location,
    'description': description,
      'styles': styles}
    );
  }
  List<SaloonsModel> _getSaloonsInModel(QuerySnapshot snapshot){
    return snapshot.docs.map((document) {
      return SaloonsModel(name: document.get('name'),  phone: document.get('phone'), location: document.get('location'), uid: document.id, styles: document.get('styles'));
    }).toList();
  }
  Stream<List<SaloonsModel>> get getSaloonsData{
    return saloons.snapshots().map(_getSaloonsInModel);
  }
  Future<SaloonAccount> getCurrentSaloonData() async {
    DocumentSnapshot data = await saloons.doc(uid).get();
    return SaloonAccount(uid: uid!, name: data.get('name'), phone: data.get('phone'), location: data.get('location'), description: data.get('description'), styles: data.get('styles'));
  }
}