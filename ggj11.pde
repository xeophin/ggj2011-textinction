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
  fontSplash = loadFont("FagoBold.vlw");

  // Set the font and its size (in units of pixels)
  textFont(fontSplash, 32);
  
  LevelFactory = new cLevelFactory();
  Level = LevelFactory.make(Phase);
  
}

void draw(){
  background(0);
  Level.draw();
}

void keyPressed() {
  if (key == 'y') {
    Level = LevelFactory.make("1");
    cLevelGame test = (cLevelGame)Level;
    test.init("bg_texture.png");
  } 
}

void keyReleased() {
  
  if(Level instanceof cLevelGame)
  {
    cLevelGame test = (cLevelGame)Level;
    
    if (keyCode == ' ') {
        test.up();
     } 
    
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

