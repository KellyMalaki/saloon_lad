import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saloon_lad/models/user.dart';
import 'package:saloon_lad/services/user_database.dart';

class UserAuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference saloons = FirebaseFirestore.instance.collection("saloons");

  bool checkIfLoggedIn(){
    if(_auth.currentUser == null){
      return false;
    }else{
      return true;
    }
  }

  Future<SaloonUser?> _getUserFromFirebase(User? user) async {
    DocumentSnapshot userData = await FirebaseFirestore.instance.collection("user").doc(user?.uid).get();
    if(!userData.exists){
      logout();
      return null;
    }
    return SaloonUser(uid: user!.uid, name: userData.get('name'), phone: userData.get('phone'));
  }

  Future<bool> checkTheUser() async{
    final one =saloons.doc(_auth.currentUser?.uid);
    bool itExists = false;
    await one.get().then((value) {
      itExists = value.exists;
    });
    return itExists;
  }

  String getUid(){
    Future.delayed(Duration(seconds: 3));
    return _auth.currentUser!.uid;
  }

  Future registerWithEmailAndPassword(String email, String name, String phone, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if(user == null){
        return null;
      }else{
        await UserDatabaseService(uid: user.uid).updateUserData(name, phone);
        return _getUserFromFirebase(user);
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
      return _getUserFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _getUserFromFirebase(user);
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
