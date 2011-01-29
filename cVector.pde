class PVector
{
  float m_X;
  float m_Y;
  
  PVector(float _X, float _Y){
    m_X = _X;
    m_Y = _Y;
  }
  
  PVector add(PVector _other, PVector _result){
    return new PVector(m_X + _other.m_X, m_Y + _other.m_Y);
  }
  
}
