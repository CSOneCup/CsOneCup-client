import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';

class QuizpageCardwidget extends StatefulWidget {
  final String _quizCategory;
  final String _quizExplanation;

  const QuizpageCardwidget(
      {super.key,
      required String quizCategory,
      required String quizExplanation})
      : _quizCategory = quizCategory,
        _quizExplanation = quizExplanation;

  @override
  State<QuizpageCardwidget> createState() => _QuizpageCardwidgetState();
}

class _QuizpageCardwidgetState extends State<QuizpageCardwidget> {
  final _scaleFactor = 2.0;
  double _dragOffset = 0;
  late double _dragDistance;
  bool _loading = true;

  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();

  //TODO : 나중에 서버에서 데이터 받아오기 전에는 icon 보여주다가, 데이터 받아오면 quiz로 변경되게 설계 (시간말고 loading 변수로 조절)

  @override
  void initState() {
    super.initState();
    _dragDistance = 285 * _scaleFactor - 80;

    // 일정 시간이 지난 후 카드를 뒤집음
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_cardKey.currentState != null && _cardKey.currentState!.isFront) {
        _cardKey.currentState!.toggleCard();
      }
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Home_to_Quiz_iconCard',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _dragOffset, 0),
        child: GestureDetector(
          onVerticalDragUpdate: _loading
              ? null
              : (details) {
                  if (details.delta.dy < 0) {
                    setState(() {
                      _dragOffset = -_dragDistance;
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
              quizCategory: widget._quizCategory,
              quizExplanation: widget._quizExplanation,
            ),
          ),
        ),
      ),
    );
  }
}