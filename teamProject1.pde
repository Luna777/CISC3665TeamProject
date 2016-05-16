//CISC 3665
//Team Project: Ken's Revenge
//Team member: Xin Guan and Joyce Chiu
//
//Main functions:
//setup(): 
//  initialize all the objects and variables
//
//draw(): 
//  draw all the screen, objects.
//      there are 3 screen, title, play, gameover.
//      objects: Ken, Thief, golds, trap items, swiftness, trapArea, 
//  keep updating all the detection, action and movement algorithms
//      include items collision detection, time recoder(time delay funciton), 
//      action to use items, player's movement by key, agent's movement by gold finding algorithm.
//
//How to play:
// Start Screen: by press 's' key to start the game.
// Game play screen: using arrow keys to move Ken in each direction;
//                   using space key to put down a trap to where you stand after trap item collision
//          Goal: race to Thief, try to collect golds as much as possible to win;
// Game Over Screen: by press 's' key to re-start the game.


//setup variables
static final int NORTH = 0;
static final int EAST  = 3;
static final int SOUTH = 6;
static final int WEST  = 9;

static final int START = 11;
static final int RUNNING = 12;
static final int GAMEOVER = 13;

PVector gone = new PVector(-1000, -1000); //move away items   
int state = START;      //game start state

int kenScore;           //recording ken's score
int thiefScore;         //recording thief's score

int time;               //recording the real time

Ken ken = new Ken();               //create character ken
Thief thief = new Thief();         //create character thief

Gold golds[] = new Gold[30];       //create 30 golds
Swift swifts[] = new Swift[5];     //create 5 swiftness
Trap traps[] = new Trap[10];       //create 10 trap items

int trapArea[][] = new int[10][10];//create a 2D-array object for trap area
int[] taT={-1, -1};                //trapArea = 0, there's is no trap yet
int[] taK={-1, -1};                //trapArea = 2, delay time, in white and not slowdown characters
                                   //trapArea = 1, turns black and do slowdown when characters are inside

PImage startBG, endBG, gameBG;     //different backgrounds

void setup(){
  size(600, 600);                     // width and height
  startBG = loadImage("forest.png");  //load in different backgrounds
  endBG = loadImage("gameover.png");
  gameBG = loadImage("gamebg.png");
  
  kenScore = 0;
  thiefScore = 0;

  for(int i=0; i<golds.length/3; i++){//define&initial 30 golds, each 10 or value of 5, 10, 20
    golds[i]=new Gold(i, 5);
    golds[10+i]=new Gold(i, 10);
    golds[20+i]=new Gold(i, 20);
  }
  for(int i=0 ; i<swifts.length; i++){//define&initial swiftness to new
    swifts[i]=new Swift();
  }
  for(int i=0 ; i<traps.length; i++){ //define&initial trap items to new
    traps[i]=new Trap();
  }
  for(int i=0; i<10; i++){            //define&initial trapArea array to all 0s.
    for(int j=0; j<10; j++){
      trapArea[i][j]=0;
    }
  }

  
}

void draw(){
  //show title screen, press space key to start
  if(state == START) {                        
    background(startBG);              
    fill(#ffffff);
    textSize(32);
    text("Press 's' to start",160,560);
    if(keyPressed){
      if(key == 's') {
        state = RUNNING;
      }
    }
  }
  
  //show play screen and start game
  //draw all the objects in order
  //keep updating detections and movements
  if(state == RUNNING) {                         
  time = millis()/1000;//real time counter
  background(gameBG);
  
  //draw trapArea; =1, fill in black; =2, fill in white
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
  
  
  
  //ken's movement, by arrow keys
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
  
  //thief's movement, by gold finding algorithm
  if(thief.direction==-1){
    thief.move(thief.findDir());
  }
  
  
  //detect Ken's swiftness collision
  int ks = ken.gotSwift();
  if(ks!=-1){
    swifts[ks].pos = gone;
    ken.speedup(time);
  }
  if(ken.duration5()==time){
      ken.speedRestore();
  }
  
  //detect Thief's swiftness collision
  int ts = thief.gotSwift();
  if(ts!=-1){
    swifts[ts].pos = gone;
    thief.speedup(time);
  }
  if(thief.duration5()==time){
      thief.speedRestore();
  }
  
  //detect if ken is inside a trap
  if(trapArea[(int)ken.pos.x/60][(int)ken.pos.y/60]==1){
    ken.slowdown();
    ken.isInsideTrap=true;
  }
  if(ken.isInsideTrap==true && trapArea[(int)ken.pos.x/60][(int)ken.pos.y/60]==0){
    ken.speedRestore();
    ken.isInsideTrap=false;
  }
  
  //detect if the thief is inside a trap
  if(trapArea[(int)thief.pos.x/60][(int)thief.pos.y/60]==1){
   thief.slowdown();
  }else{
   thief.speedRestore();
  }
 
  //detect Ken's golds collision
  int kg = ken.gotGold();
  if(kg!=-1){
    golds[kg].pos = gone;
    kenScore+=golds[kg].value;
  }
  
  //detect Thief's golds collision
  int tg = thief.gotGold();
  if(tg!=-1){
    golds[tg].pos = gone;
    thiefScore+=golds[tg].value;
  }
  
  //detect Ken's trap items collision
  int kt = ken.gotTrap();
  if(kt!=-1 && ken.lastTrapFinished==true && ken.hasTrap==false ){
    traps[kt].pos=gone;
    ken.hasTrap=true;
  }
  
  //detect Thief's trap items collision
  int tt = thief.gotTrap();
  if(tt!=-1 && thief.hasTrap==false){
    traps[tt].pos=gone;
    thief.hasTrap=true;
    thief.canIPutTrap = true;
  }
 
  //Ken puts trap down to ground
  if(ken.canIPutTrap==true){
    taK=ken.putTrap(time);
  }
  if(taK[0]!=-1&&taK[1]!=-1 && ken.duration2()==time){
      trapArea[taK[0]][taK[1]]=1;
      ken.lastTrapFinished=true;
  }
  
  //Thief puts trap down to ground
  if(thief.canIPutTrap==true){
    taT=thief.putTrap(time);
  }
  if(taT[0]!=-1&&taT[1]!=-1 && thief.duration2()==time){
      trapArea[taT[0]][taT[1]]=1;
      
  }
  
  //draw score board
  scoreBoard();
  
  //detect if the game is over
  if(allGoldsCollected()) {
   state = GAMEOVER;
  }
 }
 
 //show game over screen and a start again option
 if(state == GAMEOVER){
   gameOver();
   
   fill(#ffffff);
    textSize(32);
    text("Press 's' to re-start",160,560);
    if(keyPressed){
      if(key == 's' ) {
        setup();
        state = RUNNING;
      }
    }
 }
 
} // end of draw

// !!! this part is for debugging, not showing in final game
//draw simple grids background
void drawBackground(){
  background(200);
  
  for(int i=0; i<9; i++){
    line(0, (i+1)*height/10, width, (i+1)*height/10);
    line((i+1)*width/10, 0, (i+1)*width/10, height);
  }
  
}

//draw in-game score board
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

//detect if all golds gone
boolean allGoldsCollected() {
  int i = 0;
  while(i < golds.length) {
     if(golds[i].pos == gone)
       i++;
     else return false;
  }
  return true;
}

//draw game over screen
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
  text(winner + " Wins!", 210,450);
  text("Score: " + max, 210, 500);
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

  
  
  
  
  