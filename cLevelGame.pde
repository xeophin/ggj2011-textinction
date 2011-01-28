class cLevelGame extends cLevel{
  
  cLevelGame(String _Name){
    super(_Name);
  }
  
  void draw(){
    background(0,255,0);
    rect(random(width), random(height), 55, 55);
  }
  
}
