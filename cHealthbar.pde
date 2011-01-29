class cHealthbar{
  cAvatar m_Avatar; 
  
  cHealthbar(cAvatar _Avatar){
    m_Avatar = _Avatar;
  }
  
  void draw (float _diffTime) {
    rect(width-130.0,25.0,100.0,30.0); 
    pushStyle();
    fill(0,255,0);
    rect(width-130.0,25.0,m_Avatar.m_Fat,30.0);
    popStyle();
  }
  

  
}
