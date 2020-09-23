class Tree {
  float leng;
  float angler;
  float anglel;
  float shrink;

  Tree(float leng_, float angler_, float anglel_, float shrink_) {
    this.leng = leng_;
    this.angler = angler_;
    this.anglel = anglel_;
    this.shrink = shrink_;

   // init(leng_, angler_, anglel_, shrink_);
  }


  void init(float leng, float angler, float anglel, float shrink) {
  
    line(0, 0, 0, -leng);
    translate (0, -leng);

    if (leng>5) {

      pushMatrix();
      rotate (PI/angler);
      init(leng*shrink, angler, anglel, shrink);
      popMatrix();

      pushMatrix();
      rotate (-PI/anglel);
      init(leng*shrink, angler, anglel, shrink);
      popMatrix();
    } else {
      noLoop();
    }
  }

  Tree breed (Tree mate) {
    float kidleng;
    float kidangler;
    float kidanglel;
    float kidshrink;
    

    kidleng= round(random (1)) == 0 ? this.leng: mate.leng;

    kidangler= round(random (1)) == 0 ? this.angler: mate.angler;

    kidanglel= round(random (1))==0 ? this.anglel: mate.anglel;

    kidshrink= round(random (1))==0 ? this.shrink: mate.shrink;

   

    Tree offspring= new Tree(kidleng, kidangler, kidanglel, kidshrink);

    return offspring;
  }
}