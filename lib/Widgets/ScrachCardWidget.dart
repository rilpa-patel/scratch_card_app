import 'dart:developer';

import 'package:flutter/material.dart';

class ScratchCardWidget extends StatelessWidget {
  final int scratchCardNumber;
  final int rewardAmount;
  final VoidCallback onTap;
  final List<int> opencard;
  final int indexvalue;
  const ScratchCardWidget(
      {super.key,
      required this.scratchCardNumber,
      required this.rewardAmount,
      required this.onTap,
      required this.opencard,
      required this.indexvalue});

  @override
  Widget build(BuildContext context) {
    return !opencard.contains(indexvalue)
        ? GestureDetector(
            onTap: onTap,
            child: Card(
              child: Image.asset(
                'assets/images/screen1.jpg',
              ),
            ))
        : Card(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/screen1.jpg',
                  opacity: const AlwaysStoppedAnimation(.4),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$rewardAmount rs/-',
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You Have Received!!',
                        style: const TextStyle(
                          fontSize: 23,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
