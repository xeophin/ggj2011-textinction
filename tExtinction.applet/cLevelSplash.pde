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

  void draw() {

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
      text(PlayerName+"@tExtinction $: " +m_Buffer, width/6, height/1.3);
    }else{
      text("   @tExtinction$: " +m_Buffer, width/6, height/1.3);
    }
    popStyle();
  }	

  void keyReleased() {
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

