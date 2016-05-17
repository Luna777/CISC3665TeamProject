#CISC 3665										5/17/2016	
Lab IV.1 Team Project -- Technical Documentation
Team Member: Joyce Chiu,  Xin Guan

#Ken’s Revenge

#Game Overview:
	This game is developed in Processing and able to run on Windows, OSX, Linux system. 
	It has 1 main function file and 5 object classes, Ken, Thief, Gold, Swift, Trap.
	3 game screens, title screen, play screen, game over screen.

#Implementation:
	
1.main functions:
	functional variables: state (could be START, RUNNING, GAMEOVER)
			         time (keep reading the real time in second for time delay functions)
			         kenScore, thiefScore (recording their total score)
setup(): initialize all the objects and variables
draw(): read the value of “state” to show title screen, play screen or game over screen.
In title screen:
draw background1, title and instruction to start the game. 
In play screen:
	draw background2.
draw objects: Ken, Thief, golds, trap items, swiftness, trapArea, 
 	keep updating all the detection, action and movement algorithms,
include items collision detection, time recorder(time delay function), 
action to use items, player's movement by key, agent's movement by gold finding algorithm.
		In game over screen:
			draw background3.
			draw win message, instruction to restart. 

2.class Ken: 
   has: ken's position, velocity, radius, buffers for trap function, time delay variables

   draw(): draw ken as a green ellipse with a letter K.
   move(): move ken by the direction passed in. 
   speedup(), speeddown(), speedRestore(): to change ken's speed.
   gotSwift(), gotGold(), gotTrap(): to detect collision with items.
   putTrap(): put trap down to the position and make a little time delay.

3.(AI) class Thief:
   has: thief's position, velocity, radius, buffers for trap function, time delay variables

   draw(): draw thief as a red ellipse with a letter T.
   (AI) move(): move thief by the direction passed in. 
   (AI) findDir(): find the first gold it can see and return the direction of that gold
   speedup(), speeddown(), speedRestore(): to change thief's speed.
   (AI) gotSwift(), gotGold(), gotTrap(): to detect collision with items.
   (AI) putTrap(): put trap down to the position.

4.class Gold:
   gold has: a random position in the range of screen
             a radius, 30;
             a value, could be 5, 10 or 20
             a color, gold, silver or brown, depends on the value it has
   draw():
         to draw the gold as an ellipse in its position on screen.
         fill in its color and has a text of its value on it.

5.class Swift:
   swift has: a random position in the range of screen
              a radius, 20
   draw():
         draw swiftness as an ellipse with a "≈" text on it 
         in color of flashing blue color.
6.class Trap:
   trap has: a random position in the range of screen
             a radius, 20
   draw():
         draw trap item as an ellipse with a "↓" text on it 
         in color of flashing dark gray


