class cLevelGame extends cLevel {

  cAvatar m_Avatar;
  
  // Adding a censor for testing purposes.
  cCensor m_Censor;

  PImage  m_Background;
  cVector m_PosBackground;

  float m_Ground = 500;

  cLevelGame(String _Name) {
    super(_Name);

    char[] test = {
      'a','b','c'
    };

    m_Avatar = new cAvatar(test);
    
    m_Censor = new cCensor(m_Avatar);

    m_PosBackground = new cVector(0.0, 0.0);
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
      m_PosBackground.m_X -= m_Avatar.m_Fat_Max - m_Avatar.m_Fat;
    }
  }

  void draw() {
    background(0,255,0);

    image(m_Background, m_PosBackground.m_X, m_PosBackground.m_Y, width, height);
    image(m_Background, m_PosBackground.m_X-width, m_PosBackground.m_Y, width, height);   
    
    if(m_PosBackground.m_X < 0) {
          m_PosBackground.m_X = width;
    }

    m_Avatar.draw();
    m_Censor.draw();
  }
}

