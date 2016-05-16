//CISC 3665
//Team Project: Ken's Revenge
//
//
//
//
//
//
//
//


static final int NORTH = 0;
static final int EAST  = 3;
static final int SOUTH = 6;
static final int WEST  = 9;

PVector gone = new PVector(-1000, -1000);
//PVector gone = null;
boolean start = false;

int kenScore = 0;
int thiefScore = 0;

int time; 
int direction;

Ken ken = new Ken();
Thief thief = new Thief();

Gold golds[] = new Gold[30];
Swift swifts[] = new Swift[5];
Trap traps[] = new Trap[10];

int trapArea[][] = new int[10][10];
int[] taK={-1, -1};
int[] taT={-1, -1};

PImage startBG, endBG, gameBG;

void setup(){
  size(600, 600); // width and height
  startBG = loadImage("forest.png");
  endBG = loadImage("gameover.png");
  gameBG = loadImage("gamebg.png");

  for(int i=0; i<golds.length/3; i++){
    golds[i]=new Gold(i, 5);
    golds[10+i]=new Gold(i, 10);
    golds[20+i]=new Gold(i, 20);
  }
  for(int i=0 ; i<swifts.length; i++){
    swifts[i]=new Swift();
  }
  for(int i=0 ; i<traps.length; i++){
    traps[i]=new Trap();
  }
  for(int i=0; i<10; i++){
    for(int j=0; j<10; j++){
      trapArea[i][j]=0;
    }
  }

  
}

void draw(){
  if(!start) {
    background(startBG);
    fill(#ffffff);
    textSize(32);
    text("Press space to start",160,560);
    if(keyPressed)
      if(key == ' ') {
        start = true;
      }
  }
  
  if(start) {
  time = millis()/1000;
  //drawBackground();
  background(gameBG);
  
  //draw trapArea
  for(int i=0; i<10; i++){
   for(int j=0; j<10; j++){
     if(trapArea[i][j]==1){
       fill(0);
       rect(i*width/10, j*height/10,width/10, height/10);
     }else if(trapArea[i][j]==2){
       fill(255);
       rect(i*width/10, j*height/10,width/10, height/10);
     }
     
   } 
  }  
  
  //draw items: golds, swiftness, traps
  for(int i=0; i<golds.length; i++){
    golds[i].draw();
  }
  for(int i=0 ; i<swifts.length; i++){
    swifts[i].draw();
  }
  for(int i=0 ; i<traps.length; i++){
    traps[i].draw();
  }
  
  //draw ken and thief
  ken.draw();
  thief.draw();
  
  
  
  //ken's movement
  if(keyPressed && key==CODED){
    if(keyCode==UP){
      ken.move(NORTH);
    }
    if(keyCode==DOWN){
      ken.move(SOUTH);
    }
    if(keyCode==LEFT){
      ken.move(WEST);
    }
    if(keyCode==RIGHT){
      ken.move(EAST);
    }
  }
  
  //thief's movement, detect gold Thief AI or random dir
  if(thief.direction==-1){
    thief.move(thief.findDir());
  }
  
  
  //detect swiftness Ken
  int ks = ken.gotSwift();
  if(ks!=-1){
    swifts[ks].pos = gone;
    ken.speedup(time);
  }
  if(ken.duration5()==time){
      ken.speedRestore();
  }
  
  //detect if ken is inside a trap, while ken moving around
  if(trapArea[(int)ken.pos.x/60][(int)ken.pos.y/60]==1){
    ken.slowdown();
    ken.isInsideTrap=true;
  }
  if(ken.isInsideTrap==true && trapArea[(int)ken.pos.x/60][(int)ken.pos.y/60]==0){
    ken.speedRestore();
    ken.isInsideTrap=false;
  }
  
  //detect swiftness Thief
  int ts = thief.gotSwift();
  if(ts!=-1){
    swifts[ts].pos = gone;
    thief.speedup(time);
    System.out.println("ken:"+ts);
  }
  if(thief.duration5()==time){
      thief.speedRestore();
  }
  
  //detect if the thief is inside a trap, while the thief is moving around
  if(trapArea[(int)thief.pos.x/60][(int)thief.pos.y/60]==1){
   thief.slowdown();
  }else{
   thief.speedRestore();
  }
 
  //detect golds Ken
  int kg = ken.gotGold();
  if(kg!=-1){
    golds[kg].pos = gone;
    kenScore+=golds[kg].value;
  }
  
  //detect golds Thief
  int tg = thief.gotGold();
  if(tg!=-1){
    golds[tg].pos = gone;
    thiefScore+=golds[tg].value;
  }
  
  //detect traps Ken
  int kt = ken.gotTrap();
  if(kt!=-1 && ken.lastTrapFinished==true && ken.hasTrap==false ){
    traps[kt].pos=gone;
    ken.hasTrap=true;
  }
  
  //detect traps Thief
  int tt = thief.gotTrap();
  if(tt!=-1 && thief.hasTrap==false){
    traps[tt].pos=gone;
    thief.hasTrap=true;
    thief.canIPutTrap = true;
  }
  
  
  // Ken puts trap and make a 2 second delay
  if(ken.canIPutTrap==true){
    taK=ken.putTrap(time);
  }
  if(taK[0]!=-1&&taK[1]!=-1 && ken.duration2()==time){
      trapArea[taK[0]][taK[1]]=1;
      ken.lastTrapFinished=true;
  }
  
  //Thief puts trap and make a 2 second delay
  if(thief.canIPutTrap==true){
    taT=thief.putTrap(time);
  }
  if(taT[0]!=-1&&taT[1]!=-1 && thief.duration2()==time){
      trapArea[taT[0]][taT[1]]=1;
      
  }
  
  
  scoreBoard();
  
  
  if(allGoldsCollected()) {
     gameOver(); 
  }
 } // end of start
} // end of draw

void drawBackground(){
  background(200);
  
  for(int i=0; i<9; i++){
    line(0, (i+1)*height/10, width, (i+1)*height/10);
    line((i+1)*width/10, 0, (i+1)*width/10, height);
  }
  
}

void scoreBoard(){
  fill(255);
  textSize(20);
  text("Ken got: "+kenScore, 20, 20);
  text("Ken's speed: " + ken.vel.x, 20, 40);
  text("hasTrap: " + ken.hasTrap, 20, 60);
  
  text("Thief got: "+thiefScore, width/2+40, 20);
  text("Thief's speed: " + thief.vel.x, width/2+40, 40);
  text("hasTrap: " + thief.hasTrap, width/2+40, 60);

}

boolean allGoldsCollected() {
  int i = 0;
  while(i < golds.length) {
     if(golds[i].pos == gone)
       i++;
     else return false;
  }
  return true;
}

void gameOver() {
  background(endBG);
  fill(0);
  textSize(30);
  int max;
  String winner;
  if(kenScore > thiefScore) {
    max = kenScore;
    winner = "Ken";
  }
  else {
    max = thiefScore;
    winner = "Thief";
  }
  text(winner + " Wins!", 210,500);
  text("Score: " + max, 210, 550);
}

void keyPressed(){

  if(key != CODED){
    switch(key){
      case ' ':
        if(ken.hasTrap==true){
          ken.canIPutTrap=true;
        }
        break;
    }
  }
  
}

  
  
  
  
  