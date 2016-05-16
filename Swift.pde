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
class Swift{
  
  PVector pos = new PVector();
  int rad=20;
  
  Swift()
  {
    pos.x = random(0, width);
    pos.y = random(0, height);
    //System.out.println(pos.x +" "+ pos.y);
  }
  
  void draw()
  {
    strokeWeight(1.2);
    stroke(0, 102, 204); //dark blue
    fill(51, 153, 255); //light blue
    
    boolean on=true;
    if(frameCount% 10== 0) {
      if(on)
        fill(0);
      else
        fill(255);
      on = !on;
    }
    ellipse(pos.x, pos.y, 1.4*rad, 1.4*rad);
    fill(#ffffff);
    textSize(18);
    text("≈", pos.x-rad/2+3, pos.y+rad/2-5);
  }
  
}