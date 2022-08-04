import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey{uid}


class DBService{

  //save date
  static Future<bool>saveUserId(String uid)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(StorageKey.uid.name, uid);
  }

  //load user
  static Future<String?>loadUserId(String uid)async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(StorageKey.uid.name);
  }


  //delete
  static Future<bool> removeUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(StorageKey.uid.name);
  }

}