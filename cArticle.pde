// This class creates an article
class cArticle extends cObjectVelocity {

  FeedReader feed;
  String feedurl="http://feeds.reuters.com/reuters/worldNews";
  
  int randomArticle;

  /// Constructor
  cArticle () {
    println("Loading feed: "+feedurl);
    try {
      feed = new FeedReader(feedurl);
    }
    randomArticle = random(feed.numEntries);
    
    // We don't need no continous update here, I think.
    noLoop();
  }
  
  draw () {
    
  
  }
}

