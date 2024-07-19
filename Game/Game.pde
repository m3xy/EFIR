import java.awt.Robot;
import java.awt.AWTException;
import java.util.Iterator;

//DISPLAY
PGraphics fps, hud; //First Person Shooter, Heads-up display
Robot robot;

//GAME
State state = State.MENU;

//Player
PShape hero;

//Enemy
PShape ghost;

//Bush
PShape shrub;

//SETUP
void setup() {
  size(1920, 1080);
  w = width;
  h = height;
  hero = loadShape("hero.obj");
  ghost = loadShape("ghost.obj");
  shrub = loadShape("shrub.obj");
  fullScreen(P2D, SPAN);                        //Menu
  fps = createGraphics(width, height, P3D);     //First person view
  hud = createGraphics(width, height, JAVA2D);  //Heads-up display
  try{
    robot = new Robot();
  }catch(AWTException e) {
    System.err.println("Error: Setting up robot");
  }
  restart();
}

//DRAW
void draw() {
  background(255); //White BG
  
  switch(state) {
    case MENU :
      cursor();  //Show cursor
      drawMENU();
      break;
    case PLAY :
      noCursor();  //Hide cursor
      drawFPS();
      drawHUD();
      robot.mouseMove(width/2,height/2); //Move cursor back to center
      break;
    case WIN :
      cursor();  //Show cursor
      drawWIN();
      break;
    case LOSE :
      cursor();  //Show cursor
      drawLOSE();
      break;
  }
}
