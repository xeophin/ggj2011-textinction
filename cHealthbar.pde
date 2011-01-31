class cHealthbar{
  cAvatar m_Avatar; 
  
  cHealthbar(cAvatar _Avatar){
    m_Avatar = _Avatar;
  }
  
  void draw (float _diffTime) {

    pushStyle();
    fill(200,200,200);
    rect(width/2-120.0,height-145.0,220.0,40.0);
    popStyle();
    pushStyle();
    fill(245,255,65);
    rect(width/2-110.0,height-140.0,200.0,30.0); 
    popStyle();
    pushStyle();
    fill(30,30,30);
    rect(width/2-110.0,height-140.0,m_Avatar.m_Fat*2,30.0);
    popStyle();
  }
  

  
}
