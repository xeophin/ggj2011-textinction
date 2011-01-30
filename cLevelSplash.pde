class cLevelSplash extends cLevel{
  
  int m_Feedentry;
  String m_Buffer;

  cLevelSplash(String _Name) {
    super(_Name);
    
    m_Feedentry = 1;
    m_Buffer ="";
  }
  
  void draw(){
    
    fill(255);  

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("tExtinction", width/2, height/5);
    popStyle();
    
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(20);
    text("Collect Ink to keep your visibility.", width/2, height-260);
    text("Avoid Light to not fade into nonexistence.", width/2, height-230);
    text("...keep a healthy balance or the censors will delete you!", width/2, height-200);
    popStyle();
    
  }	


  void keyReleased() {
    if (key == CODED) {
      if(keyCode == ALT) {
        m_Buffer="";
      }
    }
    else {
      m_Buffer += key;
      m_Buffer = m_Buffer.toLowerCase();
      println(m_Buffer);
      if(m_Buffer.equals("start")) {
        println("Starting Level 1");
        m_Active=false;
      }
      if(m_Buffer.equals("about")) {
        println("Open about");
        m_Active=false;
      }
    }
  }
  
}
