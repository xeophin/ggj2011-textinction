// This class creates an article
class cArticle extends cObjectVelocity {

  FeedReader feed;
  String feedurl="http://feeds.bbci.co.uk/news/world/rss.xml";

  int randomArticle;

  PFont titleFont;
  PFont bodyFont;

  /// Constructor
  cArticle (String _Name) {
    super(_Name);

    titleFont = loadFont("JensonBold26.vlw");
    bodyFont = loadFont("JensonDisplay.vlw");

    println("Loading feed: "+feedurl);
    try {
      feed = new FeedReader(feedurl);
      randomArticle = int(random(feed.numEntries));
    } 
    catch (Exception e) {
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

  }

  void draw () {

    pushStyle();
    textMode(SCREEN);
    textAlign(CENTER);
    textFont(titleFont);
    fill(#392919);
    text(feed.entry[randomArticle].title, width/4,height/3.5 ,width/2,height/5);
    popStyle();

    pushStyle();
    textMode(SCREEN);
    textFont(bodyFont);
    fill(#392919);
    text(feed.entry[randomArticle].description, width/3.5,height/2.5,width/2,height/4);
    popStyle();
  }
}

