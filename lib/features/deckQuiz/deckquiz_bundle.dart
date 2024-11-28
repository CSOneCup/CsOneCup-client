import 'package:flutter/material.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/features/quiz/quizepage.dart';

class DeckquizBundle extends StatefulWidget {
  const DeckquizBundle({super.key});

  @override
  State<DeckquizBundle> createState() => _CardsInHandState();
}

class _CardsInHandState extends State<DeckquizBundle>
    with SingleTickerProviderStateMixin {
  double _dragOffsetY = 0.0;
  final double _dragDistance = -300.0; // 이동할 거리

  late AnimationController _controller;
  late Animation<double> _animation;

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
          builder: (context) => const QuizPage(),
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
            offset: const Offset(0, 10),
            child: const IconCardwidget(),
          ),
          Transform.translate(
            offset: const Offset(0, 5),
            child: const IconCardwidget(),
          ),
          Transform.translate(
            offset: Offset(0, _dragOffsetY),
            child: const Hero(
              tag: 'deck_to_Quiz_Card',
              child: IconCardwidget(),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -5),
            child: const IconCardwidget(),
          ),
          Transform.translate(
            offset: const Offset(0, -10),
            child: const IconCardwidget(),
          ),
        ],
      ),
    );
  }
}
