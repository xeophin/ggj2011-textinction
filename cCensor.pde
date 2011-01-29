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
    
    shape(s1, a.m_Fat%20,0);
    s1.translate(random(-3,3),random(-3,3));
    
    shape(s2, a.m_Fat%a.m_Fat_Start-width/4,0);
    s2.translate(random(-6,6),random(-6,6));
    
    shape(s3, a.m_Fat%a.m_Fat_Max-width/2,0);
    s3.translate(random(-10,10),random(-10,10));
    
  }
}
