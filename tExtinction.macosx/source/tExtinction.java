import processing.core.*; 
import processing.xml.*; 

import ddf.minim.*; 
import ddf.minim.signals.*; 
import ddf.minim.analysis.*; 
import ddf.minim.effects.*; 
import com.sun.syndication.feed.synd.*; 
import com.sun.syndication.io.*; 

import org.jdom.*; 
import org.jdom.adapters.*; 
import com.sun.syndication.feed.rss.*; 
import org.jdom.filter.*; 
import org.jdom.xpath.*; 
import org.jdom.output.*; 
import com.sun.syndication.feed.module.*; 
import com.sun.syndication.feed.*; 
import com.sun.syndication.feed.atom.*; 
import com.sun.syndication.io.*; 
import org.jdom.transform.*; 
import com.sun.syndication.feed.impl.*; 
import com.sun.syndication.io.impl.*; 
import com.sun.syndication.feed.synd.*; 
import org.jdom.input.*; 
import com.sun.syndication.feed.synd.impl.*; 
import com.sun.syndication.feed.module.impl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class tExtinction extends PApplet {






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

public void setup() {
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

public void draw() {
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

public void keyReleased() {
  Level.keyReleased();
}

public void stop()
{
  // always close Minim audio classes when you are done with them
 
  m_Minim.stop();
  
  super.stop();
}

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
        randomArticle = PApplet.parseInt(random(feed.numEntries));
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

  public void draw () {

    pushStyle();
    textMode(SCREEN);
    textAlign(CENTER);
    textFont(titleFont);
    fill(0xff392919, 255 / m_Avatar.m_Fat_Max * m_Avatar.m_Fat);
    text(feed.entry[randomArticle].title, width/4,height/3.5f,width/2,height/5);
    popStyle();

    pushStyle();
    textMode(SCREEN);
    textFont(bodyFont);
    fill(0xff392919, 255 / m_Avatar.m_Fat_Max * m_Avatar.m_Fat);
    text(feed.entry[randomArticle].description, width/3.5f,height/2.5f,width/2,height/4);
    popStyle();
  }
}

class cAvatar extends cObjectVelocity {


  float m_Fat_Start = 50.0f;
  float m_Fat_Max = 100.0f;
  float m_FatLoss = 1.0f;
  float m_Fat;
  int   m_Life = 3;
  int   m_Steps = 0;

  float m_Ground = 500.0f;

  PVector m_Acc;
  PVector m_Velocity;

  float m_Width;
  float m_Height;

  float m_Gravity = 20;
  float m_Drag = 1.0f;

  char[] m_Body = new char[3];

  PFont thin;
  PFont light;
  PFont regular;
  PFont stout;
  PFont fat;

  cAvatar(String _Name, char[] _Body, float _Ground) {
    super(_Name);

    m_Body = _Body;
    m_Fat = m_Fat_Start;

    m_Position = new PVector(0.5f*width, 400.0f);
    m_Acc = new PVector(0.0f, 0.0f);
    m_Velocity = new PVector(0.f,0.f);

    m_Ground = _Ground;

    m_Width = 60;
    m_Height = 60;

    thin = loadFont("FagoRegular.vlw");
    light = loadFont("FagoMedium.vlw");
    regular = loadFont("FagoBold.vlw");
    stout = loadFont("FagoExtraBold.vlw");
    fat = loadFont("FagoBlack.vlw");
  }

  public void forward() {
    m_Velocity.x += (m_Fat_Max-m_Fat)/500;
    if(m_Life > 0) {
      m_Fat -= m_FatLoss;
      m_Steps++;
    }
  }

  public void up() {
    if(abs(m_Velocity.y) < 0.05f) {
      m_Velocity.y = 5*(-m_Fat_Max+m_Fat);
    }
  }
  public void hitPickUp(cPickUp _PickUp) {
    if ((m_Position.x + 0.5f * m_Height > _PickUp.m_Position.x && m_Position.x - 0.5f * m_Height < _PickUp.m_Position.x + _PickUp.m_Height)
      &&(m_Position.y + 0.5f * m_Width > _PickUp.m_Position.y && m_Position.y - 0.5f * m_Width < _PickUp.m_Position.y + _PickUp.m_Width)) {
      m_Fat += _PickUp.m_Fat;
      _PickUp.m_alive=false;
    }
  }

  public void draw(float _diffTime) {
    //println("Pos Y: " + m_Position.y + " Vel Y: " + m_Velocity.y);

    if(m_Life > 0) {
      if(m_Fat <=0) {
        m_Life -= 1;
        m_Fat = m_Fat_Start;
        
        m_Snippet= m_Minim.loadSnippet("endoflife.mp3");
        m_Snippet.play();
      }

      m_Position.x += m_Velocity.x * (_diffTime)/1000;
      m_Position.y += m_Velocity.y * (_diffTime)/1000;
      //rect(m_Position.x, m_Position.y, 55, 55);


      String ava = "";
      for (int i=0; i < m_Life; i++) {
        ava = ava + String.format("%c", m_Body[i]);
      }

      pushStyle();
      fill(255);

      // Visual Health Feedback
      if (m_Fat < m_Fat_Max / 5) {
        textFont(thin);
      } 
      else if (m_Fat < m_Fat_Max / 5 * 2) {
        textFont(light);
      } 
      else if (m_Fat < m_Fat_Max / 5 * 3) {
        textFont(regular);
      } 
      else if (m_Fat < m_Fat_Max / 5 * 4) {
        textFont(stout);
      } 
      else if (m_Fat <= m_Fat_Max) {
        textFont(fat);
      }

      textAlign(CENTER);
      textSize(84);
      text(ava, m_Position.x, m_Position.y);
      popStyle();

      if( (m_Position.y) > m_Ground) {
        m_Velocity.y = 0.0f;
      }
      else {
        m_Velocity.y += m_Gravity;
      }

      if(abs(m_Velocity.x) < m_Drag + 0.05f) {
        m_Velocity.x = 0;
      }
      else
      { 
        m_Velocity.x -= m_Drag;
      }

      fill(255); 

      //String fat = "Fat: " + String.format("%.2f", m_Fat);

      String life = "";
      for(int i = 0; i< m_Life;i++)
      { 
        life += "o";
      }
      String steps = String.format("%d", m_Steps*100);
      PlayerScore = m_Steps*100;

      pushStyle();
      textSize(18);
      //text(fat, width-200, 0+25.0);
      text(life, width/2-20, height-70.0f);          
      popStyle(); 
      text(steps, width/2-50, 0+100.0f);    
      //println("X: " + m_Position.x + " Y: " + m_Position.y);
    }
    else {
      m_Fat = 0;
      pushStyle();
      fill(255,0,0);
      textAlign(CENTER);
      textSize(144);
      text("Game Over", width/2, height/2);
      popStyle(); 
    }
  }
}

class cCensor extends cObjectVelocity {
  
  // Basic Vectorshapes
  PShape s1,s2,s3;
   
  cAvatar m_Avatar;
  
  // This multiplier can be used to balance the game \u2013 the lower it is, the faster the censorship appears.
  // Of course, the value can also adapted during playtime.
  float m_velocityMultiplier;
 
  float scrollDistanceReservoir;
  
  cCensor (String _Name, cAvatar _Avatar) {
    super(_Name);
    m_Velocity = new PVector(1,0.0f);
    m_velocityMultiplier = 20;
    
    m_Position = new PVector(0,0);
    
    m_Avatar = _Avatar;
    s1 =loadShape("censor1.svg");
    s2 =loadShape("censor2.svg");
    s3 =loadShape("censor3.svg");
  }
  
  public void draw(float _diffTime, PVector _Scroll) {
    
    scrollDistanceReservoir = scrollDistanceReservoir + _Scroll.x;
    
    float moveDistance = scrollDistanceReservoir / m_velocityMultiplier;
    
    float velo_x = moveDistance + (_diffTime / m_velocityMultiplier);
  
    scrollDistanceReservoir = scrollDistanceReservoir - moveDistance;
    
    
    // Place the three shapes according to the current fat content
    shape(s1, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.2f) * width / 2 - width * 1.75f + random(-2,2), random(-5,5), width/2, height );
    shape(s2, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.4f) * width / 2 - width * 1.75f + random(-4,4), random(-5,5), width/2, height );
    shape(s3, pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.7f) * width / 2 - width * 1.75f + random(-8,8) , random(-5,5), width/2, height );
    
    s1.translate(velo_x,0);
    s2.translate(velo_x,0);
    s3.translate(velo_x,0);
    
    m_Position = new PVector(m_Position.x + velo_x,0);

    
    // Check whether the bad boogeyman got us.
    if (m_Position.x + pow(m_Avatar.m_Fat / m_Avatar.m_Fat_Max,0.4f) * width / 4 > width * 1.5f) {
       m_Avatar.m_Life -= 1;
       m_Avatar.m_Fat = m_Avatar.m_Fat_Start;
       
       
       // Reset all positions so the player can get a somewhat new start.
       s1.resetMatrix();
       s2.resetMatrix();
       s3.resetMatrix();
       
       m_Position = new PVector(0,0);
    }
  }
}
class cGameObject{
  
  String m_Name;
  
  cGameObject(String _Name){
    m_Name = _Name;
  }
  
  
}
class cHealthbar{
  cAvatar m_Avatar; 
  
  cHealthbar(cAvatar _Avatar){
    m_Avatar = _Avatar;
  }
  
  public void draw (float _diffTime) {

    pushStyle();
    fill(200,200,200);
    rect(width/2-120.0f,height-145.0f,220.0f,40.0f);
    popStyle();
    pushStyle();
    fill(245,255,65);
    rect(width/2-110.0f,height-140.0f,200.0f,30.0f); 
    popStyle();
    pushStyle();
    fill(30,30,30);
    rect(width/2-110.0f,height-140.0f,m_Avatar.m_Fat*2,30.0f);
    popStyle();
  }
  

  
}
class cLevel {

  String m_Name;
  int m_State;

  cLevel(String _Name) {
    m_Name = _Name;
    m_State = 0;
  }

  public void draw() {
  }

  public void keyReleased() {
  }
}

class cLevelCredits extends cLevel {
  
  cLevelCredits(String _Name){
     super(_Name);
  }

  public void draw() {
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("Credits", width/2, height/5);
    popStyle();
/*
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text("Final Score" + PlayerScore, width/2, height/5);
    popStyle();
  */  
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(20);
    text("Dragica Kahlina", width/2, height-260);
    text("Tillo Bosshart", width/2, height-230);
    text("Kaspar Manz", width/2, height-200);
    text("Janina Woods", width/2, height-170);
    popStyle();

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text("SPACE to close", width/2, height-50);
    popStyle();
  }

  public void keyReleased() {
    if(key == ' ') {
      exit();
    }
  }
}
class cLevelFactory {

  public cLevel make(String _Name) {
    if(_Name == "Splash") {
      return new cLevelSplash(_Name);
    }
    else if (_Name == "1") {
      String[] background_names = {
        "bg_texture.png","top.png","floor.png"
      };
      return new cLevelGame(_Name, background_names);
      
    }else if (_Name== "Info"){
      return new cLevelInfo(_Name);
    }else if (_Name== "Credits"){
      return new cLevelCredits(_Name);
    }
    else {
      return new cLevelGameOver(_Name);
    }
  }
}

class cLevelGame extends cLevel {

  cAvatar m_Avatar;
  cHealthbar m_Healthbar;
  float m_lastDraw;

  // Adding a censor for testing purposes.
  cCensor m_Censor;
  
  // Adding an article
  cArticle m_Article;
  
  // Implementing a way of making the game harder over time
  float m_StepLimit;
  float m_StepConstant = 50; // every 50 steps, the censorship will get faster.

  cPickUpFactory m_PickUpFactory;
  cPickUp[] m_aPickUps; // pickups on the canvas, pickup dies if hit by avatar or moves out of screen.

  float m_Ground = 500;

  PImage m_Background;
  PImage m_Top; 
  PImage m_Floor;

  PVector m_PosBackground;

  Boolean m_isForward = false;

  cLevelGame(String _Name, String[] _Backgrounds) {
    super(_Name);


    m_Background = loadImage(_Backgrounds[0]);
    m_Top = loadImage(_Backgrounds[1]);
    m_Floor = loadImage(_Backgrounds[2]);

    m_Ground = height - (height * m_Floor.height / m_Background.height+10);

    char[] m_Name = PlayerName.toCharArray();

    m_Avatar = new cAvatar("Avatar", m_Name, m_Ground);
    m_Healthbar = new cHealthbar(m_Avatar);

    m_Censor = new cCensor("Censor", m_Avatar);
    
    m_Article = new cArticle("Article", m_Avatar);

    m_PosBackground = new PVector(0.0f, 0.0f);
    m_PickUpFactory = new cPickUpFactory();

    m_aPickUps = new cPickUp[3]; // probably list

    m_AudioPlayer = m_Minim.loadFile("raindrops1.mp3");
    m_AudioPlayer.loop();
  
    m_lastDraw = 0.f;
    
    // Set up progressive difficulty
    m_StepLimit = m_StepConstant;
  }

  public void up() {
    m_Avatar.up();
  }

  public void forward() {
    m_Avatar.forward();
    m_isForward = true;
  }

  public void draw() {
    if(m_lastDraw == 0) {
      m_lastDraw = millis();
    }
    else {
      background(0,255,0);

      PVector Scroll;

      if(m_isForward == true) {
        Scroll = new PVector(-1*(m_Avatar.m_Fat_Max - m_Avatar.m_Fat), 0.0f);
        m_isForward = false;
      }
      else {
        Scroll = new PVector(0.0f, 0.0f);
      }


      m_PosBackground.add(Scroll);

      image(m_Background, m_PosBackground.x, m_PosBackground.y, width, height);
      image(m_Background, m_PosBackground.x+width, m_PosBackground.y, width, height);   
      image(m_Background, m_PosBackground.x+width+width, m_PosBackground.y, width, height);       

      float newTopHeight = height * m_Top.height / m_Background.height;

      pushStyle();
      imageMode(CENTER);
      image(m_Top, width/2.0f, newTopHeight/2.0f, width, newTopHeight);
      popStyle();

      float newFloorHeight = height * m_Floor.height / m_Background.height;

      image(m_Floor, m_PosBackground.x, height-newFloorHeight, width, newFloorHeight);
      image(m_Floor, m_PosBackground.x+width, height-newFloorHeight, width, newFloorHeight);   
      image(m_Floor, m_PosBackground.x+width+width, height-newFloorHeight, width, newFloorHeight);          


      if(m_PosBackground.x <= -width) {
        m_PosBackground.x = 0;
      }


      m_Healthbar.draw(millis()-m_lastDraw);
     
      
      m_Article.draw();
      
       m_Avatar.draw(millis()-m_lastDraw);
      
      m_Censor.draw(millis()-m_lastDraw, Scroll);

      for(int i = 0; i < m_aPickUps.length; i++) {
        if(m_aPickUps[i]== null || !m_aPickUps[i].m_alive) {
          if(random(6)<= 3) {
            m_aPickUps[i] = m_PickUpFactory.make(true, width, m_Ground-100, 1);
          }
          else {
            m_aPickUps[i] = m_PickUpFactory.make(false, width, m_Ground-100, 1);
          }
        }
        m_Avatar.hitPickUp(m_aPickUps[i]);
        m_aPickUps[i].draw(millis()-m_lastDraw, Scroll);
      }
    m_SampleManager.draw();

      if(m_Avatar.m_Life<=0) {
        m_State=1;
      }
// Progressive difficulty
    if (m_Avatar.m_Steps > m_StepLimit & m_Censor.m_velocityMultiplier > 2) {
      m_Censor.m_velocityMultiplier -= 2;
      m_StepLimit = m_StepLimit * 1.5f;
      println(m_StepLimit);
    }

      m_lastDraw = millis();
    }
  }

  public void keyReleased() {
    if (key == ' ') {
      up();
    } 
    if (key == 'k') {
      m_Avatar.m_Life--;
    } 

    if(key == CODED)
    {
      if (keyCode == UP) {
        up();
      } 
      else if (keyCode == RIGHT) {
        forward();
      }
    }
  }
}

class cLevelGameOver extends cLevel {

  BufferedReader m_Reader;
  HashMap m_Highscore;
  String m_Line;
  String m_Text;
  int m_NoOfValues=5;
  PrintWriter m_Writer;

  cLevelGameOver(String _Name) {
    super(_Name);
    m_Highscore = new HashMap();
    m_Text = calculateHighscore(PlayerName,PlayerScore,m_NoOfValues);
    //saveHighscore(m_Text);
  }

  public void draw() {
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("Game Over", width/2, height/5);
    popStyle();


    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text(m_Text, width/2, height/3);
    popStyle();

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text("SPACE to continue", width/2, height-50);
    popStyle();
  }

  public String calculateHighscore(String _PlayerName, int _PlayerScore, int _NoOfValues) {
    m_Reader = createReader("highscore.txt");
    try {
      while((m_Line=m_Reader.readLine( )) != null) {
        String[] pieces = split(m_Line, '=');
        m_Highscore.put(pieces[0],PApplet.parseInt(pieces[1]));
      }
      m_Reader.close();
    }
    catch(IOException e) {
      println("bla");
    }

    m_Highscore.put(_PlayerName, _PlayerScore);
    
    HashMap yourMap = m_Highscore;
    
    m_Writer = createWriter("data/highscore.txt");

    List yourMapKeys = new ArrayList(yourMap.keySet());
    List yourMapValues = new ArrayList(yourMap.values());
    TreeSet sortedSet = new TreeSet(yourMapValues);
    Object[] sortedArray = sortedSet.toArray();

    println(m_Highscore);
    StringBuffer _String=new StringBuffer();

    //println
    for(int i=m_NoOfValues; i>0;i--) {
      _String.append(yourMapKeys.get(yourMapValues.indexOf(sortedArray[i])).toString()+" ....... "+sortedArray[i].toString()+"\n"); 
      m_Writer.println(yourMapKeys.get(yourMapValues.indexOf(sortedArray[i])).toString()+"="+sortedArray[i].toString());
    } 
    m_Writer.flush();
    m_Writer.close();

    return _String.toString();
  }

  public void saveHighscore(String m_HighscoreList) {
    m_Writer.print(m_HighscoreList);
    m_Writer.flush();
    m_Writer.close();
  }

  public void keyReleased() {
    if(key == ' ') {
      m_State=1;
    }
  }
}

class cLevelInfo extends cLevel {
  
  cLevelInfo(String _Name){
     super(_Name);
  }

  public void draw() {
    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("tExtinction", width/2, height/5);
    popStyle();

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(20);
    text("Collect Ink to keep your visibility.", width/2, height-260);
    text("Avoid Light to not fade into nonexistence.", width/2, height-230);
    text("...keep a healthy balance or the censors will delete you!", width/2, height-200);
    text("UP/SPACE to jump, RIGHT to run", width/2, height-150);
    popStyle();

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    text("SPACE to start", width/2, height-50);
    popStyle();
  }

  public void keyReleased() {
    if(key == ' ') {
      m_State=1;
    }
  }
}

class cLevelSplash extends cLevel {

  int m_Feedentry;
  String m_Buffer;
  boolean m_NameEntered;

  cLevelSplash(String _Name) {
    super(_Name);

    m_Feedentry = 1;
    m_Buffer ="";
    m_NameEntered = false;
  }

  public void draw() {

    fill(255);  

    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(144);
    text("tExtinction", width/2, height/5);
    popStyle();


    pushStyle();
    fill(255,0,0);
    textAlign(CENTER);
    textSize(34);
    if(m_NameEntered) {
      text("Type what you want to do.\n\n Confirm with SPACE. \n\n Correct with ALT", width/2, height/3);
    }
    else {
      text("Type your name (3 Letters) to login: \n\n Confirm with SPACE \n\n Correct with ALT", width/2, height/3);
    }
    popStyle();

    pushStyle();
    fill(255,0,0);
    //textAlign(RIGHT);
    textSize(34);
    if(m_NameEntered) {
      text(PlayerName+"@tExtinction $: " +m_Buffer, width/6, height/1.3f);
    }else{
      text("   @tExtinction$: " +m_Buffer, width/6, height/1.3f);
    }
    popStyle();
  }	

  public void keyReleased() {
    if (key == CODED) {
      if(keyCode == ALT) {
        m_Buffer="";
      }
    }
    else {
      m_Buffer += key;
      m_Buffer = m_Buffer.toLowerCase();
      println(m_Buffer);
      if(m_NameEntered) {
        if(m_Buffer.equals("start ") || m_Buffer.equals("run ")|| m_Buffer.equals("exec ")) {
          println("Starting Level 1");
          m_State=1;
        }
        if(m_Buffer.equals("about ") || m_Buffer.equals("help ") ||  m_Buffer.equals("info ") || m_Buffer.equals("man ")) {
          m_State=2;
        }
      }
      else {
        if(m_Buffer.length() == 4 && key ==' ') {
          PlayerName = m_Buffer.substring(0,3);
          m_Buffer = "";
          m_NameEntered = true;
        }
      }
    }
  }
}

class cObjectPosition extends cGameObject{
  
  PVector m_Position;
  
  cObjectPosition(String _Name){
      super(_Name);
  }

}
class cObjectVelocity extends cObjectPosition{
  
  PVector m_Velocity;

  
  cObjectVelocity(String _Name){
      super(_Name);

  }
  
}
class cPickUp extends cObjectVelocity {
  float m_Fat;
  boolean m_alive;

  PImage m_Body;
  String m_ShapeName;


  float m_Width =50;
  float m_Height =50;

  cPickUp(String _Name, float _Fat, PVector _Position, PVector _Velocity, String _ShapeName) {
    super(_Name);
    m_Fat = _Fat;
    m_Position = _Position; 
    m_Velocity = _Velocity;
    
    m_ShapeName = _ShapeName;
    m_Body = loadImage(_ShapeName);
    
    m_alive = true;
  }



  public void draw(float _diffTime, PVector _Scroll) {
    if(m_alive) {
      //println("Pos Y: " + m_Position.y + " Vel Y: " + m_Velocity.y);

      m_Position.x -= (m_Velocity.x * _diffTime - _Scroll.x)/2;
      
      image(m_Body, m_Position.x, m_Position.y, m_Width, m_Height);

     if(m_Position.x <= 2*-m_Width || m_Position.x >= width+2*m_Width){
       m_alive=false;
     }
    }
  }
}


class cPickUpFactory {

  public cPickUp make(boolean _Positive, int _PositionX, float _Ground, int _maxVelocity) {

    if(_Positive) {
      return new cPickUp("Positive", random(0,10.0f), new PVector(_PositionX,random(0,_Ground)),new PVector(random(_maxVelocity/2,_maxVelocity),0), "ink.png");
    } 
    else {
      return new cPickUp("Negative", random(-10.0f,0), new PVector(_PositionX,random(0,_Ground)),new PVector(random(_maxVelocity/2,_maxVelocity),0), "bulb.png");
    }
  }
}




class cSampleManager{

  int num_Samples = 30;
  AudioSample[] m_SampleList = new AudioSample[num_Samples];
  float m_MilLast = 0;
  
  float m_SoundDistance = 2.0f;
  float m_SoundWiggle = 0.50f;
  
  
  cSampleManager(){
    
    String file;
    for(int i=0; i < num_Samples; i++){
      file = String.format("%d.mp3", i);
      println(file);
      m_SampleList[i] = m_Minim.loadSample(file);
    }
    
  }
  
  public void draw(){
    if((millis()-m_MilLast)/1000 > m_SoundDistance + random(-m_SoundWiggle, m_SoundWiggle)){
      playRandom();
      m_MilLast = millis();
    }
  }

  public void playRandom(){
    int rnd = PApplet.parseInt(random(0,num_Samples));
    m_SampleList[rnd].trigger(); 
  }

  
}

//   feedParser.pde
//
// Reads RSS and Atom feeds. Requires ROME
// (https://rome.dev.java.net/)
// and JDOM (http://www.jdom.org/), just make
// a code folder and copy "jdom.jar" and "rome-*.jar"
// into it.
//
// Marius Watz - http://workshop.evolutionzone.com




//FeedReader feed;
String feedurl;

/*
void setup() {
  size(200, 200);

  // load feed
  feedurl="http://feeds.reuters.com/reuters/topNews";
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
*/

class FeedReader {
  SyndFeed feed;
  String url,description,title;
  int numEntries;
  FeedEntry entry[];

  public FeedReader(String _url) {
    url=_url;
    try {
      feed=new SyndFeedInput().build(new XmlReader(new URL(url)));
      description=feed.getDescription();
      title=feed.getTitle();

      java.util.List entrl=feed.getEntries();
      Object [] o=entrl.toArray();
      numEntries=o.length;

      entry=new FeedEntry[numEntries];
      for(int i=0; i< numEntries; i++) {
        entry[i]=new FeedEntry((SyndEntryImpl)o[i]);
        println(i+": "+entry[i]);
      }
    }
    catch(Exception e) {
      println("Exception in Feedreader: "+e.toString());
      e.printStackTrace();
    }
  }
  
  // This uses an InputStream as a source, so we can catch a failing
  // internet connection earlier on.
  public FeedReader(InputStream _stream) {
    try {
      feed=new SyndFeedInput().build(new XmlReader(_stream));
      description=feed.getDescription();
      title=feed.getTitle();

      java.util.List entrl=feed.getEntries();
      Object [] o=entrl.toArray();
      numEntries=o.length;

      entry=new FeedEntry[numEntries];
      for(int i=0; i< numEntries; i++) {
        entry[i]=new FeedEntry((SyndEntryImpl)o[i]);
        println(i+": "+entry[i]);
      }
    }
    catch(Exception e) {
      println("Exception in Feedreader: "+e.toString());
      e.printStackTrace();
    }
  }
  
  // This is more a dummy constructor \u2013 it creates a simple feedreader
  // object that works as a stand-in when no internet connection is 
  // available.
  public FeedReader() {
    entry=new FeedEntry[1];
    entry[0] = new FeedEntry("Governmental Internet Shut-Downs", "Due to the current crisis in internet connections, no real content could be provided.");
  }

}

class FeedEntry {
  Date pubdate;
  SyndEntryImpl entry;
  String author, contents, description, url, title;
  public String newline = System.getProperty("line.separator");

  public FeedEntry(SyndEntryImpl _entry) {
    try {
      entry=_entry;
      author=entry.getAuthor();
      Object [] o=entry.getContents().toArray();
      if(o.length>0) contents=((SyndContentImpl)o[0]).getValue();
      else contents="[No content.]";

      description=entry.getDescription().getValue();
      if(description.charAt(0)==
        System.getProperty("line.separator").charAt(0))
          description=description.substring(1);

      url=entry.getLink();
      title=entry.getTitle();
      pubdate=entry.getPublishedDate();
    }
    catch(Exception e) {
      println("Exception in FeedEntry: "+e.toString());
      e.printStackTrace();
    }

  }
  
  // This is a very ugly hack to overload the constructor, in order to be
  // able to create a very basic FeedEntry
  public FeedEntry(String _title, String _description) {
      title = _title;
      description = _description;
  }

  public String toString() {
    String s;

    s="Title: "+title+newline+
      "URL: "+url+newline+
      "Date: "+pubdate.toString()+newline;

    if(description.length()>50)
      s+="Descr: ["+description.substring(0,50)+
        "...]"+newline;
    else s+="Descr: ["+description+"]"+newline;

    if(contents.length()>50)
      s+="Contents: ["+contents.substring(0,50)+
        "...]"+newline;
    else s+="Contents: ["+contents+"]"+newline;
    return s;
  }
}


  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "tExtinction" });
  }
}
