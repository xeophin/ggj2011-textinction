import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

/**
 * --- tExtinction ---
 * Dragica
 * Janina
 * Kaspar
 * Tillo 
 * -> A game about EXTINCTION
 **/

cLevelFactory LevelFactory;
cLevel Level;
Minim m_Minim;
cSampleManager m_SampleManager;
AudioPlayer m_AudioPlayer;
AudioSnippet m_Snippet;
String PlayerName;
int PlayerScore;

PFont fontSplash;

void setup() {
  size(1024,768);
  m_Minim = new Minim(this);

  // For vector fonts, use the createFont() function. 
  fontSplash = loadFont("Archer-Bold-84.vlw");

  // Set the font and its size (in units of pixels)
  textFont(fontSplash, 32);
  
  m_SampleManager = new cSampleManager();
  m_AudioPlayer = m_Minim.loadFile("splash.mp3");
  m_AudioPlayer.play();
  

  LevelFactory = new cLevelFactory();
  Level = LevelFactory.make("Splash");
}

void draw() {
  background(0);
  Level.draw();

  if (Level.m_Name.equals("Splash") && (Level.m_State==1)) {
    m_AudioPlayer.close();
    Level = LevelFactory.make("1");
  }
  
  if (Level.m_Name.equals("Splash") && (Level.m_State==2)) {
    m_AudioPlayer.close();
    Level = LevelFactory.make("Info");
  }
  
  if (Level.m_Name.equals("GameOver") && (Level.m_State==1)) {
    Level = LevelFactory.make("Credits");
  }
  
  if (Level.m_Name.equals("Info") && (Level.m_State==1)) {
    Level = LevelFactory.make("1");
  }
  
    if (Level.m_Name.equals("1") && (Level.m_State==1)) {
    Level = LevelFactory.make("GameOver");
  }  
}

void keyReleased() {
  Level.keyReleased();
}

void stop()
{
  // always close Minim audio classes when you are done with them
 
  m_Minim.stop();
  
  super.stop();
}

