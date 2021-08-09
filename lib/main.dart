import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Random random = new Random();

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: b0dh(),
      ),
    ),
  );
}

// ignore: camel_case_types, must_be_immutable
class b0dh extends StatefulWidget {
  @override
  _b0dhState createState() => _b0dhState();
}

// ignore: camel_case_types
class _b0dhState extends State<b0dh> {
  bool gameStart = false;
  List<dynamic> liste = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

  List<String> letterList = [
    " ",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
  ];

  List<Color> colorsList = [
    Color(0xffFFF5F5),
    Color(0xffFFE8E8),
    Color(0xffFFD1D1),
    Color(0xffFFB9B9),
    Color(0xffFFA2A2),
    Color(0xffFF8B8B),
    Color(0xffFF7474),
    Color(0xffFF5D5D),
    Color(0xffFF4646),
    Color(0xffFF2E2E),
    Color(0xffFF1717),
    Color(0xffFF0000),
  ];
  Color bgColor = Colors.orange.shade50;
  Color dark = Color(0xff313131);

  List<int> tileGrid = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int score = 0;
  int bestScore = 0;

  void updateScore() {
    int sum = 0;
    for (var i = 0; i < 16; i++) {
      sum += tileGrid[i];
    }
    score = sum;
  }

  void spawnLetter() {
    List<int> emptyTileIndex = [];
    for (var i = 0; i < 16; i++) {
      if (tileGrid[i] == 0) {
        emptyTileIndex.add(i);
      }
    }

    if (emptyTileIndex.length == 0) {
      resetGame();
    } else {
      int randomIndex;
      setState(() {
        randomIndex = random.nextInt(emptyTileIndex.length);
        tileGrid[emptyTileIndex[randomIndex]] += 1;
      });
    }

    updateScore();
  }

  void resetGame() {
    setState(() {
      if (score > bestScore) {
        bestScore = score;
      }
      tileGrid = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
      score = 0;
      gameStart = false;
    });
  }

  void swipeLeft() {
    // MERGING
    for (var i = 1; i < 4; i++) {
      for (var j = 0; j <= 12; j += 4) {
        int index = i + j;
        if (tileGrid[index] != 0 && tileGrid[index - 1] == tileGrid[index]) {
          tileGrid[index - 1] = tileGrid[index] + 1;
          tileGrid[index] = 0;
        }
      }
    }

    //SLIDING
    for (var k = 0; k < 3; k++) {
      for (var i = 1; i < 4; i++) {
        for (var j = 0; j <= 12; j += 4) {
          int index = i + j;
          if (tileGrid[index] != 0 && tileGrid[index - 1] == 0) {
            tileGrid[index - 1] = tileGrid[index];
            tileGrid[index] = 0;
          }
        }
      }
    }
  }

  void swipeUp() {
    // MERGING
    for (var i = 4; i < 8; i++) {
      for (var j = 0; j <= 8; j += 4) {
        int index = i + j;
        if (tileGrid[index] != 0 && tileGrid[index - 4] == tileGrid[index]) {
          tileGrid[index - 4] = tileGrid[index] + 1;
          tileGrid[index] = 0;
        }
      }
    }

    //SLIDING
    for (var k = 0; k < 3; k++) {
      for (var i = 4; i < 8; i++) {
        for (var j = 0; j <= 8; j += 4) {
          int index = i + j;
          if (tileGrid[index] != 0 && tileGrid[index - 4] == 0) {
            tileGrid[index - 4] = tileGrid[index];
            tileGrid[index] = 0;
          }
        }
      }
    }
  }

  void swipeDown() {
    // MERGING
    for (var i = 8; i < 12; i++) {
      for (var j = 0; j <= 8; j += 4) {
        int index = i - j;
        if (tileGrid[index] != 0 && tileGrid[index + 4] == tileGrid[index]) {
          tileGrid[index + 4] = tileGrid[index] + 1;
          tileGrid[index] = 0;
        }
      }
    }

    //SLIDING
    for (var k = 0; k < 3; k++) {
      for (var i = 0; i < 4; i++) {
        for (var j = 0; j <= 8; j += 4) {
          int index = i + j;
          if (tileGrid[index] != 0 && tileGrid[index + 4] == 0) {
            tileGrid[index + 4] = tileGrid[index];
            tileGrid[index] = 0;
          }
        }
      }
    }
  }

  void swipeRight() {
    // MERGING
    for (var i = 3; i <= 15; i += 4) {
      for (var j = 0; j < 3; j++) {
        int ind = i - j;
        if (tileGrid[ind] != 0 && tileGrid[ind - 1] == tileGrid[ind]) {
          tileGrid[ind - 1] = tileGrid[ind] + 1;
          tileGrid[ind] = 0;
        }
      }
    }

    // SLIDING
    for (var k = 0; k < 3; k++) {
      for (var i = 0; i < 3; i++) {
        for (var j = 0; j <= 12; j += 4) {
          int ind = i + j;
          if (tileGrid[ind] != 0 && tileGrid[ind + 1] == 0) {
            tileGrid[ind + 1] = tileGrid[ind];
            tileGrid[ind] = 0;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade50,
      child: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy < -250) {
              //swipeUp();
            } else if (details.velocity.pixelsPerSecond.dy > 250) {
              //swipeDown();
            }
          },
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx < -1000) {
              //swipeLeft();
            } else if (details.velocity.pixelsPerSecond.dx > 1000) {
              //swipeRight();
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: TextButton(
                        onPressed: () {
                          if (gameStart == false) {
                            spawnLetter();
                            updateScore();
                            gameStart = true;
                          }
                        },
                        child: Text(
                          "B0DH",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: dark),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: dark,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "SCORE\n$score",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade50,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff313131),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "BEST\n$bestScore",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Join the numbers and get to the Z tile.\nPress B0DH to start!",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: dark,
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  childAspectRatio: 1,
                  primary: false,
                  padding: EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: <Widget>[
                    // TILES STARTS HERE ////////////////////////////////////////////////////////////////////////////
                    // TILE 0
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[0]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[0]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 1
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[1]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[1]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 2
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[2]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[2]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 3
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[3]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[3]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 4
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[4]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[4]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 5
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[5]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[5]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 6
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[6]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[6]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 7
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[7]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[7]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 8
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[8]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[8]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 9
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[9]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[9]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 10
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[10]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[10]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 11
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[11]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[11]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 12
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[12]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[12]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 13
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[13]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[13]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 14
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[14]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[14]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                    // TILE 15
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colorsList[tileGrid[15]],
                      ),
                      child: Center(
                        child: Text("${letterList[tileGrid[15]]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32)),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: dark, borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        if (gameStart) {
                          setState(() {
                            swipeLeft();
                            spawnLetter();
                          });
                        }
                      },
                      child: Text("LEFT", style: TextStyle(color: bgColor)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: dark, borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        if (gameStart) {
                          swipeUp();
                          spawnLetter();
                        }
                      },
                      child: Text("UP", style: TextStyle(color: bgColor)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: dark, borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        if (gameStart) {
                          swipeDown();
                          spawnLetter();
                        }
                      },
                      child: Text("DOWN", style: TextStyle(color: bgColor)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: dark, borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        if (gameStart) {
                          swipeRight();
                          spawnLetter();
                        }
                      },
                      child: Text("RIGHT", style: TextStyle(color: bgColor)),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  resetGame();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: dark),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "RESTART",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange.shade50),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
