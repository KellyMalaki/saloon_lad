import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saloon_lad/models/user.dart';

class UserDatabaseService{
  final String? uid;
  UserDatabaseService({this.uid});

  final CollectionReference user = FirebaseFirestore.instance.collection("user");

  Future<List<String>> getNameAndPhoneFromUid(String uid) async{
    late String name;
    late String phone;
    await user.doc(uid).get().then((value) {
      name = value.get('name');
      phone = value.get('phone');
    });
    return [name, phone];
  }
  Future updateUserData(String name, String phone) async{
    return await user.doc(uid).set({
      'name':  name,
      'phone': phone}
    );
  }
  Future<String> getUserName() async{
    late String name;
    await user.doc(uid).get().then((value) {
      name = value.get('name');
    });
        return name;
  }
  Future<SaloonUser> getCurrentUser() async {
    DocumentSnapshot data = await user.doc(uid).get();
    return SaloonUser(uid: uid!, name: data.get('name'), phone: data.get('phone'));
  }
  //Get updated saloon data
  Stream<QuerySnapshot> getSaloonData(CollectionReference theSaloon){
      return theSaloon.snapshots();
  }

}