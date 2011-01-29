class cLevelSplash extends cLevel{
  
  int m_Feedentry;
  
  cLevelSplash(String _Name){
    super(_Name);
    
    m_Feedentry = 1;
    
  }
  
  void draw(){
    
    fill(255);  
      
    // This is just a test. Sorry for messing up your code.
    text(feed.entry[1].title, 10,48, 800,600);
    
    fill(255, 0, 0);
    text("Janina", random(width), random(height));
    text("Kaspar", random(width), random(height));
    text("Tillo", random(width), random(height));        
    text("Dragica", random(width), random(height));
    
    
    
    ellipse(random(width), random(height), 55, 55);
  }
  
}
