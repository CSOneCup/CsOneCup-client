import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/quizcardwidget.dart';

class QuizpageCardwidget extends StatefulWidget {
  final String _quizCategory;
  final String _quizExplanation;
  final String _heroTag;

  const QuizpageCardwidget(
      {super.key,
      required String heroTag,
      required String quizCategory,
      required String quizExplanation})
      : _heroTag = heroTag,
        _quizCategory = quizCategory,
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
      tag: widget._heroTag,
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
