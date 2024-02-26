import 'package:flutter/material.dart';
import 'package:miniprojectgame/untils/game_logic.dart';
import 'package:miniprojectgame/widgets/score_board.dart';
import 'package:confetti/confetti.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//Now we're going to make the Game page Logic

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  //let's start by initite the game
  Game _game = Game();
  //we will add the stats variables**
  int tries = 0;
  int score = 0;
  bool gameOver = false;

   ConfettiController _confettiController =
   ConfettiController(duration: const Duration(seconds: 3));

  @override
  void initState() {
    super.initState();
    _game.initGame();
  }

  // Function to reset the game ฟังก์ชันรีเซตเกมส์
  void resetGame() {
    setState(() {
      _game.initGame();
      tries = 0;
      score = 0;
      gameOver = false;
    });
    
  }


  @override
  Widget build(BuildContext context) {
    //we want that the board make a screen_width * screen_width size
    //let's get the screen width
    double screen_width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 114, 226), //สีพื้นหลัง
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Matchmaking Game",
              style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 253, 253)),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard("Tries", "${tries}"),
              scoreBoard("Score", "${score}"),
            ],
          ),
          SizedBox(
            height: 16.0, // Adjust spacing between the scores and the button
          ),

          SizedBox(
            height: screen_width,
            width: screen_width,
            child: GridView.builder(
              itemCount: _game.gameImg!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              padding: EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //here we're going to place all our game logic
                    print(_game.cards_list[index]);
                    setState(() {
                      tries++;
                      _game.gameImg![index] = _game.cards_list[index];
                      _game.matchCheck.add({index: _game.cards_list[index]});
                    });

                    if (_game.matchCheck.length == 2) {
                      if (_game.matchCheck[0].values.first ==
                          _game.matchCheck[1].values.first) {
                        print("true");
                        setState(() {
                          score += 100;
                          _game.matchCheck.clear();
                          checkForWin();
                        });
                      } else {
                        print(false);
                        Future.delayed(Duration(milliseconds: 500), () {
                          print(_game.gameImg);
                          setState(() {
                            _game.gameImg![_game.matchCheck[0].keys.first] =
                                _game.hiddenCardpath;
                            _game.gameImg![_game.matchCheck[1].keys.first] =
                                _game.hiddenCardpath;
                            _game.matchCheck.clear();
                          });
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 227, 236, 67),
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(_game.gameImg![index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Reset button
          SizedBox(
            height: 6.0,
          ),
          ElevatedButton(
            onPressed: resetGame,
            style: ElevatedButton.styleFrom(
              primary:
                  Color.fromARGB(255, 219, 41, 41), // Button background color
              onPrimary: const Color.fromARGB(255, 251, 249, 249), // Text color
              elevation: 3.0, // Button shadow
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8.0), // Button border radius
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Text("Reset Game",
                  style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
            ),
          ),
            // ConfettiWidget
      ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality
            .explosive, // you can change this to BlastDirectionality.directional
        shouldLoop:
            false, // start again as soon as the animation is finished
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple,
        ], // manually specify the colors to be used
      ),
        ],
      ),
    );
  }

  void checkForWin() {
    if (score >= 400) {
      setState(() {
        gameOver = true;
      });
      // Activate the confetti effect
    _confettiController.play();

      // Show a snackbar when the game is won
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Congratulations! You have won the game!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
