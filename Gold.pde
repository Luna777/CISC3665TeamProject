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

class Gold{
  
  int index;
  PVector pos = new PVector(-50, -50);
  int value; //
  int rad;
  color c;
  
  Gold(int in, int amount){
    pos.x = random(30, 600-50);
    pos.y = random(30, 600-50);
    rad = 30;
    index=in;
    value = amount;
    if(amount == 5){
      c= color(#896925);
    }else if(amount == 10){
      c = color(#AAA9A8);
    }else if(amount == 20){
      c= color(#F7C455);
    }
    
    //System.out.println(index+ ":"+value+" "+pos.x+" "+ pos.y);
    
  }
  
  void draw(){
    strokeWeight(2);
    stroke(230, 128, 0); //dark gold
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