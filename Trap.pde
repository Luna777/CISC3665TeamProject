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
class Trap{
  
  PVector pos = new PVector();
  int rad;
  
  Trap()
  {
    pos.x = random(0, 600);
    pos.y = random(0, 400);
    rad = 20;
  }
  
  void draw()
  {
    strokeWeight(1.2);
    stroke(64); //dark gold
    fill(96); //gold
    
    boolean on=true;
    if(frameCount% 10 == 0) {
      if(on)
        fill(0);
      else
        fill(255);
      on = !on;
    }
    ellipse(pos.x, pos.y, 1.4*rad, 1.4*rad);
    fill(#ffffff);
    textSize(18);
    text("↓", pos.x-rad/2+5, pos.y+rad/2-3);
  }
  
  
}