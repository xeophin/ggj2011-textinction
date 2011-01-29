class cCensor extends cObjectVelocity {
  
  // Basic Vectorshapes
  PShape s1,s2,s3;
   
  cAvatar m_Avatar;
 
  float counter;
  
  cCensor (String _Name, cAvatar _Avatar) {
    super(_Name);
    m_Velocity = new PVector(10.0,0.0);
    
    m_Avatar = _Avatar;
    s1 =loadShape("censor1.svg");
    s2 =loadShape("censor2.svg");
    s3 =loadShape("censor3.svg");
  }
    
  void draw(PVector _Scroll) {
    
    shape(s1, m_Avatar.m_Fat%20,0);
    s1.translate(random(-3,3) + _Scroll.x, random(-3,3) + _Scroll.y);
    
    shape(s2, m_Avatar.m_Fat%m_Avatar.m_Fat_Start-width/4,0);
    s2.translate(random(-6,6) + _Scroll.x,random(-6,6) + _Scroll.y);
    
    shape(s3, m_Avatar.m_Fat%m_Avatar.m_Fat_Max-width/2,0);
    s3.translate(random(-10,10) + _Scroll.x,random(-10,10) + _Scroll.y);
    
  }
}
