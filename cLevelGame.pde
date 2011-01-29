class cLevelGame extends cLevel {

  cAvatar m_Avatar;
  cHealthbar m_Healthbar;
  float m_lastDraw;
  
  // Adding a censor for testing purposes.
  cCensor m_Censor;
  
  // Adding an article
  cArticle m_Article;

  cPickUpFactory m_PickUpFactory;
  cPickUp[] m_aPickUps; // pickups on the canvas, pickup dies if hit by avatar or moves out of screen.
   
  float m_Ground = 500;

  PImage  m_Background;
  PVector m_PosBackground;
  
  Boolean m_isForward = false;
  
  cLevelGame(String _Name){
    super(_Name);

    char[] test = {
      'a','b','c'
    };

    m_Avatar = new cAvatar("Avatar", test);
    m_Healthbar = new cHealthbar(m_Avatar);
    
    m_Censor = new cCensor("Censor", m_Avatar);
    
    m_Article = new cArticle("Article");

    m_PosBackground = new PVector(0.0, 0.0);
    m_PickUpFactory = new cPickUpFactory();
    
    m_aPickUps = new cPickUp[3]; // probably list
    
    m_lastDraw = 0.;
  }

  void init( String _Background) {
    m_Background = loadImage(_Background);
  }

  void up() {
    m_Avatar.up();
  }

  void forward() {
    m_Avatar.forward();
    if(Phase != "GameOver"){
      m_isForward = true;
    }
  }

  void draw() {
    if(m_lastDraw == 0){
      m_lastDraw = millis();
    }
    else{
      background(0,255,0);
      
      PVector Scroll;
      
      if(m_isForward == true){
         Scroll = new PVector(-1*(m_Avatar.m_Fat_Max - m_Avatar.m_Fat), 0.0);
         m_isForward = false;
      }
      else{
         Scroll = new PVector(0.0, 0.0);
      }
      
      m_PosBackground.add(Scroll);
  
      //image(m_Background, m_PosBackground.x-width, m_PosBackground.y, width, height);   
      image(m_Background, m_PosBackground.x, m_PosBackground.y, width, height);
      image(m_Background, m_PosBackground.x+width, m_PosBackground.y, width, height);   
      image(m_Background, m_PosBackground.x+width+width, m_PosBackground.y, width, height);       
      
      
      if(m_PosBackground.x <= -width) {
            m_PosBackground.x = 0;
      }

  
      m_Healthbar.draw(millis()-m_lastDraw);
      m_Avatar.draw(millis()-m_lastDraw);
      m_Censor.draw(millis()-m_lastDraw, Scroll);
      
      for(int i = 0; i < m_aPickUps.length; i++){
        if(m_aPickUps[i]== null || !m_aPickUps[i].m_alive){
          if(random(6)<= 3){
            m_aPickUps[i] = m_PickUpFactory.make(true, width, m_Ground , 5);
          }else{
            m_aPickUps[i] = m_PickUpFactory.make(false, width, m_Ground , 5);
          }
        }
        m_Avatar.hitPickUp(m_aPickUps[i]);
        m_aPickUps[i].draw();
      }
      m_lastDraw = millis(); 
    }
  }
}

