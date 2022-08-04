import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note/pages/sign_in_page.dart';
import 'package:firebase_note/services/db_service.dart';
import 'package:firebase_note/services/util_service.dart';
import 'package:flutter/material.dart';

class AuthService{
  static final _auth = FirebaseAuth.instance; //qanday tipda String, int

  static Future<User?> signUpUser(BuildContext context, String name, String email, String password)async{  //User nima?
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var user = credential.user;
      await user?.updateDisplayName(name);
      return user;
    }catch(e){
      Utils.fireSnackBar(e.toString(), context);
    }
    return null;
  }

  static Future<User?> signInUser(BuildContext context, String email, String password)async{  //User nima?
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      Utils.fireSnackBar(e.toString(), context);
    }
    return null;
  }

  static Future<void> signOutUser(BuildContext context)async{
    await _auth.signOut();
    DBService.removeUserId().then((value) {
      Navigator.pushReplacementNamed(context, SignInPage.id);
    });
  }

}