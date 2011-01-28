class cLevelFactory{
  
  cLevel make(String _Name){
    if(_Name == "Splash"){
      return new cLevelSplash(_Name);
    }
    else if (_Name == "1"){
      return new cLevelGame(_Name);
    }
    
    return new cLevel("Default");
  
  }
  
  

}


