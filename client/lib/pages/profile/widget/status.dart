import 'dart:convert';

import 'package:discord/model/user.model.dart';
import 'package:discord/pages/profile/data/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../auth/bloc/export.bloc.dart';

class StatustProfile extends StatefulWidget {
  const StatustProfile({required this.userData, super.key});
  final User userData;
  @override
  State<StatustProfile> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<StatustProfile> {
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
    return SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 3,
              color: const Color.fromARGB(255, 235, 234, 234),
            ),
            Container(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 24, 24),
                  borderRadius: BorderRadius.circular(5)),
              alignment: Alignment.centerLeft,
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                'Define status',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 46, 52, 52),
              height: 337,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: 190,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                _signIn(context, status[index]['text'],
                                    widget.userData);
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(index == 0 ? 5 : 0),
                                      topRight:
                                          Radius.circular(index == 0 ? 5 : 0),
                                      bottomLeft:
                                          Radius.circular(index == 3 ? 5 : 0),
                                      bottomRight:
                                          Radius.circular(index == 3 ? 5 : 0)),
                                  color: const Color.fromARGB(
                                    255,
                                    30,
                                    30,
                                    30,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 10,
                                    ),
                                    status[index]['color'] == Colors.orange
                                        ? const Icon(
                                            Icons.mode_night_sharp,
                                            color: Colors.orange,
                                            size: 13,
                                          )
                                        : status[index]['color'] == Colors.red
                                            ? Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle),
                                                height: 10,
                                                width: 10,
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: 1.5,
                                                  width: 8,
                                                  color: Colors.black,
                                                ))
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: status[index]
                                                        ['color'],
                                                    shape: BoxShape.circle),
                                                height: 10,
                                                width: 10,
                                              ),
                                    Container(
                                      width: 10,
                                    ),
                                    Text(
                                      status[index]['text'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ));
                        },
                        itemCount: 4,
                        separatorBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 1,
                                color: const Color.fromARGB(255, 50, 50, 50),
                                width: 20,
                              ),
                              Container(
                                height: 1,
                                color: Colors.transparent,
                                width: MediaQuery.of(context).size.width - 60,
                              )
                            ],
                          );
                        },
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(
                          255,
                          30,
                          30,
                          30,
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 10),
                      child: const Row(
                        children: <Widget>[
                          Icon(
                            Icons.emoji_emotions,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Define a personalized status',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
