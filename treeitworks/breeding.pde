int fitness1=1;
int fitness2=1;
int fitness3=1;
int fitness4=1;
int fitness5=1;
int outcome;




void mouseClicked() {

  if (50<mouseX && mouseX<150) {
    fitness1+=1;
     
  }

  if (350<mouseX && mouseX<450) {
    fitness2+=1;
  }

  if (650<mouseX && mouseX<750) {
    fitness3+=1;
  }

  if (950<mouseX && mouseX<1050) {
    fitness4+=1;
  }

  if (1250<mouseX && mouseX<1350) {
    fitness5+=1;
  }
}



float rannum1;

int random_outcome (int[] f) {
  int fitnesstotal=fitness1+fitness2+fitness3+fitness4+fitness5+1;

  rannum1 =random(0, fitnesstotal);
  int storage=0;
  for (int i = 0; i < f.length; i++) {
    storage+=f[i];


    if (rannum1 <= storage) {
      return i;
    }
  }
  return 2019;
}