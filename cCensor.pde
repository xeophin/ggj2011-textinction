class cCensor extends cObjectVelocity {
  
  // Basic Vectorshapes
  PShape s1,s2,s3;
   
  cAvatar a;
 
  float counter;
  
  cCensor (cAvatar av) {
    a = av;
    s1 =loadShape("censor1.svg");
    s2 = loadShape("censor2.svg");
    s3 = loadShape("censor3.svg");
  }
    
  void draw() {
    
    // Place the three shapes according to the current fat content
    shape(s1, pow(a.m_Fat / a.m_Fat_Max,0.2) * 1000 - 1200 + random(-2,2), random(-2,2));
    shape(s2, pow(a.m_Fat / a.m_Fat_Max,0.4) * 1000 - 1200 + random(-4,4), random(-2,2));
    shape(s3, pow(a.m_Fat / a.m_Fat_Max,0.7) * 1000 - 1200 + random(-10,10), random(-2,2));
    
  }
}
