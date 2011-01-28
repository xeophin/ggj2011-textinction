class cVector
{
  float m_X;
  float m_Y;
  
  cVector(float _X, float _Y){
    m_X = _X;
    m_Y = _Y;
  }
  
  cVector add(cVector _other, cVector _result){
    return new cVector(m_X + _other.m_X, m_Y + _other.m_Y);
  }
  
}
