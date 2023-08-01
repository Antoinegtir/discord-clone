// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:discord/model/user.model.dart';
import 'package:discord/widget/textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../auth/bloc/export.bloc.dart';

class AccountPage extends StatefulWidget {
  final User user;
  final String text;
  const AccountPage({required this.user, required this.text, super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController controller = TextEditingController();
  void _signIn(BuildContext context, String text, User userData) async {
    const String apiUrl = 'http://localhost:3000/graphql';
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };
    final Map<String, dynamic> data = <String, dynamic>{
      'query': '''
      mutation UpdateUserProfile(\$id: ID!, \$status: String) {
        updateUser(id: \$id, status: \$status) {
          _id
          status
        }
      }
    ''',
      'variables': <String, String>{
        'id': userData.id,
        'status': text,
      },
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(data),
      );

      print(response.body);
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        final User user = User(
          id: userData.id,
          email: userData.email,
          username: userData.username,
          displayName: userData.displayName,
          birthday: userData.birthday,
          createdAt: userData.createdAt,
          profilePic: userData.profilePic,
          status: responseData['data']['updateUser']['status'],
        );
        BlocProvider.of<AuthBloc>(context).add(UserLoggedIn(user));
        Navigator.pop(context);
      } else {
        if (kDebugMode) {
          print('Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 55, 61, 61),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 50, 50, 50),
        toolbarHeight: 40,
        elevation: 0,
        title: Text(
          'Modify the ${widget.text}',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              height: 10,
            ),
            TextFieldWidget(
                textEditingController: controller,
                hint: widget.user.username,
                color: const Color.fromARGB(255, 33, 33, 33)),
          ],
        ),
      ),
    );
  }
}
