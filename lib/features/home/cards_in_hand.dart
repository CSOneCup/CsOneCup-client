import 'package:flutter/material.dart';
import 'package:cs_onecup/core/widgets/cards/iconcardwidget.dart';
import 'package:cs_onecup/features/quiz/quizepage.dart';

class CardsInHand extends StatefulWidget {
  const CardsInHand({super.key});

  @override
  State<CardsInHand> createState() => _CardsInHandState();
}

class _CardsInHandState extends State<CardsInHand>
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
            offset: const Offset(-60, 0),
            child: Transform.rotate(
              angle: -0.4,
              child: const IconCardwidget(),
            ),
          ),
          Transform.translate(
            offset: const Offset(-30, 0),
            child: Transform.rotate(
              angle: -0.2,
              child: const IconCardwidget(),
            ),
          ),
          Transform.translate(
            offset: Offset(0, _dragOffsetY),
            child: Transform.rotate(
              angle: 0,
              child: const Hero(
                tag: 'Home_to_Quiz_iconCard',
                child: IconCardwidget(),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(30, 10),
            child: Transform.rotate(
              angle: 0.2,
              child: const IconCardwidget(),
            ),
          ),
          Transform.translate(
            offset: const Offset(60, 20),
            child: Transform.rotate(
              angle: 0.4,
              child: const IconCardwidget(),
            ),
          ),
        ],
      ),
    );
  }
}
