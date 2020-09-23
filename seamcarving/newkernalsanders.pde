//I worked with Pallavi, Lisa, and Isabella
PImage img;
int a;
int b;
int min;

int aa;
int bb;
int minn;
void setup() {
  size(1024, 636);
  img = loadImage("treelandscape.jpg");
  
}
  // CALCULATE GRADIENT ENERGY
void draw(){
  clear();
  image(img, 0, 0);
  // Create table to store energy values for each pixel
  int[][] table = new int[img.width][img.height];
  int[][] DPtable = new int[img.width+1][img.height+1];

  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      float Rx, Gx, Bx, Ry, Gy, By;
      Rx = red(img.get(x-1, y)) - red(img.get(x+1, y));
      Gx = green(img.get(x-1, y)) - green(img.get(x+1, y));
      Bx = blue(img.get(x-1, y)) - blue(img.get(x+1, y));
      Ry = red(img.get(x, y-1)) - red(img.get(x, y+1));
      Gy = green(img.get(x, y-1)) - green(img.get(x, y+1));
      By = blue(img.get(x, y-1)) - blue(img.get(x, y+1));

      int energy = round(Rx * Rx + Ry * Ry + Gx * Gx + Gy * Gy + Bx * Bx + By * By);

      table[x][y] = energy;
      //set(x, y, color(map(table[x][y], 0, 20000, 0, 255)));
      //DPtable[x][y]= table[x][y] + min(center, left, right);
    }
  }


  // Fill DP table

  // Loop over y, then x to go row by row
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      // Check each pixel's 2-3 parents, 
      if (x - 1 >= 0) { // ok to move diagonal left
        a = table[x-1][y];
      }
      if (x + 1 < img.width) { // ok to move diagonal right
        b = table[x+1][y];
      }

      // Take the minimum of the 2-3 parents,
      min = min(a, table[x][y], b); 
      // Add that to the pixel's current energy value

      DPtable[x][y] = table[x][y] + min;
    }
  }


  // Backtrack to color single seam
  // 1: Start at the bottom row & find the x position lowest energy endpoint
  int lowestX = 0;
  int lowestvalue = 1000000;
  // Loop over all the x values in the bottom row; remember the x value of where you find the lowest energy
  for (int x = 0; x < img.width-1; x++) {

    if (DPtable[x][img.height-1] < lowestvalue) {
      lowestvalue = DPtable[x][img.height-1];
      lowestX = x;
    }
  }



  // 2: Backtrack up to find the path of that seam, coloring it as you go
  // Loop back through the rows moving upward from the bottom
  // 1: find x position of lowest parent (check all 3)
  // 2: color the current lowestX position red

  for (int y=img.height-2; y>0; y--) {
    if (lowestX - 1 >= 0) { 
      aa = DPtable[lowestX-1][y];
    }
    if (lowestX + 1 <= img.width-1) { 
      bb = DPtable[lowestX+1][y];
    }
    
    minn = min(aa, DPtable[lowestX][y], bb);

    if (minn==aa) {
      lowestX=lowestX-1;
    }

    if (minn == bb) {
      lowestX=lowestX+1;
    }
    
    
    for (int x=lowestX; x<img.width-1; x++) {
      set(x, y, get(x+1,y));
    }
  } 
   img=get(0, 0, img.width-1, img.height);
}