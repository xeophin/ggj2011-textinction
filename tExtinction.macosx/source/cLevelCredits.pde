class cLevelCredits extends cLevel {
  
  cLevelCredits(String _Name){
     super(_Name);
  }

  void draw() {
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("Credits", width/2, height/5);
    popStyle();
/*
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text("Final Score" + PlayerScore, width/2, height/5);
    popStyle();
  */  
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(20);
    text("Dragica Kahlina", width/2, height-260);
    text("Tillo Bosshart", width/2, height-230);
    text("Kaspar Manz", width/2, height-200);
    text("Janina Woods", width/2, height-170);
    popStyle();

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text("SPACE to close", width/2, height-50);
    popStyle();
  }

  void keyReleased() {
    if(key == ' ') {
      exit();
    }
  }
}
