int particleCount = 100;

Ball[] ballsList= new Ball[particleCount];

void setup () {
  size(1000, 700, P3D);
  //noStroke();
  //lights();
  for (int i=0; i<particleCount; i++) {
    ballsList[i] = new Ball();
  }
  for (int i=0; i<particleCount; i++) {

    if (i==0) { //makes first ball infected
      ballsList[i].infected = 1;
    } else if (i<14) { //age group 10-19
      ballsList[i].agerisk = 1;
    } else if (i>=14 && i<30) {//age group 20-29
      ballsList[i].agerisk = 1;
    } else if (i>=30 && i<45) {//age group 30-39
      ballsList[i].agerisk = 1;
    } else if (i>=45 && i<59) {//age group 40-49
      ballsList[i].agerisk = 1;
    } else if (i>=59 && i<74) {//age group 50-59
      ballsList[i].agerisk = 1;
    } else if (i>=74 && i<87) {//age group 60-69
      ballsList[i].agerisk = 4;
    } else if (i>=87 && i<95) {//age group 70-79
      ballsList[i].agerisk = 8;
    } else if (i>=95 && i<100) {//age group 80+
      ballsList[i].agerisk = 15;
    }
     if (i>=59&&i<=60){//40-59 with cardiovascular disease
      ballsList[i].cardio = 10;
    }
     if (i>=86&&i<=89){//60-79 with cardiovascular disease
      ballsList[i].cardio = 10;
    }
     if (i==95){//80+ with cardiovascular disease
      ballsList[i].cardio = 10;
    }
    //println(ballsList[i].agerisk);
  }
}

void draw() {
  background (0);
  //translate(mouseX,mouseY);
  //scale(mouseX/30.0);
  /// clear();
  stroke (255);
  //back square
  line(0, 0, -500, width, 0, -500);
  line(0, 0, -500, 0, height, -500);
  line(0, height, -500, width, height, -500);
  line(width, height, -500, width, 0, -500);

  //diagonal lines
  line(0, 0, -500, 0, 0, 0);
  line(width, 0, -500, width, 0, 0);
  line(0, height, -500, 0, height, 0);
  line(width, height, -500, width, height, 0);




  for (int i=0; i<particleCount; i++) {
    if (ballsList[i].z<-500) {
      //println(ballsList[i].z);
    }
    if (ballsList[i].infected==1) {
      fill(255, 0, 0);//makes ball red if infected
    } else {
      fill(0, 0, 255);//makes ball blue
    }
    for (int j=0; j<particleCount; j++) {
      if (i!=j) {
        if (ballsList[i].isTouching(ballsList[j])) {//checks if touching another ball
          ballsList[i].collide(ballsList[j]);
          pushMatrix();
          ballsList[i].update();//draws all the balls
          popMatrix();

          if (ballsList[i].infected==1||ballsList[j].infected==1) {//checks if one ball is infected
            if (ballsList[i].hasbeeninfected==1) {
              ballsList[i].infected=0;
            }
            if (ballsList[j].hasbeeninfected==1) {
              ballsList[j].infected=0;
            } else {
              ballsList[i].infected=1;
              ballsList[j].infected=1;
            }
          }
        }
      }
    }
    
    pushMatrix();
    ballsList[i].update();//draws all the balls
    popMatrix();
  }
}