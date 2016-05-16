//CISC 3665
//Team Project: Ken's Revenge
//Team member: Xin Guan and Joyce Chiu
//
//class Swift:
//    swift has: a random positon in the range of screen
//               a radius, 20
//    draw():
//          draw swiftness as a blue ellipse with a "≈" text on it 
//          in color of flashing blue color.
class Swift{
  
  PVector pos = new PVector();
  int rad=20;
  
  Swift()
  {
    pos.x = random(0, 600);
    pos.y = random(0, 600);
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