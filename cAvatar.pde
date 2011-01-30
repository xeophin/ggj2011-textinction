class cAvatar extends cObjectVelocity{
     
  
  float m_Fat_Start = 50.0;
  float m_Fat_Max = 100.0;
  float m_FatLoss = 1.0;
  float m_Fat;
  int   m_Life = 3;
  int   m_Steps = 0;
  
  float m_Ground = 500.0;
  
  PVector m_Acc;
  PVector m_Velocity;

  float m_Width;
  float m_Height;
  
  float m_Gravity = 30;
  float m_Drag = 1.0;
  
  char[] m_Body = new char[3];
  
  PFont thin;
  PFont light;
  PFont regular;
  PFont stout;
  PFont fat;
  
  cAvatar(String _Name, char[] _Body, float _Ground){
    super(_Name);
    
    m_Body = _Body;
    m_Fat = m_Fat_Start;
    
    m_Position = new PVector(0.5*width, 400.0);
    m_Acc = new PVector(0.0, 0.0);
    m_Velocity = new PVector(0.,0.);
    
    m_Ground = _Ground;
    
    m_Width = 60;
    m_Height = 60;
    
    thin = loadFont("FagoRegular.vlw");
    light = loadFont("FagoMedium.vlw");
    regular = loadFont("FagoBold.vlw");
    stout = loadFont("FagoExtraBold.vlw");
    fat = loadFont("FagoBlack.vlw");
    
  }
  
  void forward(){
    m_Velocity.x += (m_Fat_Max-m_Fat)/200;
    if(m_Life > 0){
      m_Fat -= m_FatLoss;
      m_Steps++;
    }
  }
  
  void up(){
    if(abs(m_Velocity.y) < 0.05){
        m_Velocity.y = 13*(-m_Fat_Max+m_Fat);
    }
  }
  void hitPickUp(cPickUp _PickUp){
    if ((m_Position.x + 0.5 * m_Height > _PickUp.m_Position.x && m_Position.x - 0.5 * m_Height < _PickUp.m_Position.x + _PickUp.m_Height)
          &&(m_Position.y + 0.5 * m_Width > _PickUp.m_Position.y && m_Position.y - 0.5 * m_Width < _PickUp.m_Position.y + _PickUp.m_Width)){
      m_Fat += _PickUp.m_Fat;
      _PickUp.m_alive=false;
    }
  }
  
  void draw(float _diffTime){
      //println("Pos Y: " + m_Position.y + " Vel Y: " + m_Velocity.y);
      
      if(m_Life > 0){
        if(m_Fat <=0){
          m_Life -= 1;
          m_Fat = m_Fat_Start;
        }
        
        m_Position.x += m_Velocity.x * (_diffTime)/1000;
        m_Position.y += m_Velocity.y * (_diffTime)/1000;
        //rect(m_Position.x, m_Position.y, 55, 55);
        
        
        String ava = "";
        for (int i=0; i < m_Life; i++){
          ava = ava + String.format("%c", m_Body[i]);
        }
        
        pushStyle();
        fill(255);
        
        // Visual Health Feedback
        if (m_Fat < m_Fat_Max / 5) {
          textFont(thin);
        } else if (m_Fat < m_Fat_Max / 5 * 2) {
          textFont(light);
        } else if (m_Fat < m_Fat_Max / 5 * 3) {
          textFont(regular);
        } else if (m_Fat < m_Fat_Max / 5 * 4) {
          textFont(stout);
        } else if (m_Fat <= m_Fat_Max) {
          textFont(fat);
        }
        
        textAlign(CENTER);
        textSize(84);
        text(ava, m_Position.x, m_Position.y);
        popStyle();
        
        if( (m_Position.y) > m_Ground){
          m_Velocity.y = 0.0;
        }
        else{
          m_Velocity.y += m_Gravity;
        }
        
        if(abs(m_Velocity.x) < m_Drag + 0.05){
          m_Velocity.x = 0;
        }
        else
        { 
          m_Velocity.x -= m_Drag;
        }
        
        fill(255); 

        //String fat = "Fat: " + String.format("%.2f", m_Fat);
        
        String life = "";
        for(int i = 0; i< m_Life;i++)
        { 
           life += "O";
        }
        String steps = String.format("%d", m_Steps*100);

        pushStyle();
        textSize(18);
        //text(fat, width-200, 0+25.0);
        text(life, width/2-20, height-70.0);          
        popStyle(); 
        text(steps, width/2-50, 0+100.0);    
        //println("X: " + m_Position.x + " Y: " + m_Position.y);
        
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
