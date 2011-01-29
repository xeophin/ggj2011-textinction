class cCensor extends cObjectVelocity {
  
  // Basic Vectorshapes
  PShape s1,s2,s3;
   
  cAvatar m_Avatar;
 
  float counter;
  
  cCensor (String _Name, cAvatar _Avatar) {
    super(_Name);
    m_Velocity = new PVector(15.0,0.0);
    
    m_Avatar = _Avatar;
    s1 =loadShape("censor1.svg");
    s2 =loadShape("censor2.svg");
    s3 =loadShape("censor3.svg");
  }
    
  void draw(float _diffTime, PVector _Scroll) {
    
    float velo_x = _Scroll.x + (m_Velocity.x * _diffTime);  
    
    // Place the three shapes according to the current fat content
    shape(s1, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.2) * 1000 - 1200 + random(-2,2) + velo_x, random(-2,2));
    shape(s2, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.4) * 1000 - 1200 + random(-4,4) + velo_x, random(-2,2));
    shape(s3, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.7) * 1000 - 1200 + random(-10,10) + velo_x, random(-2,2));
  }
}
