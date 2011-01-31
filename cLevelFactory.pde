class cLevelFactory {

  cLevel make(String _Name) {
    if(_Name == "Splash") {
      return new cLevelSplash(_Name);
    }
    else if (_Name == "1") {
      String[] background_names = {
        "bg_texture.png","top.png","floor.png"
      };
      return new cLevelGame(_Name, background_names);
      
    }else if (_Name== "Info"){
      return new cLevelInfo(_Name);
    }else if (_Name== "Credits"){
      return new cLevelCredits(_Name);
    }
    else {
      return new cLevelGameOver(_Name);
    }
  }
}

