import 'package:flutter/material.dart';
import 'package:cs_onecup/core/widgets/simplecardwidget.dart';

class CardsInHand extends StatelessWidget {
  const CardsInHand({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(-60, 0),
          child: Transform.rotate(
            angle: -0.4,
            child: const SimpleCardwidget(),
          ),
        ),
        Transform.translate(
          offset: const Offset(-30, 0),
          child: Transform.rotate(
            angle: -0.2,
            child: const SimpleCardwidget(),
          ),
        ),
        Transform.rotate(
          angle: 0,
          child: const SimpleCardwidget(),
        ),
        Transform.translate(
          offset: const Offset(30, 10),
          child: Transform.rotate(
            angle: 0.2,
            child: const SimpleCardwidget(),
          ),
        ),
        Transform.translate(
          offset: const Offset(60, 20),
          child: Transform.rotate(
            angle: 0.4,
            child: const SimpleCardwidget(),
          ),
        ),
      ],
    );
  }
}
