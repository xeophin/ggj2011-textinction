class cLevelGame extends cLevel{
  
   cAvatar m_Avatar;
   float m_Ground = 500;
  
  cLevelGame(String _Name){
    super(_Name);
    
    char[] test = {'a','b','c'};
    
    m_Avatar = new cAvatar(test);
    
  }
  
  void up(){
    m_Avatar.up();
  }
  
  void forward(){
    m_Avatar.forward();
  }
  
  void draw(){
    background(0,255,0);
    m_Avatar.draw();
  }
  
}
