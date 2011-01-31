

class cSampleManager{

  int num_Samples = 30;
  AudioSample[] m_SampleList = new AudioSample[num_Samples];
  float m_MilLast = 0;
  
  float m_SoundDistance = 2.0;
  float m_SoundWiggle = 0.50;
  
  
  cSampleManager(){
    
    String file;
    for(int i=0; i < num_Samples; i++){
      file = String.format("%d.mp3", i);
      println(file);
      m_SampleList[i] = m_Minim.loadSample(file);
    }
    
  }
  
  void draw(){
    if((millis()-m_MilLast)/1000 > m_SoundDistance + random(-m_SoundWiggle, m_SoundWiggle)){
      playRandom();
      m_MilLast = millis();
    }
  }

  void playRandom(){
    int rnd = int(random(0,num_Samples));
    m_SampleList[rnd].trigger(); 
  }

  
}

