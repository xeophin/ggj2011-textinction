class cLevelFactory{
  
  
  
  cLevel make(String _Name){
    if(_Name == "Splash"){
      return new cLevelSplash(_Name);
    }
    else if (_Name == "1"){
      String[] background_names = {"bg_texture.png","top.png","floor.png"};
      return new cLevelGame(_Name, background_names);
    }
    
    return new cLevel("Default");
  
  }
  
  

}


