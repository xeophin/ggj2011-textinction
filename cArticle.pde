// This class creates an article
class cArticle extends cObjectVelocity {

  FeedReader feed;
  String feedurl="http://feeds.bbci.co.uk/news/world/rss.xml";

  cAvatar m_Avatar;

  int randomArticle;

  PFont titleFont;
  PFont bodyFont;

  /// Constructor
  cArticle (String _Name, cAvatar _Avatar) {
    super(_Name);

    m_Avatar = _Avatar;

    titleFont = loadFont("JensonBold26.vlw");
    bodyFont = loadFont("JensonDisplay.vlw");

    println("Loading feed: "+feedurl);
    try {
      InputStream data = createInput(feedurl);
      if (data != null) { 
        feed = new FeedReader(data);
        randomArticle = int(random(feed.numEntries));
      } else {
      println("Oh, there is no internet connection!");
        feed = new FeedReader();
        randomArticle = 0;
      }
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
    fill(#392919, 255 / m_Avatar.m_Fat_Max * m_Avatar.m_Fat);
    text(feed.entry[randomArticle].title, width/4,height/3.5,width/2,height/5);
    popStyle();

    pushStyle();
    textMode(SCREEN);
    textFont(bodyFont);
    fill(#392919, 255 / m_Avatar.m_Fat_Max * m_Avatar.m_Fat);
    text(feed.entry[randomArticle].description, width/4,height/2.5,width/2,height/4);
    popStyle();
  }
}

