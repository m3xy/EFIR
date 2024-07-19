void drawLOSE() {
  background(102,0,0); //Blood colour
  write(this.g, "DEFEAT", width/2, height/2, CENTER, CENTER, 50, color(255));
  write(this.g, "Press Enter", width/2, 2*height/3, CENTER, BOTTOM, 25, color(255));
}

void drawWIN() {
  //background(251, 183, 65);  //Fire colour
  background(0,102,102); //Opposite of blood colour
  write(this.g, "VICTORY", width/2, height/2, CENTER, CENTER, 50, color(255));
  write(this.g, "Press Enter", width/2, 2*height/3, CENTER, BOTTOM, 25, color(255));
}
