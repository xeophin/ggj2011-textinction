class cPickUpFactory {

  cPickUp make(boolean _Positive, int _PositionX, float _Ground, int _maxVelocity) {

    if(_Positive) {
      return new cPickUp("Positive", random(0,10.0), new PVector(_PositionX,random(0,_Ground)),new PVector(random(_maxVelocity/2,_maxVelocity),0), "ink.png");
    } 
    else {
      return new cPickUp("Negative", random(-10.0,0), new PVector(_PositionX,random(0,_Ground)),new PVector(random(_maxVelocity/2,_maxVelocity),0), "lichtblob.png");
    }
  }
}


