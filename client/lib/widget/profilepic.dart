import 'package:cached_network_image/cached_network_image.dart';
import 'package:discord/model/user.model.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final User userData;
  const ProfilePic({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
                width: 90,
                height: 90,
                color: const Color.fromARGB(255, 26, 24, 24),
                padding: const EdgeInsets.all(7),
                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                        height: 90,
                        width: 90,
                        imageUrl: userData.profilePic)))),
        Padding(
          padding: const EdgeInsets.all(9),
          child: userData.status == 'Inactive'
              ? const Icon(
                  Icons.mode_night_sharp,
                  color: Colors.orange,
                  size: 18,
                )
              : userData.status == 'Do not disturb'
                  ? Container(
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      height: 18,
                      width: 18,
                      alignment: Alignment.center,
                      child: Container(
                        height: 3,
                        width: 12,
                        color: Colors.black,
                      ))
                  : userData.status != 'Online'
                      ? Container(
                          decoration: const BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          height: 18,
                          width: 18,
                        )
                      : Container(
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                          height: 18,
                          width: 18,
                        ),
        )
      ],
    );
  }
}
