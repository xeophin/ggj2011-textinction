/**
 * --- The fat guy ---
 * Dragica
 * Janina
 * Kaspar
 * Tillo 
 
 * -> A game about EXTINCTION

**/

cLevelFactory LevelFactory;
cLevel m_Level;

PFont fontSplash;

void setup(){
  size(800, 600);
  
    // For vector fonts, use the createFont() function. 
  fontSplash = loadFont("FagoBold.vlw");

  // Set the font and its size (in units of pixels)
  textFont(fontSplash, 32);
  
  LevelFactory = new cLevelFactory();
  m_Level = LevelFactory.make("Splash");
  
  
  
}

void draw(){
  background(0);
  m_Level.draw();
}

void keyPressed() {
  if (key == ' ') {
    m_Level = LevelFactory.make("1");
  } 
}

void keyReleased() {
  if(m_Level instanceof cLevelGame)
  {
    cLevelGame test = (cLevelGame)m_Level;
    if(key == CODED)
    {
      if (keyCode == UP) {
        test.up();
      } 
      else if (keyCode == RIGHT) {
       test.forward();
      } 
    }
  }
}

