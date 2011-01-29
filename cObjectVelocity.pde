class cObjectVelocity extends cObjectPosition{
  
  PVector m_Velocity;
  float m_lastDraw;
  
  cObjectVelocity(String _Name){
      super(_Name);
      
      m_lastDraw = 0.;
  }
  
}
