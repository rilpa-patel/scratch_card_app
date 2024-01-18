import 'dart:developer';

import 'package:flutter/material.dart';
import './ScrachCardWidget.dart';
import './AlertDialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> scratchCards = [];
  TextEditingController rangeController = TextEditingController();
  List<int> opencard = [];

  setchange(value) {
    setState(() {
      opencard.add(value);
    });
    log(opencard.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scratch Card App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/nature1.jpg'),
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: rangeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter the range of cards',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (rangeController.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Must Add Number"),
                ));
              } else {
                int numberOfScratchCards = int.parse(rangeController.text);
                setState(() {
                  rangeController.text = "";
                  scratchCards =
                      List.generate(numberOfScratchCards, (index) => index + 1);
                  opencard.clear();
                  FocusScope.of(context).unfocus();
                });
              }
            },
            child: const Text('Submit', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(
            height: 12,
          ),
          scratchCards.isNotEmpty
              ? Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: scratchCards.length,
                    itemBuilder: (context, index) {
                      return ScratchCardWidget(
                        scratchCardNumber: scratchCards[index],
                        rewardAmount: getRewardAmount(index),
                        opencard: opencard,
                        indexvalue: index,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialogWidget(
                                  setchange: setchange,
                                  rewardAmount: getRewardAmount(index),
                                  index: index,
                                  opencard: opencard);
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  int getRewardAmount(int index) {
    if (index % 2 == 0) {
      return index % 4 == 0 ? 10 : 15;
    } else {
      return index % 4 == 1 ? 15 : 10;
    }
  }

  @override
  void dispose() {
    rangeController.dispose();
    super.dispose();
  }
}
