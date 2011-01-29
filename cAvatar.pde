class cAvatar extends cObjectVelocity{
  float m_Fat;
  int   m_Life;
  cVector m_Acc;
  float m_lastDraw;
  
  float m_Gravity = 1.0;
  float m_Drag = 1.0;
  
  char[] m_Name = new char[3];
  
  cAvatar(char[] _Name){
    m_Fat = 50.0;
    m_Name = _Name;
    m_Position = new cVector(0.5*width, 400.0);
    m_Acc = new cVector(0.0, 0.0);
    m_Velocity = new cVector(0.,0.);
    m_lastDraw = 0.;
  }
  
  void forward(){
    //m_Velocity.m_X += 10+m_Fat;
  }
  
  void up(){
    if(abs(m_Velocity.m_Y) < 0.05){
        m_Velocity.m_Y = 4*(-100+m_Fat);
    }
  }
  
  void draw(){
    if(m_lastDraw == 0){
      m_lastDraw = millis();
    }
    else{
      //println("Pos Y: " + m_Position.m_Y + " Vel Y: " + m_Velocity.m_Y);
      
      m_Position.m_X += m_Velocity.m_X * (millis() - m_lastDraw)/1000;
      m_Position.m_Y += m_Velocity.m_Y * (millis() - m_lastDraw)/1000;
      rect(m_Position.m_X, m_Position.m_Y, 55, 55);
      
      if( (m_Position.m_Y) > 500){
        m_Velocity.m_Y = 0.0;
      }
      else{
        m_Velocity.m_Y += m_Gravity;
      }
      
      if(abs(m_Velocity.m_X) < m_Drag + 0.05){
        m_Velocity.m_X = 0;
      }
      else
      { 
        m_Velocity.m_X -= m_Drag;
      }
      
      //println("X: " + m_Position.m_X + " Y: " + m_Position.m_Y);
      m_lastDraw = millis(); 
    }
  }
  
}
