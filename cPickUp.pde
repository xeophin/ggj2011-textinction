class cPickUp extends cObjectVelocity {
  float m_Fat;
  boolean m_alive;

  float m_Width =30;
  float m_Height =30;

  cPickUp(String _Name, float _Fat, PVector _Position, PVector _Velocity) {
    super(_Name);
    m_Fat = _Fat;
    m_Position = _Position; 
    m_Velocity = _Velocity;
    m_alive = true;
  }



  void draw(float _diffTime, PVector _Scroll) {
    if(m_alive) {
      //println("Pos Y: " + m_Position.y + " Vel Y: " + m_Velocity.y);

      m_Position.x -= m_Velocity.x * _diffTime - _Scroll.x;
      if (m_Fat >= 0.0){ // Test
        fill(0,255,0);
        rect(m_Position.x, m_Position.y, m_Width, m_Height);
        //text(m_Fat,m_Position.x, m_Po sition.y);
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


