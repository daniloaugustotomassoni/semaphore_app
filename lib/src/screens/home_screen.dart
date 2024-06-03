import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Timer timer;
  double temp = 1;
  bool isAuto = false;
  Color red = Colors.redAccent;
  Color yellow = Colors.yellowAccent;
  Color green = Colors.lightGreen;
  List<bool> listIsClicked = [false, false, false];

  start() async {
    setState(() {
      listIsClicked = [false, false, false];
      temp = 1;
    });
    int count = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      count += 1;
      setState(() {
        temp += 1;
        if (temp > 10) {
          temp = 1;
        }
        if (count <= 10) {
          listIsClicked[0] = !listIsClicked[0];
        }
        if (count > 10 && count <= 20) {
          listIsClicked[1] = !listIsClicked[1];
        }
        if (count > 20 && count <= 30) {
          listIsClicked[2] = !listIsClicked[2];
        }
        if (count > 30) {
          count = 0;
        }
      });
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AUTO',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: isAuto ? Colors.white : Colors.grey),
              ).animate(controller: animationController).scale().fade(),
              const SizedBox(
                width: 24,
              ),
              Switch(
                activeColor: Colors.blue,
                value: isAuto,
                onChanged: (value) {
                  animationController.forward(from: 0);
                  setState(() {
                    isAuto = !isAuto;
                  });
                  if (isAuto) start();
                  if (!isAuto) timer.cancel();
                },
              ),
            ],
          ),
          isAuto
              ? Container(
                  margin: EdgeInsets.zero,
                  child: Text(
                    '${temp.toStringAsFixed(0)}s',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.width * .4,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: BorderDirectional(
                    start: BorderSide(width: 5, color: Colors.grey.shade800),
                    bottom: BorderSide(width: 5, color: Colors.grey.shade800),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    _signalState(0, Colors.redAccent, listIsClicked[0]),
                    _signalState(1, Colors.yellowAccent, listIsClicked[1]),
                    _signalState(2, Colors.lightGreenAccent, listIsClicked[2]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signalState(int index, Color color, bool isClicked) {
    double radius = 96;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isAuto) {
            HapticFeedback.vibrate();
            setState(() {
              for (var isClick in listIsClicked) {
                listIsClicked[index] = !isClicked;
              }
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isClicked ? color : Colors.grey.shade900,
            //border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
            boxShadow: isClicked
                ? [BoxShadow(color: color, blurRadius: 150, spreadRadius: 30)]
                : [],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
