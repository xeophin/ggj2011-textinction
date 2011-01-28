class cLevelSplash extends cLevel{
  
  cLevelSplash(String _Name){
    super(_Name);
  }
  
  void draw(){
    fill(255);
    text("Janina", random(width), random(height));
    text("Kaspar", random(width), random(height));
    text("Tillo", random(width), random(height));        
    text("Dragics", random(width), random(height));
    
    
    ellipse(random(width), random(height), 55, 55);
  }
  
}
