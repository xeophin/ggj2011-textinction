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

    m_PosBackground = new PVector(0.0, 0.0);
    m_PickUpFactory = new cPickUpFactory();

    m_aPickUps = new cPickUp[3]; // probably list

    m_AudioPlayer = m_Minim.loadFile("raindrops1.mp3");
    m_AudioPlayer.loop();
  
    m_lastDraw = 0.;

    // Set up progressive difficulty
    m_StepLimit = m_StepConstant;
  }

  void up() {
    m_Avatar.up();
  }

  void forward() {
    m_Avatar.forward();
    m_isForward = true;
  }

  void draw() {
    if(m_lastDraw == 0) {
      m_lastDraw = millis();
    }
    else {

      //Doing some stuff in case we recently died.
      if (m_Avatar.m_RecentlyDied) {
        m_Avatar.m_RecentlyDied = false;
        m_Article.randomArticle = int(random(m_Article.feed.numEntries));
      }

      background(0,255,0);

      PVector Scroll;

      if(m_isForward == true) {
        Scroll = new PVector(-1*(m_Avatar.m_Fat_Max - m_Avatar.m_Fat), 0.0);
        m_isForward = false;
      }
      else {
        Scroll = new PVector(0.0, 0.0);
      }


      m_PosBackground.add(Scroll);

      image(m_Background, m_PosBackground.x, m_PosBackground.y, width, height);
      image(m_Background, m_PosBackground.x+width, m_PosBackground.y, width, height);   
      image(m_Background, m_PosBackground.x+width+width, m_PosBackground.y, width, height);       

      float newTopHeight = height * m_Top.height / m_Background.height;

      pushStyle();
      imageMode(CENTER);
      image(m_Top, width/2.0, newTopHeight/2.0, width, newTopHeight);
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
      m_StepLimit = m_StepLimit * 1.5;
      println(m_StepLimit);
    }

      m_lastDraw = millis();
    }
  }

  void keyReleased() {
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
