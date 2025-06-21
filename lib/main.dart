import 'package:flutter/material.dart';
// import 'package:vivi/effects.dart';
import 'package:vivi/birth.dart';
import 'package:vivi/splash.dart';
import 'package:audioplayers/audioplayers.dart'; // create this

void main() {
  runApp(const Plady());
}

class Plady extends StatelessWidget {
  const Plady({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happy Popo',
      home: love(), //splash screen
    );
  }
}

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  //music

  late final AudioPlayer _backgroundPlayer;
  late final AudioPlayer _effectPlayer;

  @override
  void initState() {
    super.initState();

    _backgroundPlayer = AudioPlayer();
    _effectPlayer = AudioPlayer();

    _playBackgroundAudio();
  }

  void _playBackgroundAudio() async {
    await _backgroundPlayer.play(
      AssetSource('fav2.mp3'),
      volume: 0.5,
    ); // loop optional
    _backgroundPlayer.setReleaseMode(
      ReleaseMode.loop,
    ); // optional: loop forever
  }

  void _playCakeSound() async {
    await _effectPlayer.stop(); // stop if already playing
    await _effectPlayer.play(AssetSource('fav1.mp3'));
  }

  void _stopAllAudio() async {
    await _backgroundPlayer.stop();
    await _effectPlayer.stop();
  }

  @override
  void dispose() {
    _backgroundPlayer.dispose();
    _effectPlayer.dispose();
    super.dispose();
  }

  // card ke liye

  void showBalloonOverlay(BuildContext context) {
    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    final balloons = OverlayEntry(
      builder: (_) => const Positioned.fill(
        child: IgnorePointer(child: AnimatedBalloons()),
      ),
    );

    // Wait until the current frame finishes building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      overlay.insert(balloons);
    });

    // Remove after 4 seconds
    Future.delayed(const Duration(seconds: 4), () => balloons.remove());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Happy birthday"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 🎀 Top Banner Text
            const Text(
              "Vaishnavi",
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Cursive',
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // 🎈 Banner PNG
            Image.asset(
              'assets/banner.png',
              width: double.infinity,
              height: 60,
              fit: BoxFit.contain,
            ),

            // 🎈 Balloon PNG
            Image.asset(
              'assets/Balloon-Border.png',
              width: double.infinity,
              height: 60,

              fit: BoxFit.contain,
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BirthdayScreen(),
                  ),
                );
              },
              child: Container(
                height: 300,
                width: 250,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/human.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.red, //
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                _playCakeSound();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    showBalloonOverlay(context); // call the balloon animation
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: const Text("🎉 Surprise!"),
                      content: const Text("Happy Birthday from OShiv! 💖"),
                      actions: [
                        TextButton(
                          child: const Text(" thank u Oshiv !"),
                          onPressed: () {
                            _stopAllAudio();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Image.asset('assets/cake.gif', height: 120),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class AnimatedBalloons extends StatefulWidget {
  const AnimatedBalloons({super.key});

  @override
  State<AnimatedBalloons> createState() => _AnimatedBalloonsState();
}

class _AnimatedBalloonsState extends State<AnimatedBalloons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Positioned(
          bottom: screenHeight * _animation.value,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: 1.0 - _animation.value,
            child: Image.asset(
              'assets/Balloon-Border.png',
              width: 200,
              height: 60,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
