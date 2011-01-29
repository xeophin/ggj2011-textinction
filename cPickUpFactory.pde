class cPickUpFactory {

  cPickUp make(boolean _Positive, int _PositionX, float _Ground, int _maxVelocity) {

    if(_Positive) {
      return new cPickUp(random(0,10.0), new PVector(_PositionX,random(0,_Ground)),new PVector(random(_maxVelocity/2,_maxVelocity),0));
    } 
    else {
      return new cPickUp(random(-10.0,0), new PVector(_PositionX,random(0,_Ground)),new PVector(random(_maxVelocity/2,_maxVelocity),0));
    }
  }
}


