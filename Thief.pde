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
class Thief{
  
  PVector pos = new PVector(560, 200);
  PVector vel = new PVector(4, 4);
  PVector acc = new PVector(0, 0);
  int rad=30;
 
  boolean hasTrap=false;
  boolean canIPutTrap = false;

  PVector regularV = new PVector(4, 4);
  PVector fasterV = new PVector(10, 10);
  PVector slowerV = new PVector(1, 1);
  
  int currentT;//time delay for swiftness
  int currentT2;//time delay for trapArea
  
  int direction=-1;
  
  Thief()
  { 
  
  }
  
  void draw()
  {
    fill(204, 0, 0);
    ellipse(pos.x, pos.y, rad, rad);
    fill(255);
    textSize(30);
    text("T", pos.x-rad/2+6, pos.y+rad/2-3);
    
  }
  
void move(int dir) 
{
  //int direction = (int)random( 0,4 );
  //System.out.println(dir);
  switch( dir ) {
    case 0: // north
      thief.pos.y -= vel.y;
      if ( thief.pos.y <= 0 ) {
        thief.pos.y = height - 1;
      }
      break;
    case 1: // west
      thief.pos.x -= vel.x;
      if ( thief.pos.x <= 0 ) {
        thief.pos.x = width - 1;
      }
      break;
    case 2: // south
      thief.pos.y += vel.y;
      if ( thief.pos.y >= height ) {
        thief.pos.y = 0 + 1;
      }
      break;
    case 3: // east
      thief.pos.x += vel.x;
      if ( thief.pos.x >= width ) {
        thief.pos.x = 0 + 1;
      }
      break;
  }
  direction=-1;
} 


int findDir(){
  float c1=5;
  float c2=0;
  for(int i = 0; i < golds.length; i++) {
       if(abs(pos.x-golds[i].pos.x)<=c1 && pos.y < golds[i].pos.y+c2) {
         // go south  
         direction = 2;
         //return direction;
       }else if(abs(pos.x-golds[i].pos.x)<=c1 && pos.y+c2 > golds[i].pos.y) {
         // go north
         direction = 0; 
         //return direction;
       }else if(abs(pos.y-golds[i].pos.y)<=c1 && pos.x < golds[i].pos.x+c2) {
         // go east
         direction = 3;
         //return direction;
       }else if(abs(pos.y-golds[i].pos.y)<=c1 && pos.x+c2 > golds[i].pos.x) {
         // go west
         direction = 1;
         //return direction;
       }
       if(direction!=-1){
         return direction;
       }
  }
  
    //direction =(int)random(0,4);    // go in any direction
    //System.out.println("random "+direction);
    direction=3;
    return direction;
  
  
}

int gotGold()
{
  for(int i=0; i<golds.length; i++){
    float distance = sqrt(pow((golds[i].pos.x-this.pos.x), 2.0) + pow((golds[i].pos.y-this.pos.y),2.0) );
    if(distance<=(golds[i].rad+this.rad)/2)
    {
      return i;
    }
  }
  return -1;
}

int gotTrap()
{
  for(int i=0; i<traps.length; i++)
  {
     float distance = sqrt(pow((traps[i].pos.x-this.pos.x), 2) + pow((traps[i].pos.y-this.pos.y), 2) );
     if(distance<=(traps[i].rad+this.rad)/2)
     {
       return i;
     }
   }
   return -1;
}

int gotSwift()
  {
    for(int i=0; i<swifts.length; i++)
    {
      float distance = sqrt(pow((swifts[i].pos.x-this.pos.x), 2.0) + pow((swifts[i].pos.y-this.pos.y),2.0) );
      if(distance<=(swifts[i].rad+this.rad)/2)
       return i;
    }
    return -1;
  } //end of gotSwift
  
  void speedup(int t)
  {
     currentT=t;
     vel = fasterV;
  }
  
  void slowdown(int t)
  {
    currentT=t;
    vel = slowerV;
  }
  
  void slowdown()
  {
    vel = slowerV;
  }
  
  int duration5()
  {
    return currentT+5;
  }
  
  void speedRestore()
  {
    vel = regularV;
  }

   int [] putTrap(int t)
   {
     currentT2=t;
     //System.out.println(thief.pos.x+" "+thief.pos.y);
     
     trapArea[(int)thief.pos.x/60][(int)thief.pos.y/60]=1;
     hasTrap=false;
     canIPutTrap=false;
     int ta[] = {(int)thief.pos.x/60, (int)thief.pos.y/60};
     return ta;
   }
   
   int duration2()
   {
     return currentT2+2;
   }

}