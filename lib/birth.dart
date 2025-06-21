import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vivi/effects.dart';
import 'package:url_launcher/url_launcher.dart';

class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> giftData = [
      {'image': 'assets/Face2.jpg', 'name': 'qtyy', 'audio': 'beauty.mp3'},
      {'image': 'assets/img1.jpg', 'name': 'POPO', 'audio': 'music.mp3'},
      {'image': 'assets/img2.jpg', 'name': 'chudail', 'audio': 'beauty.mp3'},
      {'image': 'assets/img3.jpg', 'name': 'Tiamu', 'audio': 'music.mp3'},
      {
        'image': 'assets/img4.jpg',
        'name': 'Birthday Queen',
        'audio': 'music.mp3',
      },
      {'image': 'assets/img5.jpg', 'name': 'vivi', 'audio': 'music.mp3'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Birthday Wishes',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/facecard.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'Happy Birthday, Vaishnavi!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Wishing you a day filled with joy, laughter, and all your favorite things. '
                'May this year bring you endless opportunities and happiness.',
                style: TextStyle(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'For POPO Tripathi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.85,
                children: giftData.map((item) {
                  return buildGiftCard(
                    item['image']!,
                    item['name']!,
                    item['audio']!,
                    context,
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  onPressed: () async {
                    String CN = '+918788493707';
                    if (true) {
                      String url =
                          'whatsapp://send?phone="918788493707"&text="hey you are amazing Shiv mai tujhe 500 bhej rahi hu"';
                      await launchUrl(Uri.parse(url));
                    } else {
                      String url =
                          'whatsapp://send?phone="918788493707"&text="hey you are amazing shiv"';
                      await launchUrl(Uri.parse(url));
                    }
                    
                  },

                  child: const Text(
                    'Thanks for staying in our life',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGiftCard(
    String imgPath,
    String title,
    String audioFileName,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () async {
        final player = AudioPlayer();
        await player.play(AssetSource(audioFileName));

        showFireworksOverlay(context);
        showBalloonOverlay(context);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: const Text("🎉 Surprise!"),
            content: Text("Happy Birthday $title! 💖"),
            actions: [
              TextButton(
                onPressed: () async {
                  await player.stop(); // ✅ STOP the audio
                  Navigator.pop(context);
                },
                child: const Text("Thank you!"),
              ),
            ],
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imgPath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }
}
