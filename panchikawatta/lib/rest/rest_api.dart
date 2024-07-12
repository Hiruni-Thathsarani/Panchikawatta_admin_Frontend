 import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:panchikawatta/constant/utils.dart';

Future userLogin(String Username, String Password) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/user/login'),
    headers: {"Accept": "Application/json"},
    body: {'Username': Username, 'Password': Password},
  );
}

Future userRegister(
  String firstName ,
  String lastName,
  String Username,
  String Password,
  String email,
  String phoneNo,
  
) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/user/register'),
    headers: {"Accept": "Application/json"},
    body: {
      'firstName': firstName,
      'lastName': lastName,
      'Username': Username,
      'Password': Password,
      'email': email,
      'phoneNo': phoneNo,
      
    },
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;
}
