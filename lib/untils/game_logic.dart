

class Game {
  final String hiddenCardpath = 'assets/images/hidden.png';
  List<String>? gameImg;

  //Now we're going to make the recto of each cards
  //so we can play
  //we can add what'ever images you want
  final List<String> cards_list = [
    "assets/images/Boy.png",
    "assets/images/Boy.png",
    "assets/images/BoyEat.png",
    "assets/images/BoyStrong.png",
    "assets/images/Boylove.png",
    "assets/images/BoyStrong.png",
    "assets/images/BoyEat.png",
    "assets/images/Boylove.png"
  ];
  //in this list we'll store the two first clicked card and see if they match or nt
  List<Map<int, String>> matchCheck = [];

  final int cardCount = 8 ;


  //init the Game
  void initGame() {
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}