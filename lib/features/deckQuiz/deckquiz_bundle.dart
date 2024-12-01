import 'package:flutter/material.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/core/widgets/cards/deckquiz_info_cardwidget.dart';
import 'package:cs_onecup/features/deckQuiz/deckquiz_quizepage.dart';

class DeckquizBundle extends StatefulWidget {
  final String _deckName;
  final String _deckHashTag;
  final int _deckLength;
  final Map _deckCategoryInfo;

  const DeckquizBundle({
    super.key,
    required String deckName,
    required String deckHashTag,
    required int deckLength,
    required Map deckCategoryInfo,
  })  : _deckName = deckName,
        _deckHashTag = deckHashTag,
        _deckLength = deckLength,
        _deckCategoryInfo = deckCategoryInfo;

  @override
  State<DeckquizBundle> createState() => _CardsInHandState();
}

class _CardsInHandState extends State<DeckquizBundle>
    with SingleTickerProviderStateMixin {
  double _dragOffsetY = 0.0;
  final double _dragDistance = -300.0; // 이동할 거리

  late AnimationController _controller;
  late Animation<double> _animation;

  final double scaleFactor = 1.8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.addListener(() {
      setState(() {
        _dragOffsetY = _animation.value * _dragDistance;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward(from: 0.0).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DeckquizQuizpage(),
        ),
      ).then((_) {
        setState(() {
          _dragOffsetY = 0.0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy < 0) {
          _startAnimation();
        }
      },
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -10),
            child: IconCardwidget(
              scaleFactor: scaleFactor,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -5),
            child: IconCardwidget(
              scaleFactor: scaleFactor,
            ),
          ),
          Transform.translate(
            offset: Offset(0, _dragOffsetY),
            child: Hero(
              tag: 'deck_to_Quiz_Card',
              child: IconCardwidget(
                scaleFactor: scaleFactor,
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 5),
            child: IconCardwidget(
              scaleFactor: scaleFactor,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, 10),
            child: DeckquizInfoCardwidget(
              scaleFactor: scaleFactor,
              deckName: widget._deckName,
              deckHashTag: widget._deckHashTag,
              deckLength: widget._deckLength,
              deckCategoryInfo: widget._deckCategoryInfo,
            ),
          ),
        ],
      ),
    );
  }
}
