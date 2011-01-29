// This class creates an article
class cArticle extends cObjectVelocity {

  FeedReader feed;
  String feedurl="http://www.nytimes.com/services/xml/rss/nyt/World.xml";
  
  int randomArticle;

  PFont titleFont;
  PFont bodyFont;

  /// Constructor
  cArticle (String _Name) {
    super(_Name);
    
    titleFont = loadFont("JensonBold.vlw");
    bodyFont = loadFont("JensonDisplay.vlw");
    
    println("Loading feed: "+feedurl);
    try {
      feed = new FeedReader(feedurl);
      randomArticle = int(random(feed.numEntries));
    } catch (Exception e) {
      // I guess we should provide some alternative text here if we don't get one online.
    }
    
    
    
      // Just messing with the feed reader around here

  // print feed data
//  println("Feed: "+feed.title);
//  println("------------------------------");
//  println("Description: "+feed.description);
//  println("\nNumber of entries: "+feed.numEntries);
//  println("------------------------------");
//
//  // print feed entries
//  for(int i=0; i< feed.numEntries; i++) {
//    println(i+": "+feed.entry[i]);
//  }
    
    // We don't need no continous update here, I think.
    noLoop();
  }
  
 void draw () {
   
   textFont(titleFont);
  text(feed.entry[randomArticle].title, 0,0);
  
  }
}

