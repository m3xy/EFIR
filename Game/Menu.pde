boolean help = false; //Show Help
String controls = 
  "W : Forward\n" +
  "A : Left\n" +
  "S : Backward\n" +
  "D : Right\n" +
  "SPACE : Dash\n\n" +
  "LMB : Shoot\n" +
  "RMB : Block\n\n" +
  "TAB : Swap view\n" +
  "SCROLL : Zoom";

String rules = 
  "* Kill (shoot) enemies for fuel\n" + 
  "* Light/Fuel heals player\n" +
  "* Dark/Enemy/Shoot/Dash hurts player\n" +
  "* Block reduces speed and damage taken\n" +
  "* Fuel (shoot) fire to increase its energy";

void drawMENU() {
  background(20,20,25);
  write(this.g, "E F I R", width/2, height/2, CENTER, CENTER, 50, color(255));
  write(this.g, "Press Enter", width/2, 2*height/3, CENTER, BOTTOM, 25, color(255));
  drawHelp(this.g);
}

//Writes text
void write(PGraphics ctx, String text, float x, float y, int alignX, int alignY, float size, color colour)  {
  ctx.fill(colour);
  ctx.textSize(size);
  ctx.textAlign(alignX, alignY);
  ctx.text(text, x, y);
}

void drawHelp(PGraphics ctx) {
  if(help) {
    write(ctx, "H - Hide", 0, 0, LEFT, TOP, 17, color(255));
    write(ctx, (int)frameRate + " fps", width, 0, RIGHT, TOP, 15, color(255)); //FPS
    write(ctx, "CONTROLS:", 0.9 * width, 0.05 * height, LEFT, TOP, 20, color(255));
    write(ctx, controls, 0.9 * width, 0.1 * height, LEFT, TOP, 17, color(255));
    write(ctx, "WIN BY", 0.485 * width, 0.05 * height, LEFT, TOP, 20, color(255));
    write(ctx, "+ Maximising fire's energy", 0.485 * width, 0.1 * height, LEFT, TOP, 17, color(255));
    write(ctx, "INTERFACE:", 0.72 * width, 0.05 * height, LEFT, TOP, 20, color(255));
    write(ctx, "        : Player's      (HP/Crosshair)\n        : Fire's            (HP/Direction)", 0.72 * width, 0.1 * height, LEFT, TOP, 17, color(255));
    
    ctx.strokeWeight(5);
    ctx.noFill();
    ctx.stroke(lerpColor(color(0,255,0), color(255,0,0), 0.25));
    ctx.arc(0.72 * width + 12, 0.1 * height + 12, 12, 12, -HALF_PI, PI);
    ctx.arc(0.72 * width + 12, 0.125 * height + 12, 23, 23, HALF_PI-(QUARTER_PI/2), HALF_PI+(QUARTER_PI/2));
    ctx.strokeWeight(1);
    ctx.circle(0.72* width + 12, 0.1 * height + 12, 8);
    ctx.circle(0.72 * width + 12, 0.1 * height + 12, 16);
    
    write(ctx, "RULES:", 0.04 * width, 0.05 * height, LEFT, TOP, 20, color(255));
    write(ctx, rules, 0.04 * width, 0.1 * height, LEFT, TOP, 17, color(255));
    write(ctx, "LOSE BY", 0.24 * width, 0.05 * height, LEFT, TOP, 20, color(255));
    write(ctx, "- Player runs out of health\n- Fire runs out of energy", 0.24 * width, 0.1 * height, LEFT, TOP, 17, color(255));
    
  } else {
    write(ctx, "H - Help", 0, 0, LEFT, TOP, 17, color(255));
  }
}
