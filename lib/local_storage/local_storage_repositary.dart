import 'package:shared_preferences/shared_preferences.dart';
class LocalStorageRepository {

  void setToken(String token)async{
   // Obtain shared preferences.
 SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('x-auth-token',token);
  }



  //get the token
  
  Future<String?> getToken()async{
   // Obtain shared preferences.
 SharedPreferences prefs = await SharedPreferences.getInstance();
String? token = prefs.getString('x-auth-token');

return token!;
  }
}