import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/auth_response.dart';
import '../main.dart' as main;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key, String token}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

AuthResponse _authResponse;
String user;
String password;
String token;

Future<AuthResponse> _getAuth() async {
  try {
    final response = await http.post(
        Uri.parse('http://servicosflex.rpinfo.com.br:9000/v1.1/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'usuario': user, 'senha': password}));
    if (response.statusCode == 200) {
      AuthResponse _body = AuthResponse.fromJson(jsonDecode(response.body));
      return _body;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

class _LoginScreenState extends State<LoginScreen> {
  Future<AuthResponse> responseBody;
  @override
  Widget build(BuildContext context) {
    final _userController = new TextEditingController();
    final _passwordController = new TextEditingController();
    return Material(
      color: Colors.grey[100],
      child: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 200),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: _userController,
            decoration: InputDecoration(labelText: 'Usuário'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
            keyboardType: TextInputType.number,
          ),
          GestureDetector(
              onTap: () {
                user = _userController.text;
                password = _passwordController.text;
                _getAuth().then((map) {
                  _authResponse = map;
                });
                print(_authResponse?.response?.status);
                token = _authResponse?.response?.token;
                if (_authResponse?.response?.status == "ok" && token != '') {
                  Navigator.pushNamed(context, '/home',
                      arguments: <String, String>{'token': token});
                } else if (_authResponse?.response?.status == "error") {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Erro'),
                            content: Text(
                                _authResponse?.response?.messages?.first?.message),
                            actions: [
                              IconButton(
                                icon: Icon(Icons.check_box),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ));
                }
              },
              child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent),
                  child: Center(
                    child: Text('Login'),
                  ))),
        ]),
      )),
    );
  }
}
