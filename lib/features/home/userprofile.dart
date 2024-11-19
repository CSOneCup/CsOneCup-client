import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userLevel = 1;
  var userName = '사용자';
  var userExp = 50;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      child: Column(
        children: [
          Row(children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.mainDarkGray,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.settings),
                      ],
                    ),
                  ],
                ),
                Text(
                  'LV $userLevel',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ]),
          const SizedBox(height: 20),
          ExpBar(userExp: userExp),
        ],
      ),
    );
  }
}

//경험치 바 위젯
class ExpBar extends StatefulWidget {
  final int userExp;

  const ExpBar({super.key, required this.userExp});

  @override
  State<ExpBar> createState() => _ExpBarState();
}

class _ExpBarState extends State<ExpBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainDarkGray, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: widget.userExp / 100),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.transparent,
              color: AppColors.mainDeepOrange,
              minHeight: 18,
            );
          },
        ),
      ),
    );
  }
}
