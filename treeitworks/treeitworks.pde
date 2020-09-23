Tree[] treelist= new Tree[5];
Tree[] children= new Tree[5];


void setup() {

  size(1400, 500);

  for (int i =0; i<treelist.length; i++) {

    treelist[i]=new Tree(random(50, 150), random(-20, 20), random(-20, 20), random (.1, .8));
  }
}

void draw() {
  int x=100;
  clear();
  background(255);
  for (int i =0; i<treelist.length; i++) {

    pushMatrix();
    translate (x, 500);
    x+=300;

    treelist[i].init(treelist[i].leng, treelist[i].angler, treelist[i].anglel, treelist[i].shrink);
    popMatrix();
    loop();
  }
}


void keyPressed() {
  if (key==ENTER) {
    int[] fitnessList= {fitness1, fitness2, fitness3, fitness4, fitness5, 1};

    for (int i =0; i<children.length; i++) {
      int parent1=random_outcome(fitnessList);
      int parent2=(random_outcome(fitnessList));
      print (parent1, parent2);
      if (parent1>=5||parent2>=5) {
        children[i]=new Tree(random(50, 150), random(-20, 20), random(-20, 20), random (.1, .8));
      } else {

        children[i]= treelist[parent1].breed(treelist[parent2]);
      }
    }
    for (int i =0; i<treelist.length; i++) {

      treelist[i]= new Tree(children[i].leng, children[i].angler, children[i].anglel, children[i].shrink);
    }
    fitness1=1;
    fitness2=1;
    fitness3=1;
    fitness4=1;
    fitness5=1;
   
  }
}