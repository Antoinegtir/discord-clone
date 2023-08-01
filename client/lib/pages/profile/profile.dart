import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:discord/model/user.model.dart';
import 'package:discord/pages/profile/widget/body.dart';
import 'package:discord/pages/profile/widget/status.dart';
import 'package:discord/pages/profile/widget/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/export.bloc.dart';

class ProfilePage extends StatefulWidget {
  final User userData;

  const ProfilePage({super.key, required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 26, 24, 24),
          height: 80,
          padding: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BouncingWidget(
                  onPressed: () {},
                  child: const Icon(
                    Icons.discord,
                    color: Colors.grey,
                    size: 30,
                  )),
              const SizedBox(
                width: 45,
              ),
              BouncingWidget(
                  onPressed: () {},
                  child: const Icon(
                    Icons.emoji_people_sharp,
                    color: Colors.grey,
                    size: 30,
                  )),
              const SizedBox(
                width: 45,
              ),
              BouncingWidget(
                  onPressed: () {},
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 30,
                  )),
              const SizedBox(
                width: 45,
              ),
              BouncingWidget(
                  onPressed: () {},
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.grey,
                    size: 30,
                  )),
              const SizedBox(
                width: 45,
              ),
              BouncingWidget(
                  onPressed: () {},
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                              height: 30,
                              width: 30,
                              imageUrl: widget.userData.profilePic)),
                      widget.userData.status == 'Inactive'
                          ? const Icon(
                              Icons.mode_night_sharp,
                              color: Colors.orange,
                              size: 10,
                            )
                          : widget.userData.status == 'Do not disturb'
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
                              : widget.userData.status == 'Invisible'
                                  ? Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      height: 10,
                                      width: 10,
                                    )
                                  : Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle),
                                      height: 10,
                                      width: 10,
                                    ),
                    ],
                  ))
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 55, 61, 61),
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: const Color.fromARGB(255, 50, 50, 50),
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(UserLoggedOut());
              },
              child: const Icon(
                Icons.login,
                color: Colors.black,
              )),
        ),
        body: Center(
          child: ListView(children: <Widget>[
            ProfileHeader(
              userData: widget.userData,
              key: widget.key,
            ),
            Container(
              height: 30,
            ),
            GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    elevation: 2,
                    builder: (BuildContext context) {
                      return StatustProfile(
                        key: widget.key,
                        userData: widget.userData,
                      );
                    },
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: const Color.fromARGB(255, 50, 50, 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          width: 10,
                        ),
                        const Icon(
                          CupertinoIcons.profile_circled,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Define status',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: widget.userData.status == 'Online'
                              ? 140
                              : widget.userData.status == 'Inactive' ||
                                      widget.userData.status == 'Invisible'
                                  ? 130
                                  : 90,
                        ),
                        widget.userData.status == 'Inactive'
                            ? const Icon(
                                Icons.mode_night_sharp,
                                color: Colors.orange,
                                size: 10,
                              )
                            : widget.userData.status == 'Do not disturb'
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
                                : widget.userData.status == 'Invisible'
                                    ? Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle),
                                        height: 10,
                                        width: 10,
                                      )
                                    : Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle),
                                        height: 10,
                                        width: 10,
                                      ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.userData.status,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        const Icon(
                          CupertinoIcons.forward,
                          color: Colors.grey,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ]),
                )),
            Container(
              height: 30,
            ),
            BodyWidget(
              key: widget.key,
              userData: widget.userData,
            )
          ]),
        ));
  }
}
