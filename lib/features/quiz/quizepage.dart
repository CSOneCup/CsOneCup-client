import 'package:flutter/material.dart';
import 'package:cs_onecup/core/constants/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/answercardwidget.dart';
import 'package:cs_onecup/core/constants/colors.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _scaleFactor = 2.0;
  double _dragOffset = 0;
  //final double _dragDistance = -300.0;
  double get _dragDistance => -(MediaQuery.of(context).size.height - 200);

  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    super.initState();
    // 일정 시간이 지난 후 카드를 뒤집음
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_cardKey.currentState != null && _cardKey.currentState!.isFront) {
        _cardKey.currentState!.toggleCard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.mainLightGray,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.mainDeepOrange,
                ),
              ),
            ),
            const Positioned(
              bottom: 30,
              left: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    child: Text(
                      '지금까지 푼 문제',
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 50,
                      color: AppColors.mainDeepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(
                      '7',
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    child: Text(
                      '문',
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Hero(
                tag: 'Home_to_Quiz_iconCard',
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  transform: Matrix4.translationValues(0, _dragOffset, 0),
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.delta.dy < 0) {
                        setState(() {
                          _dragOffset = _dragDistance;
                        });
                      } else if (details.delta.dy > 0) {
                        setState(() {
                          _dragOffset = 0;
                        });
                      }
                    },
                    child: FlipCard(
                      key: _cardKey,
                      direction: FlipDirection.HORIZONTAL,
                      side: CardSide.FRONT,
                      flipOnTouch: false,
                      front: IconCardwidget(
                        scaleFactor: _scaleFactor,
                      ),
                      back: QuizCardwidget(
                        scaleFactor: _scaleFactor,
                        quizCategory: '소프트웨어공학',
                        quizExplanation: '운영체제가 제공하는 기능에 해당하지 않는 것은 무엇인가요?',
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
