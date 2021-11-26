import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  String? _userID;
  DateTime? _expiryDate;
  String? _email;

  bool get isAuth{
    return token!=null;
  }

  String? get token {
    
    if(_token!=null && _expiryDate!=null && _expiryDate!.isAfter(DateTime.now())){
      
      return _token;

    }
    
  }

  

  String? get userid{
    if(_userID!=null)
    {
      return _userID;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlsegment) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyCoPvvkmLOshTjcd5gLwwluuTdAJGgWK1c");
    final response = await http.post(url,
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    var authData = json.decode(response.body);

    _token = authData['idToken'];
    _userID = authData['localId'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          authData['expiresIn'],
        ),
      ),
    );
    
    notifyListeners();
  }

  Future<void> signup(String email, String password) async {
    _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    _authenticate(email, password, "signInWithPassword");
  }
}
