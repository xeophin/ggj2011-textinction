class cLevelGame extends cLevel{
  
  cAvatar m_Avatar;
  float m_Ground = 500;
   
  PImage  m_Background;
  cVector m_PosBackground;
  
  
  cLevelGame(String _Name){
    super(_Name);
    
    char[] test = {'a','b','c'};
    
    m_Avatar = new cAvatar(test);
    
    m_PosBackground = new cVector(0.0, 0.0);
    
  }
  
  void init( String _Background){
    m_Background = loadImage(_Background);
  }
  
  void up(){
    m_Avatar.up();
  }
  
  void forward(){
    m_Avatar.forward();
    
    m_PosBackground.m_X -= m_Avatar.m_Fat;
    
    
  }
  
  void draw(){
    background(0,255,0);
    
    if(m_PosBackground.m_X < 0){
      m_PosBackground.m_X = width;
    }
    
    image(m_Background, m_PosBackground.m_X, m_PosBackground.m_Y, width, height);
    image(m_Background, m_PosBackground.m_X-width, m_PosBackground.m_Y, width, height);
    m_Avatar.draw();
  }
  
}
