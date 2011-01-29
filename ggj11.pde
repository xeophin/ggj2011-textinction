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

FeedReader feed;

void setup(){
  size(800, 600);
  
    // For vector fonts, use the createFont() function. 
  fontSplash = loadFont("FagoBold.vlw");

  // Set the font and its size (in units of pixels)
  textFont(fontSplash, 32);
  
  LevelFactory = new cLevelFactory();
  m_Level = LevelFactory.make("Splash");
  
  // Just messing with the feed reader around here
  
  // load feed
  feedurl="http://feeds.reuters.com/reuters/worldNews";
  println("Loading feed: "+feedurl);
  feed=new FeedReader(feedurl);

  // print feed data
  println("Feed: "+feed.title);
  println("------------------------------");
  println("Description: "+feed.description);
  println("\nNumber of entries: "+feed.numEntries);
  println("------------------------------");

  // print feed entries
  for(int i=0; i< feed.numEntries; i++) {
    println(i+": "+feed.entry[i]);
  }
  
}

void draw(){
  background(0);
  m_Level.draw();
}

void keyPressed() {
  if (key == ' ') {
    m_Level = LevelFactory.make("1");
    cLevelGame test = (cLevelGame)m_Level;
    test.init("bg_texture.png");
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

