class cPickUp extends cObjectVelocity {
  float m_Fat;
  boolean m_alive;

  PImage m_Body;
  String m_ShapeName;


  float m_Width =50;
  float m_Height =50;

  cPickUp(String _Name, float _Fat, PVector _Position, PVector _Velocity, String _ShapeName) {
    super(_Name);
    m_Fat = _Fat;
    m_Position = _Position; 
    m_Velocity = _Velocity;
    
    m_ShapeName = _ShapeName;
    m_Body = loadImage(_ShapeName);
    
    m_alive = true;
  }



  void draw(float _diffTime, PVector _Scroll) {
    if(m_alive) {
      //println("Pos Y: " + m_Position.y + " Vel Y: " + m_Velocity.y);

      m_Position.x -= (m_Velocity.x * _diffTime - _Scroll.x)/2;
      
      image(m_Body, m_Position.x, m_Position.y, m_Width, m_Height);

     if(m_Position.x <= 2*-m_Width || m_Position.x >= width+2*m_Width){
       m_alive=false;
     }
    }
  }
}


