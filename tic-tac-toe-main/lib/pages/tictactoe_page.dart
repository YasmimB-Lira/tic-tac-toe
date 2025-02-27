import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/main_color.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;
  bool gameStarted = false;

  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer? timer;

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  void startTimer() {
    stopTimer();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          _switchTurn();
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Player O', style: customFontWhite),
                      Text(oScore.toString(), style: customFontWhite),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Player X', style: customFontWhite),
                      Text(xScore.toString(), style: customFontWhite),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 5, color: MainColor.primaryColor),
                        color: matchedIndexes.contains(index)
                            ? MainColor.accentColor
                            : MainColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              fontSize: 64,
                              color: matchedIndexes.contains(index)
                                  ? MainColor.secondaryColor
                                  : MainColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    )  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultDeclaration, style: customFontWhite),
                    const SizedBox(height: 10),
                    if (!gameStarted && resultDeclaration.isEmpty)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            gameStarted = true;
                            startTimer();
                          });
                        },
                        child: Text('Iniciar Tempo'),
                      ),
                    if (resultDeclaration.isEmpty) _buildTimer(),
                    if (resultDeclaration.isNotEmpty)
                      ElevatedButton(
                        onPressed: _restartGame,
                        child: Text('Restart Game'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    if (winnerFound || displayXO[index] != '') return;

    if (!gameStarted) {
      gameStarted = true;
      startTimer();
    }

    setState(() {
      displayXO[index] = oTurn ? 'O' : 'X';
      filledBoxes++;
      _checkWinner();
      if (!winnerFound) {
        _switchTurn();
      }
    });
  }

  void _switchTurn() {
    setState(() {
      oTurn = !oTurn;
      resetTimer();
      startTimer();
    });
  }

  void _checkWinner() {
    List<List<int>> winningCombos = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [6, 4, 2],
    ];

    for (List<int> combo in winningCombos) {
      int a = combo[0], b = combo[1], c = combo[2];
      if (displayXO[a] == displayXO[b] && displayXO[a] == displayXO[c] && displayXO[a] != '') {
        setState(() {
          resultDeclaration = 'Player ${displayXO[a]} Wins!';
          matchedIndexes.addAll([a, b, c]);
          winnerFound = true;
          stopTimer();
          _updateScore(displayXO[a]);
        });
        return;
      }
    }

    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'It\'s a Draw!';
        stopTimer();
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  Widget _buildTimer() {
    return Text(
      '$seconds',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 50,
      ),
    );
  }

  void _restartGame() {
    setState(() {
      stopTimer();
      displayXO = List.filled(9, '');
      matchedIndexes.clear();
      filledBoxes = 0;
      resultDeclaration = '';
      winnerFound = false;
      gameStarted = false;
      oTurn = true;
      resetTimer();
    });
  }
}
