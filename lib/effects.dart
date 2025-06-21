import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

/// 🎇 Fireworks Overlay
void showFireworksOverlay(BuildContext context) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (_) => const FireworkOverlay(),
  );
  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 3), () => entry.remove());
}

class FireworkOverlay extends StatefulWidget {
  const FireworkOverlay({super.key});

  @override
  State<FireworkOverlay> createState() => _FireworkOverlayState();
}

class _FireworkOverlayState extends State<FireworkOverlay> {
  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ConfettiWidget(
        confettiController: _controller,
        blastDirectionality: BlastDirectionality.explosive,
        emissionFrequency: 0.2,
        numberOfParticles: 30,
        gravity: 0.3,
        colors: const [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.orange,
          Colors.purple,
        ],
      ),
    );
  }
}

/// 🎈 Balloon Overlay
void showBalloonOverlay(BuildContext context) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (_) => Stack(
      children: List.generate(
        5,
        (i) => Positioned(
          bottom: 0,
          left: 60.0 * i,
          child: AnimatedBalloon(delay: i * 0.2),
        ),
      ),
    ),
  );
  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 4), () => entry.remove());
}

class AnimatedBalloon extends StatelessWidget {
  final double delay;
  const AnimatedBalloon({super.key, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, -1)),
      duration: const Duration(seconds: 4),
      curve: Curves.easeOut,
      builder: (_, offset, __) => Transform.translate(
        offset: Offset(0, offset.dy * MediaQuery.of(context).size.height),
        child: Opacity(
          opacity: 1 - offset.dy.abs(),
          child: Image.asset('assets/Balloon-Border.png', width: 80),
        ),
      ),
    );
  }
}
