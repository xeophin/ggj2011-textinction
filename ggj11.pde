/**
 * --- Textintion ---
 * Dragica
 * Janina
 * Kaspar
 * Tillo 
 * -> A game about EXTINCTION
**/

cLevelFactory LevelFactory;
cLevel Level;

String Phase = "Splash";

PFont fontSplash;

void setup(){
  size(800, 600);
  
    // For vector fonts, use the createFont() function. 
  fontSplash = loadFont("Archer-Hairline-84.vlw");

  // Set the font and its size (in units of pixels)
  textFont(fontSplash, 32);

  LevelFactory = new cLevelFactory();
  Level = LevelFactory.make(Phase);
  
}

void draw() {
  background(0);
  Level.draw();
  
  if (Level.m_Name.equals("Splash") && !(Level.m_Active)){
      Level = LevelFactory.make("1");
      
  }
  if (Level.m_Name.equals("1") && !(Level.m_Active)){
      Level = LevelFactory.make("GameOver");
  }
}

void keyReleased(){
  Level.keyReleased();
}

