// This class creates an article
class cArticle extends cObjectVelocity {

  FeedReader feed;
  String feedurl="http://feeds.reuters.com/reuters/worldNews";
  
  float randomArticle;

  /// Constructor
  cArticle (String _Name) {
    super(_Name);
    println("Loading feed: "+feedurl);
    try {
      feed = new FeedReader(feedurl);
    } finally {
    }
    randomArticle = random(feed.numEntries);
    
    
      // Just messing with the feed reader around here
  
  // load feed
  feedurl="http://feeds.reuters.com/reuters/worldNews";
  println("Loading feed: "+feedurl);
  //feed=new FeedReader(feedurl);

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
    
  
  }
}

