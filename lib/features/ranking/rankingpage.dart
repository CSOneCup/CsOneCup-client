import 'package:cs_onecup/core/constants/colors.dart';
import 'package:cs_onecup/features/home/userprofile.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  DateTime _dateTime = DateTime.now();
  UserProfile _userProfile = UserProfile(userLevel: 23, userName: 'TestUser', userExp: 2100);
  int rank = 8;
  List<UserProfile> rankedUserList = <UserProfile>[
    UserProfile(userLevel: 30, userName: 'Test1', userExp: 5000),
    UserProfile(userLevel: 29, userName: 'Test2', userExp: 4500),
    UserProfile(userLevel: 28, userName: 'Test3', userExp: 4000),
    UserProfile(userLevel: 27, userName: 'Test4', userExp: 3500),
    UserProfile(userLevel: 26, userName: 'Test5', userExp: 3000),
    UserProfile(userLevel: 25, userName: 'Test6', userExp: 2500),
    UserProfile(userLevel: 24, userName: 'Test7', userExp: 2300),
    UserProfile(userLevel: 24, userName: 'TestUser', userExp: 2100),
  ];

  void _calculateRank() {
    // 여기에 순위 직접 계산 or 서버로부터 받아오는 로직 작성
  }

  Color _setRankingTextColor(int index) {
    if(index == 0) {
      return Colors.yellow;
    } else if(index == 1) {
      return Colors.grey;
    } else if(index == 2) {
      return Colors.brown;
    } else {
      return Colors.black;
    }
  }
  
  Color _setMyRankingFieldBackground(int index) {
    if(rankedUserList[index].userName == _userProfile.userName) {
      return AppColors.lightBeige;
    } else {
      return Colors.white;
    }
  }

  @override
  void initState() {
    _calculateRank();
    super.initState();
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
            Container(
              width: 80,
              height: 80,
              child: const Image(
                  image: AssetImage('assets/images/ranking_crown.png')
              ),
            ),
            Text('${_dateTime.year}년 ${_dateTime.month}월', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Container(
              height: 20,
              child: const Image(
                image: AssetImage('assets/images/line_divider.png')
              ),
            ),
            Container(
              width: layoutWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('내 정보', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: layoutWidth,
                    height: 40,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainDeepOrange, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('레벨 순위              ',
                          style: TextStyle(fontSize: 16, color: Colors.black,),),
                        Text('전체 ${rank}위',
                          style: const TextStyle(fontSize: 16, color: Colors.orange)),
                        const Text('       |       ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Text('Lv. ${_userProfile.userLevel}',
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text('이번 달 랭킹', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: layoutWidth,
                    margin: EdgeInsets.only(bottom: 20),
                    height: 210,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.mainDeepOrange, width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      itemCount: rankedUserList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(index < 3) {
                          return Container(
                            color: _setMyRankingFieldBackground(index),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      height: 25,
                                      child: const Image(
                                          image: AssetImage('assets/icons/icon_gold_medal.png')
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 40,
                                      alignment: Alignment.centerLeft,
                                      child: Text('  ${rankedUserList[index].userName}',
                                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                                    ),
                                    Text('${index + 1}위',
                                        style: TextStyle(fontSize: 16, color: _setRankingTextColor(index))),
                                    const Text('     |     ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    Text('${rankedUserList[index].userExp}  pts',
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Image(
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    image: AssetImage('assets/images/line_divider.png')
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            color: _setMyRankingFieldBackground(index),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 40,
                                      margin: EdgeInsets.only(left: 35),
                                      alignment: Alignment.centerLeft,
                                      child: Text('  ${rankedUserList[index].userName}',
                                        style: TextStyle(fontSize: 16, color: Colors.black,),),
                                    ),
                                    Text('${index + 1}위',
                                        style: TextStyle(fontSize: 16, color: _setRankingTextColor(index))),
                                    const Text('     |     ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    Text('${rankedUserList[index].userExp}  pts',
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Image(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  image: AssetImage('assets/images/line_divider.png')
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const Text('순위권에 오른 플레이어분께는\n매월 말일 특별한 보상이 지급됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
            ),
          ],
        ),
      ),
    );
  }
}
