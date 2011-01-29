class cLevelGameOver extends cLevel{

  cLevelGameOver(String _Name) {
   super(_Name);
  }
  
  void draw(){
     pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("Game Over", width/2, height/2);
    popStyle();
  }
}

