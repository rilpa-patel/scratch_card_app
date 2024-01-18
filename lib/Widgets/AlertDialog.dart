import 'package:flutter/material.dart';
import './CartWidget.dart';

class AlertDialogWidget extends StatelessWidget {
  final int rewardAmount;
  final Function setchange;
  final int index;
  final  List<int> opencard;
  const AlertDialogWidget(
      {required this.setchange,required this.rewardAmount,required this.index,required this.opencard,super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CartWidget(rewardAmount: rewardAmount, index: index, setchange: setchange, opencard: opencard,),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
