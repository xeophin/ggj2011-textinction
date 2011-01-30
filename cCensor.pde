class cCensor extends cObjectVelocity {
  
  // Basic Vectorshapes
  PShape s1,s2,s3;
   
  cAvatar m_Avatar;
  
  // This multiplier can be used to balance the game – the lower it is, the faster the censorship appears.
  // Of course, the value can also adapted during playtime.
  float m_velocityMultiplier;
 
  float scrollDistanceReservoir;
  
  cCensor (String _Name, cAvatar _Avatar) {
    super(_Name);
    m_Velocity = new PVector(1,0.0);
    m_velocityMultiplier = 30;
    
    m_Position = new PVector(0,0);
    
    m_Avatar = _Avatar;
    s1 =loadShape("censor1.svg");
    s2 =loadShape("censor2.svg");
    s3 =loadShape("censor3.svg");
  }
  
  void draw(float _diffTime, PVector _Scroll) {
    
    scrollDistanceReservoir = scrollDistanceReservoir + _Scroll.x;
    
    float moveDistance = scrollDistanceReservoir / m_velocityMultiplier;
    
    float velo_x = moveDistance + (_diffTime / m_velocityMultiplier);
  
    scrollDistanceReservoir = scrollDistanceReservoir - moveDistance;
    
    
    // Place the three shapes according to the current fat content
    shape(s1, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.2) * width - width * 2.1 + random(-2,2), random(-5,5), width/2, height );
    shape(s2, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.4) * width - width * 2 + random(-20,20), random(-5,5), width/2, height );
    shape(s3, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.7) * width - width * 2 + random(-40,40) , random(-5,5), width/2, height );
    
    s1.translate(velo_x,0);
    s2.translate(velo_x,0);
    s3.translate(velo_x,0);
    
    m_Position = new PVector(m_Position.x + velo_x,0);
    
    // Check whether the bad boogeyman got us.
    if (m_Position.x > width) {
       m_Avatar.m_Life -= 1;
       m_Avatar.m_Fat = m_Avatar.m_Fat_Start;
       
       
       // Reset all positions so the player can get a somewhat new start.
       s1.resetMatrix();
       s2.resetMatrix();
       s3.resetMatrix();
       
       m_Position = new PVector(0,0);
    }
  }
}
