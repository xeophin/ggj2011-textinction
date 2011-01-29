class cAvatar extends cObjectVelocity{
     
  
  float m_Fat_Start = 50.0;
  float m_Fat_Max = 100.0;
  float m_FatLoss = 1.0;
  float m_Fat;
  int   m_Life = 3;
  PVector m_Acc;
  float m_lastDraw;
  
  float m_Gravity = 1.5;
  float m_Drag = 1.0;
  
  char[] m_Name = new char[3];
  
  cAvatar(char[] _Name){
    m_Name = _Name;
    m_Fat = m_Fat_Start;
    m_Position = new PVector(0.5*width, 400.0);
    m_Acc = new PVector(0.0, 0.0);
    m_Velocity = new PVector(0.,0.);
    m_lastDraw = 0.;
  }
  
  void forward(){
    //m_Velocity.m_X += 10+m_Fat;
    if(m_Life > 0){
      m_Fat -= m_FatLoss;
    }
  }
  
  void up(){
    if(abs(m_Velocity.m_Y) < 0.05){
        m_Velocity.m_Y = 3*(-m_Fat_Max+m_Fat);
    }
  }
  
  void draw(){
    if(m_lastDraw == 0){
      m_lastDraw = millis();
    }
    else{
      //println("Pos Y: " + m_Position.m_Y + " Vel Y: " + m_Velocity.m_Y);
      
      if(m_Life > 0){
        if(m_Fat <=0){
          m_Life -= 1;
          m_Fat = m_Fat_Start;
        }
        
        m_Position.m_X += m_Velocity.m_X * (millis() - m_lastDraw)/1000;
        m_Position.m_Y += m_Velocity.m_Y * (millis() - m_lastDraw)/1000;
        //rect(m_Position.m_X, m_Position.m_Y, 55, 55);
        
        
        String ava = "";
        for (int i=0; i < m_Life; i++){
          ava = ava + String.format("%c", m_Name[i]);
        }
        
        pushStyle();
        fill(255);
        textAlign(CENTER);
        text(ava, m_Position.m_X, m_Position.m_Y);
        popStyle();
        
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
        
        fill(255); 

        String fat = "Fat: " + String.format("%.2f", m_Fat);
        String life = "Life: " + String.format("%d", m_Life);

        pushStyle();
        textSize(18);
        text(fat, width-150, 0+25.0);
        text(life, width-150, 0+50.0);    
        popStyle(); 
        //println("X: " + m_Position.m_X + " Y: " + m_Position.m_Y);
        m_lastDraw = millis(); 
        
        
      }
      else{
        m_Fat = 0;
        pushStyle();
        fill(255,0,0);
        textAlign(CENTER);
        textSize(144);
        text("Game Over", width/2, height/2);
        popStyle(); 
        Phase = "GameOver";
      }
    }
  }
}
