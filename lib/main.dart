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
  //int bestScore = 0;

  void updateScore() {
    int sum = 0;
    for (var i = 0; i < 16; i++) {
      sum += tileGrid[i];
    }
    score = sum;
  }

  void spawnLetter() {
    // Looks for max value on the grid
    int maxTile = tileGrid.reduce(max);
    int maxValue = 1;
    if (maxTile >= 5) {
      maxValue = maxTile - 4;
    }

    // Looks for empty tiles on the grid
    List<int> emptyTileIndex = [];
    for (var i = 0; i < 16; i++) {
      if (tileGrid[i] == 0) {
        emptyTileIndex.add(i);
      }
    }

    // Resets the game if there is no empty tile,
    // Spawns one tile if there is at least one.
    if (emptyTileIndex.length == 0) {
      resetGame();
    } else {
      int randomIndex;
      setState(() {
        // Spawns a tile with max -5 value of max tile
        int randomValue = random.nextInt(maxValue) + 1;
        randomIndex = random.nextInt(emptyTileIndex.length);
        tileGrid[emptyTileIndex[randomIndex]] += randomValue;
      });
    }

    updateScore();
  }

  void resetGame() {
    setState(() {
      /*
      if (score > bestScore) {
        bestScore = score;

        /////////////// WRITING BEST SCORE INTO A FILE WILL BE HERE
      }*/
      tileGrid = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
      score = 0;
      gameStart = false;
    });
  }

  void swipeLeft() {
    // CHECK IF GRID CAN MOVE LEFT
    int count = 0;
    for (var i = 1; i < 4; i++) {
      for (var j = 0; j <= 12; j += 4) {
        int index = i + j;
        if ((tileGrid[index] != 0) &&
            ((tileGrid[index - 1] == 0) ||
                (tileGrid[index - 1] == tileGrid[index]))) {
          count += 1;
        }
      }
    }

    // IF CAN GRID MOVE LEFT:
    if (count > 0) {
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
      spawnLetter();
    }
  }

  void swipeUp() {
    // CHECK IF GRID CAN MOVE UP

    int count = 0;
    for (var i = 4; i < 8; i++) {
      for (var j = 0; j <= 8; j += 4) {
        int index = i + j;
        if ((tileGrid[index] != 0) &&
            ((tileGrid[index - 4] == 0) ||
                (tileGrid[index - 4] == tileGrid[index]))) {
          count += 1;
        }
      }
    }

    // IF CAN GRID MOVE UP:
    if (count > 0) {
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

      spawnLetter();
    }
  }

  void swipeDown() {
    // CHECK IF GRID CAN MOVE DOWN

    int count = 0;
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j <= 8; j += 4) {
        int index = i + j;
        if ((tileGrid[index] != 0) &&
            ((tileGrid[index + 4] == 0) ||
                (tileGrid[index + 4] == tileGrid[index]))) {
          count += 1;
        }
      }
    }

    // IF CAN GRID MOVE DOWN:
    if (count > 0) {
      // MERGING
      for (var i = 0; i < 4; i++) {
        for (var j = 0; j <= 8; j += 4) {
          int index = i + j;
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

      spawnLetter();
    }
  }

  void swipeRight() {
    // CHECK IF GRID CAN MOVE RIGHT
    int count = 0;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j <= 12; j += 4) {
        int index = i + j;
        if ((tileGrid[index] != 0) &&
            ((tileGrid[index + 1] == 0) ||
                (tileGrid[index + 1] == tileGrid[index]))) {
          count += 1;
        }
      }
    }

    // IF CAN GRID MOVE RIGHT:
    if (count > 0) {
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

      spawnLetter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: SafeArea(
        child: SizedBox.expand(
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (gameStart == true) {
                if (details.velocity.pixelsPerSecond.dy < -250) {
                  swipeUp();
                } else if (details.velocity.pixelsPerSecond.dy > 250) {
                  swipeDown();
                }
              }
            },
            onHorizontalDragEnd: (details) {
              if (gameStart == true) {
                if (details.velocity.pixelsPerSecond.dx < -1000) {
                  swipeLeft();
                } else if (details.velocity.pixelsPerSecond.dx > 1000) {
                  swipeRight();
                }
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "B0DH",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: dark),
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
                            color: bgColor,
                          ),
                        ),
                      ),
                      /* /// BEST SCORE BOX
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
                      ),*/
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Join the numbers and get to the Z tile.\n",
                        textAlign: TextAlign.center,
                      ),
                      Visibility(
                        visible: gameStart == false,
                        child: TextButton(
                          onPressed: () {
                            spawnLetter();
                            updateScore();
                            gameStart = true;
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: dark,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "START",
                              style: TextStyle(
                                  color: bgColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                    children: [
                      for (var i in liste)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colorsList[tileGrid[i]],
                          ),
                          child: Center(
                            child: Text("${letterList[tileGrid[i]]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32)),
                          ),
                        )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    resetGame();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: dark),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 45),
                      child: Text(
                        "RESTART",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: bgColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
