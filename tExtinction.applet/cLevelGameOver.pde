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

  void draw() {
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

  String calculateHighscore(String _PlayerName, int _PlayerScore, int _NoOfValues) {
    m_Reader = createReader("highscore.txt");
    try {
      while((m_Line=m_Reader.readLine( )) != null) {
        String[] pieces = split(m_Line, '=');
        m_Highscore.put(pieces[0],int(pieces[1]));
      }
      m_Reader.close();
    }
    catch(IOException e) {
      println("bla");
    }

    m_Highscore.put(_PlayerName, _PlayerScore);
    HashMap yourMap = m_Highscore;

    HashMap map = new LinkedHashMap();

    m_Writer = createWriter("data/highscore.txt");

    List yourMapKeys = new ArrayList(yourMap.keySet());
    List yourMapValues = new ArrayList(yourMap.values());
    TreeSet sortedSet = new TreeSet(yourMapValues);
    Object[] sortedArray = sortedSet.toArray();

    println(map);
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

  void saveHighscore(String m_HighscoreList) {
    m_Writer.print(m_HighscoreList);
    m_Writer.flush();
    m_Writer.close();
  }

  void keyReleased() {
    if(key == ' ') {
      m_State=1;
    }
  }
}
