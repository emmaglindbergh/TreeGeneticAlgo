
class Ball {

  int rad;
  float x, y, z, run, rise, depth, xdirection, ydirection, zdirection;
  float temp;
  int agerisk, cardio;
  int infected=0;
  int daysinfected=0;

  int survival=1;
  int hasbeeninfected=0;//checks if it has been infected before to ensure it doesn't get infected again




  Ball() {
    rad= 12;
    x= random (rad, width-rad);
    y= random (rad, height-rad);
    z= random (0-rad, -500+rad);
    rise = 5;
    run = 5;
    depth = 5;
    xdirection=random(-1, 1)+.5;
    ydirection=random(-1, 1)+.5;
    zdirection=random(-1, 1)+.5;
  }

  void update() {
    if (survival==1) {
      translate (x, y, z);
      noStroke();
      lights();
      sphereDetail(40);
      //fill(0, 0, 200);
      sphere(rad);




      x=x+(run*xdirection);
      y=y+(rise*ydirection);
      z=z+(depth*zdirection);


      if  (x>width-rad) {
        xdirection=(xdirection*-1);
        x = width-rad;
      }
      if  (x<rad) {
        xdirection=(xdirection*-1);
        x = rad;
      }

      if  (y>height-rad) {
        ydirection=(ydirection*-1);
        y=height-rad;
      }

      if  (y<rad) {
        ydirection=(ydirection*-1);
        y=rad;
      }


      if  (z < -500) {
        zdirection=(zdirection*-1);
        z=-500+rad;
      }
      if  (z > 0) {
        zdirection=(zdirection*-1);
        z=-rad;
      }
    }
    if (infected==1) {
      daysinfected+=1;
    }
    if (daysinfected==1000 && hasbeeninfected==0) {//after x amount of days, ball lives or dies based on risk
      int[] probsurvive = {agerisk+cardio, 100-(cardio+agerisk)};
      //println(random_outcome(probsurvive));
      survival=random_outcome(probsurvive);
      hasbeeninfected=1;

      if (survival==1) {
        infected=0;
      }
      if (survival==0) {
        print (0);
        
        z=5000;

        xdirection=0;
        ydirection=0;
        zdirection=0;

        run=0;
        rise=0;
        //depth=0;
      }
    }
  }

  boolean isTouching(Ball otherBall) {
    float distance=dist(x, y, z, otherBall.x, otherBall.y, otherBall.z);
    if (distance <= 2*rad) {
      return true;
    } else {
      return false;
    }
  }


  void collide(Ball otherBall) {

    temp=xdirection;
    xdirection=otherBall.xdirection;
    otherBall.xdirection=temp;

    temp=ydirection;
    ydirection=otherBall.ydirection;
    otherBall.ydirection=temp;

    temp=zdirection;
    run=otherBall.zdirection;
    otherBall.zdirection=temp;

    x=x+(xdirection*(((2*rad)-abs(x-otherBall.x))/2));
    y=y+(ydirection*(((2*rad)-abs(y-otherBall.y))/2));
    z=z+(zdirection*(((2*rad)-abs(z-otherBall.z))/2));

    otherBall.x=otherBall.x+(otherBall.xdirection*(((2*rad)-abs(x-otherBall.x))/2));
    otherBall.y=otherBall.y+(otherBall.ydirection*(((2*rad)-abs(y-otherBall.y))/2));
    otherBall.z=otherBall.z+(otherBall.zdirection*(((2*rad)-abs(z-otherBall.z))/2));
  }
}

// Probability of survival
float rannum;


int random_outcome(int[] w) {
  int storage = 0;
  rannum =random(0, 100);


  for (int i = 0; i < w.length; i++) {

    storage+=w[i];

    if (rannum <= storage ) {
      return i;
      //outcome=i;
    }
  }
  //println(outcome);
  return 0;
}