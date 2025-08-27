import 'package:flutter/material.dart';
import 'dart:math';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller>
    with SingleTickerProviderStateMixin {
  var activeDiceImage = 'assets/images/imagedic1.jpg';
  late AnimationController _controller;
  final random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // speed of each spin
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void rollDice() async {
    // Start continuous rotation
    _controller.repeat();

    // Change images quickly to simulate rolling dice
    for (int i = 0; i < 10; i++) {
      final diceNumber = random.nextInt(6) + 1;
      setState(() {
        activeDiceImage = 'assets/images/imagedic$diceNumber.jpg';
      });
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // Stop rotation
    _controller.stop();

    // Pick a final random image
    final finalNumber = random.nextInt(6) + 1;
    setState(() {
      activeDiceImage = 'assets/images/imagedic$finalNumber.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: Image.asset(
            activeDiceImage,
            width: 180,
          ),
        ),
        const SizedBox(height: 60),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
