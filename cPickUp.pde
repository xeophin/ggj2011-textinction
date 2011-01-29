class cPickUp extends cObjectVelocity {
  float m_Fat;
  boolean m_alive;
  float m_lastDraw; 
  float m_Width =30;
  float m_Height =30;

  cPickUp(float _Fat, PVector _Position, PVector _Velocity) {
    m_Fat = _Fat;
    m_Position = _Position; 
    m_Velocity = _Velocity;
    m_lastDraw = 0.;
    m_alive = true;
  }



  void draw() {
    if(m_alive) {
      if(m_lastDraw == 0) {
        m_lastDraw = millis();
      }
      else {
        //println("Pos Y: " + m_Position.y + " Vel Y: " + m_Velocity.y);

        m_Position.x -= m_Velocity.x;
        if (m_Fat >= 0.0){ // Test
          fill(0,255,0);
          rect(m_Position.x, m_Position.y, m_Width, m_Height);
          //text(m_Fat,m_Position.x, m_Position.y);
          fill(255);
        }else{
          fill(255,0,0);
          rect(m_Position.x, m_Position.y, m_Width, m_Height);
          //text(m_Fat,m_Position.x, m_Position.y);
          fill(255);
        }
       if(m_Position.x <= 2*-m_Width || m_Position.x >= width+2*m_Width){
         m_alive=false;
       }
      }
    }
  }
}


