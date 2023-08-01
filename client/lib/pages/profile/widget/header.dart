import 'package:discord/model/user.model.dart';
import 'package:flutter/material.dart';
import '../../../widget/profilepic.dart';

class ProfileHeader extends StatefulWidget {
  final User userData;

  const ProfileHeader({super.key, required this.userData});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (_) {
          setState(() {
            isSelected = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            isSelected = false;
          });
        },
        onTapCancel: () {
          setState(() {
            isSelected = false;
          });
        },
        child: Container(
            height: 300,
            color: const Color.fromARGB(255, 26, 24, 24),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.topLeft,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.blueGrey,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 60, 60, 60),
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 150, left: 20),
                            child: ProfilePic(
                              userData: widget.userData,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 22, top: 0),
                            child: Text(
                              widget.userData.displayName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                            )),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 0, 212, 180),
                                    shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: const Text(
                                  '#',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 22, top: 2),
                        child: Text(
                          widget.userData.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        )),
                  ],
                ),
                IgnorePointer(
                    child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  color: !isSelected
                      ? Colors.transparent
                      : const Color.fromARGB(120, 36, 36, 36),
                )),
              ],
            )));
  }
}
