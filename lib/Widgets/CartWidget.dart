import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:confetti/confetti.dart';
import 'package:just_audio/just_audio.dart';


class CartWidget extends StatefulWidget {
  final int rewardAmount;
  final Function setchange;
  final int index;
  final List<int> opencard;
  const CartWidget(
      {required this.rewardAmount,required this.setchange,required this.index,required this.opencard,super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  late ConfettiController _confettiController;
    bool _confettiTriggered = false;
  final AudioPlayer player = AudioPlayer();



  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );  
    player.setAsset("assets/audio.mp3");
    player.setClip(start: Duration(seconds: 0), end: Duration(seconds: 2));
  }

  

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

    void _triggerConfetti() {
    if (!_confettiTriggered) {
      _confettiController.play();
      _confettiTriggered = true;
    }
  }

  @override
  Widget build(BuildContext context) {


    return Card(
      child: Scratcher(
              brushSize: 30,
              threshold: 50,
              image: Image.asset('assets/images/close.jpg'),
              onChange: (value) => print("Scratch progress: $value%"),
              onScratchEnd: () {
                player.play();
               _triggerConfetti();
                widget.setchange(widget.index);
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 5,
                  ),
                ),
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: Image.asset('assets/images/open.png'),
                      ),
                    ),
                    ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirection: -1.5 * -3.14,
                      emissionFrequency: 0.05,
                      numberOfParticles: 10,
                      gravity: 0.1,
                      shouldLoop: false,
                      colors: const [Colors.green, Colors.blue, Colors.pink],
                    ),
                    const Text('Yeahh you win!!'),
                    Text(
                      '${widget.rewardAmount} rs',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                )),
              ),
            ),
     );
  }
}
