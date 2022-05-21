import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saloon_lad/models/saloon.dart';
import 'package:saloon_lad/services/saloon_database.dart';

class SaloonAuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<SaloonAccount?> _getSaloonFromFirebase(User? user) async {
    DocumentSnapshot saloonData = await FirebaseFirestore.instance.collection("saloons").doc(user?.uid).get();
    if(!saloonData.exists){
      logout();
      return null;
    }
    return SaloonAccount(uid: user!.uid, name: saloonData.get('name'), phone: saloonData.get('phone'), location: saloonData.get('location'), description: saloonData.get("description"), styles: saloonData.get("styles"));
  }
  Future registerWithEmailAndPassword(String email, String name, String phone, String location, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if(user == null){
        return null;
      }else{
        await SaloonDatabaseService(uid: user.uid).updateSaloonData(name, phone, location, "", "");
        return _getSaloonFromFirebase(user);
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _getSaloonFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _getSaloonFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future logout() async{
    try{
      _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}