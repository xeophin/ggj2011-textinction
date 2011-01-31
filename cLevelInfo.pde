class cLevelInfo extends cLevel {
  
  cLevelInfo(String _Name){
     super(_Name);
  }

  void draw() {
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("tExtinction", width/2, height/5);
    popStyle();

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(20);
    text("Collect Ink to keep your visibility.", width/2, height-260);
    text("Avoid Light to not fade into nonexistence.", width/2, height-230);
    text("...keep a healthy balance or the censors will delete you!", width/2, height-200);
    text("UP/SPACE to jump, RIGHT to run", width/2, height-150);
    popStyle();

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text("SPACE to start", width/2, height-50);
    popStyle();
  }

  void keyReleased() {
    if(key == ' ') {
      m_State=1;
    }
  }
}

