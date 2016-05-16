//CISC 3665
//Team Project: Ken's Revenge
//Team member: Xin Guan and Joyce Chiu
//
//class Gold:
//    gold has: a random positon in the range of screen
//              a radius, 30;
//              a value, could be 5, 10 or 20
//              a color, gold, silver or brown, depends on the value it has
//    draw():
//          to draw the gold as a ellipse in its position on screen.
//          fill in its color and has a text of its value on it.

class Gold{
  
  int index;
  PVector pos = new PVector();
  int value;
  int rad;
  color c;
  
  Gold(int in, int amount){
    pos.x = random(30, 600-50); //random position
    pos.y = random(30, 600-50);
    rad = 30;
    index=in;
    value = amount;
    if(value == 5){            //if value=5, color=brown
      c= color(#896925);
    }else if(value == 10){     //if value=10, color=silver
      c = color(#AAA9A8);
    }else if(value == 20){     //if value=20, color=gold
      c= color(#F7C455);
    }
  }
  
  void draw(){                 //draw the gold
    strokeWeight(2);
    stroke(230, 128, 0); 
    fill(c);
    ellipse(pos.x, pos.y, rad, rad);
    textSize(10);
    fill(#000000);
    if(value==5){
      text(value+"", pos.x-4, pos.y+4);
    }else{
      text(value+"", pos.x-4-2, pos.y+4);
    }
    
  }
  
  
}