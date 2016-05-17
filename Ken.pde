//CISC 3665
//Team Project: Ken's Revenge
//Team member: Xin Guan and Joyce Chiu
//
//class Ken: 
//   has: ken's position, velocity, radius, buffers for trap function, time delay variables

//   draw(): draw ken as a green ellipse with a letter K.
//   move(): move ken by the direction passed in. 
//   speedup(), speeddown(), speedRestore(): to change ken's speed.
//   gotSwift(), gotGold(), gotTrap(): to detect collision with items.
//   putTrap(): put trap down to the position and make a little time delay.

class Ken{
  
  PVector pos = new PVector(70, 500); //position start at 70, 500
  PVector vel = new PVector(5, 5);    //current velocity initialized to 5, 5
  int rad=30;                         //set radius to 30
  
  PVector regularV = new PVector(5, 5);   //regular velocity
  PVector fasterV = new PVector(10, 10);  //velocity after speedup 
  PVector slowerV = new PVector(1, 1);    //velocity after slowdown
  
  boolean hasTrap=false;                  //buffers to put down traps
  boolean canIPutTrap=false;
  boolean isInsideTrap=false;
  boolean lastTrapFinished=true;
  
  int currentT;                           //time delay for swiftness
  int currentT2;                          //time delay for trapArea
  
  Ken()
  {
  }
  
  //draw ken as a green ellipse with letter K.
  void draw()
  {
    fill(0, 205, 0);
    ellipse(pos.x, pos.y, rad, rad);
    fill(255);
    textSize(30);
    text("K", pos.x-rad/2+5, pos.y+rad/2-5);
  }
  
  //move ken by the direction passed in. 
  void move(int dir)
  {
    switch(dir)
    {
      case NORTH: 
        pos.y-=vel.y;
        if ( ken.pos.y <= 0 ) {
          ken.pos.y = height-1;
        }
        break;
      case SOUTH:
        pos.y+=vel.y;
        if ( ken.pos.y >= height ) {
          ken.pos.y = 0+1;
        }
        break;
      case WEST:
        pos.x-=vel.x;
        if ( ken.pos.x <= 0 ) {
          ken.pos.x = width-1;
        }
        break;
      case EAST:
        pos.x+=vel.x;
        if ( ken.pos.x >= width ) {
          ken.pos.x = 0+1;
        }
        break; 
    }
  } //end of move
    
  //to change ken's speed
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
  
  //detect collision with swiftness
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
  
  //detect collision with golds
  int gotGold()
  {
    for(int i=0; i<golds.length; i++)
    {
      float distance = sqrt(pow((golds[i].pos.x-this.pos.x), 2.0) + pow((golds[i].pos.y-this.pos.y),2.0) );
      if(distance<=(golds[i].rad+this.rad)/2)
        return i;
    }
    return -1;
  } // end of gotgold
  
  //detect collision with trap items
   int gotTrap()
   {
     for(int i=0; i<traps.length; i++)
     {
        float distance = sqrt(pow((traps[i].pos.x-this.pos.x), 2) + pow((traps[i].pos.y-this.pos.y), 2) );
        if(distance<=(traps[i].rad+this.rad)/2)
          return i;
     }
     return -1;
   } //end of gotTrap
   
   //put down trap into trapArea
   int [] putTrap(int t)
   {
     currentT2=t;
     //System.out.println(ken.pos.x+" "+ken.pos.y);
     
     trapArea[(int)ken.pos.x/60][(int)ken.pos.y/60]=2;
     hasTrap=false;
     canIPutTrap=false;
     lastTrapFinished=false;
     int ta[] = {(int)ken.pos.x/60, (int)ken.pos.y/60};
     return ta;
   }
   
   //time delay
   int duration2()
   {
     return currentT2+1;
   }

}