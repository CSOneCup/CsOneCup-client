import 'dart:convert';

import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/home/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final String url = "http://141.164.52.130:8082";
  final DateTime _dateTime = DateTime.now();
  // UserProfile _userProfile = UserProfile(userLevel: 23, userName: 'TestUser', userExp: 2100);
  Future<UserProfile?>? _userProfile;
  Future<List<UserProfile?>?>? _rankedUserList;
  int rank = 1;

  @override
  void initState() {
    _initializeRankingData();
    _userProfile = _loadUserData();
    _rankedUserList = _loadAllUserData();
    super.initState();
  }

  Future<void> _initializeRankingData() async {
    try {
      final user = await _loadUserData();
      final rankedList = await _loadAllUserData();

      if (rankedList != null && user != null) {
        for (int i = 0; i < rankedList.length; i++) {
          if (rankedList[i]?.userName == user.userName) {
            setState(() {
              rank = i + 1;
            });
            break;
          }
        }
      }
    } catch (e) {
      print('Ranking data 초기화 중 오류 발생: $e');
    }
  }

  Future<UserProfile?> _loadUserData() async {
    final String requestUrl = "$url/api/user/info";
    final sharedPreference = await SharedPreferences.getInstance();
    final jwtToken = sharedPreference.getString('authToken');

    try {
      final response = await http.get(
        Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String userName = responseData['data']['name'];
        final int level = responseData['data']['level'];
        final int expPoint = responseData['data']['exp_point'];

        return UserProfile(
          userName: userName,
          userLevel: level,
          userExp: expPoint,
        );
      }
    } catch (e) {
      print('오류 발생 - UserProfile');
      print(e);
      return null;
    }
    return null;
  }

  Future<List<UserProfile?>?> _loadAllUserData() async {
    String requestUrl = "$url/api/user/all/info";
    final sharedPreference = await SharedPreferences.getInstance();
    final jwtToken = sharedPreference.getString('authToken');
    List<UserProfile> userProfileList = [];

    try {
      final response = await http.get(
        Uri.parse(requestUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken'
        },
      );

      if (response.statusCode == 200) {
        //final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> responseData =
            jsonDecode(utf8.decode(response.bodyBytes));
        List<dynamic> userList = responseData['data']; // map

        userList.sort((mapA, mapB) {
          final expA = mapA['exp_point'];
          final expB = mapB['exp_point'];
          return expB.compareTo(expA);
        });

        for (var user in userList) {
          userProfileList.add(UserProfile(
              userLevel: user['level'],
              userName: user['name'],
              userExp: user['exp_point']));
        }
        return userProfileList;
      }
    } catch (e) {
      print(e);
      return null;
    }
    return null;
  }

  Color _setRankingTextColor(int index) {
    if (index == 0) {
      return Colors.yellow;
    } else if (index == 1) {
      return Colors.grey;
    } else if (index == 2) {
      return Colors.brown;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    double layoutWidth = MediaQuery.of(context).size.width * 0.85;

    return Center(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              width: 80,
              height: 80,
              child:
                  Image(image: AssetImage('assets/images/ranking_crown.png')),
            ),
            Text(
              '${_dateTime.year}년 ${_dateTime.month}월',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
              child: Image(image: AssetImage('assets/images/line_divider.png')),
            ),
            SizedBox(
              width: layoutWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    '내 정보',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: layoutWidth,
                    height: 40,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.mainDeepOrange, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FutureBuilder(
                      future: _userProfile,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                '레벨 순위              ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text('전체 $rank위',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.orange)),
                              const Text(
                                '       |       ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Lv. ${snapshot.data?.userLevel}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          );
                        } else {
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '레벨 순위              ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text('순위 없음',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.orange)),
                              Text(
                                '       |       ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Lv. ?',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    '이번 달 랭킹',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: layoutWidth,
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 210,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.mainDeepOrange, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: FutureBuilder(
                      future: _rankedUserList,
                      builder: (context, snapshot) {
                        print(snapshot.toString());

                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < 3) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              height: 25,
                                              child: const Image(
                                                  image: AssetImage(
                                                      'assets/icons/icon_gold_medal.png')),
                                            ),
                                            Container(
                                              width: 150,
                                              height: 40,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '  ${snapshot.data?[index]?.userName}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text('${index + 1}위',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: _setRankingTextColor(
                                                        index))),
                                            const Text(
                                              '     |     ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${snapshot.data?[index]?.userExp}  pts',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Image(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            image: const AssetImage(
                                                'assets/images/line_divider.png')),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 40,
                                              margin: const EdgeInsets.only(
                                                  left: 35),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '  ${snapshot.data?[index]?.userName}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Text('${index + 1}위',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: _setRankingTextColor(
                                                        index))),
                                            const Text(
                                              '     |     ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${snapshot.data?[index]?.userExp}  pts',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Image(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            image: const AssetImage(
                                                'assets/images/line_divider.png')),
                                      ],
                                    ),
                                  );
                                }
                              });
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const Text(
              '순위권에 오른 플레이어분께는\n매월 말일 특별한 보상이 지급됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
