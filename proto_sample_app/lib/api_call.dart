import 'dart:io';

import 'package:proto_sample/generated/sign_in.pb.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  static String nodeBaseUrl = 'http://127.0.0.1:4000/';
  static String pythonBaseUrl = 'http://127.0.0.1:5000/';

  Future<SignInResponse?> signIn(String baseUrl, SignIn signIn) async {
    final url = baseUrl + "sign_in";
    final body = signIn.writeToBuffer().toString();
    await Future.delayed(Duration(milliseconds: 500));
    final response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {'content-type': 'application/octet-stream'},
    ).timeout(const Duration(seconds: 5));
    try {
      return SignInResponse.fromBuffer(response.bodyBytes);
    } catch (e) {
      throw response.body;
    }
  }
}
