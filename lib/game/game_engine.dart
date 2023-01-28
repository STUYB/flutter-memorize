import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memorize/bloc/auth/auth_bloc.dart';
import 'package:memorize/bloc/game/game_bloc.dart';
import 'package:memorize/game/game.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameEngine extends StatefulWidget {
  const GameEngine({super.key});

  @override
  State<GameEngine> createState() => _GameEngineState();
}

class _GameEngineState extends State<GameEngine> {
  Game memorizeGame = Game();
  bool isEnabled = true;
  @override
  void initState() {
    super.initState();
    memorizeGame.initGame();
  }

  @override
  Widget build(BuildContext context) {
    var localizer = AppLocalizations.of(context)!;
    var authBlock = BlocProvider.of<AuthBloc>(context);
    var gameBlock = BlocProvider.of<GameBloc>(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  localizer.score,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  memorizeGame.clicks.toString(),
                  style: const TextStyle(
                      fontSize: 34.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
                child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: memorizeGame.cardCount,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: isEnabled
                        ? () async {
                            if (memorizeGame.cards.elementAt(index).flipped) {
                              return;
                            }
                            setState(() {
                              memorizeGame.clicks++;
                              memorizeGame.cards.elementAt(index).flipped =
                                  true;
                              memorizeGame.cardsIndx.add(index);
                            });
                            if (memorizeGame.cardsIndx.length == 2) {
                              setState(() {
                                isEnabled = false;
                              });
                              await Future.delayed(const Duration(seconds: 1));
                              setState(() {
                                isEnabled = true;
                              });
                              var card1Idx =
                                  memorizeGame.cardsIndx.elementAt(0);
                              var card2Idx =
                                  memorizeGame.cardsIndx.elementAt(1);
                              if (memorizeGame.cards
                                      .elementAt(card1Idx)
                                      .value ==
                                  memorizeGame.cards
                                      .elementAt(card2Idx)
                                      .value) {
                                setState(() {
                                  memorizeGame.cards.elementAt(card1Idx).found =
                                      true;
                                  memorizeGame.cards.elementAt(card2Idx).found =
                                      true;
                                  memorizeGame.cardsIndx = [];
                                });
                                if (memorizeGame.cards
                                        .where((element) => element.found)
                                        .length ==
                                    memorizeGame.cardCount) {
                                  var authState = authBlock.state;
                                  var username = authState.username;
                                  gameBlock.add(EndGameEvent(
                                      username: username,
                                      score: memorizeGame.clicks));
                                  Fluttertoast.showToast(
                                      msg:
                                          '${localizer.gameOver} ${memorizeGame.clicks.toString()}',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: const Color.fromARGB(
                                          255, 221, 193, 82),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } else {
                                setState(() {
                                  memorizeGame.cards
                                      .elementAt(card1Idx)
                                      .flipped = false;
                                  memorizeGame.cards
                                      .elementAt(card2Idx)
                                      .flipped = false;
                                  memorizeGame.cardsIndx = [];
                                });
                              }
                            }
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          width: 90,
                          height: 90,
                          fit: BoxFit.scaleDown,
                          image: AssetImage(memorizeGame.cards[index].flipped
                              ? memorizeGame.cards[index].value
                              : memorizeGame.questionBox)),
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
            ))
          ],
        ));
  }
}
