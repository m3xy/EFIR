color crosshair;

void drawHUD() {
  hud.beginDraw();
  hud.background(color(102,0,0, map(player.hp, 0, player.maxHP/4, 255, 0)), 200); //Transparent background unless hurt (below quarter hp)
  //CROSSHAIR
  crosshair = lerpColor(color(0,255,0), color(255,0,0), map(player.hp, 0, player.maxHP, 1, 0));
  if(player.blocking) { //Blocking
    hud.fill(crosshair, 90);
    hud.noStroke();
    hud.circle(width/2, height/2, 30);
  }
  hud.fill(0,0);
  hud.stroke(crosshair);
  hud.strokeWeight(1);
  //hud.arc(width/2, height/2, 12, 12, -HALF_PI, map(player.hp, 0, player.maxHP, 0, TWO_PI)-HALF_PI); //Display bug: Inaccurate with increased strokeWeights
  float angle = map(player.hp, 0, player.maxHP, 0, TWO_PI)-HALF_PI; //HP
  for(int i = 9; i < 16; i++)
    hud.arc(width/2, height/2, i, i, -HALF_PI, angle);
  hud.circle(width/2, height/2, 8);
  hud.circle(width/2, height/2, 16);
  
  
  float point = atan2(fire.pos.x-player.pos.x, fire.pos.z-player.pos.z);
  float size = map(fire.hp, 0, fire.maxHP, QUARTER_PI/8, QUARTER_PI);
  hud.stroke(lerpColor(color(0,255,0), color(255,0,0), map(fire.hp, 0, fire.maxHP, 1, 0)));
  switch(view) {
    case FPS:
      for(int i = 20; i < 27; i++)
        hud.arc(width/2, height/2, i, i, (point - player.rPos.y) + HALF_PI - size, (point - player.rPos.y) + HALF_PI + size);
      break;
    case MAP:
      for(int i = 20; i < 27; i++)
        hud.arc(width/2, height/2, i, i, point - HALF_PI - size, point - HALF_PI + size);
      break;
  }

  
  drawHelp(hud);

      

  
  hud.endDraw();
  image(hud, 0, 0);
}
