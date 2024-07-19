final class Map {
  Vertex[][] land;
  int lod;
  Map(int w, int d, int lod, float minH, float maxH) {
    this.lod = lod;
    int cols = w/lod, rows = d/lod; //Number of columns and rows in the land mesh
    land = new Vertex[cols][rows];  //Declare vertices
 
    //Initialise land
    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        float z = map(noise(xoff, yoff), 0, 1, minH, maxH); //Height determined by Perlin noise values
        //land[x][y] = new Vertex(z, color(map(z, minH, maxH, 25, 230)));
        land[x][y] = new Vertex(z, color(map(z, minH, maxH, 50, 70)));
        //land[x][y] = new Vertex(z, color(0));
        //land[x][y] = new Vertex(z, color(50));
        xoff+=map(lod, 1, 100, 0.01, 0.15);
      }
      yoff+=map(lod, 1, 100, 0.01, 0.15);
    }
  }
  
  class Vertex {
    float h;       //Height of the vertex
    color colour;  //Colour of the vertex
    Vertex(float h, color colour) {
      this.h = h;
      this.colour = colour;
    }
  }
  
  void draw() {
    //FPS
    for (int y = 0; y < land[0].length-1; y++) { //Rows
      fps.beginShape(TRIANGLE_STRIP);
      fps.noStroke();
      //fps.stroke(1);
      for (int x = 0; x < land.length; x++) {    //Cols
        fps.fill(land[x][y].colour); //land colour
        fps.vertex(x*lod, land[x][y].h, y*lod);
        fps.fill(land[x][y+1].colour); //land colour
        fps.vertex(x*lod, land[x][y+1].h, (y+1)*lod);
      }
      fps.endShape();
    }
    //HUD
  }
  
  //Bilinear interpolation to find height
  float heightAt(PVector pos) {
    float x = pos.x/lod;
    float z = pos.z/lod;
    int x1 = (int)Math.floor(pos.x/lod);
    int x2 = (int)Math.ceil(pos.x/lod);
    int z1 = (int)Math.floor(pos.z/lod);
    int z2 = (int)Math.ceil(pos.z/lod);
    float f11 = map.land[x1][z1].h;
    float f12 = map.land[x1][z2].h;
    float f21 = map.land[x2][z1].h;
    float f22 = map.land[x2][z2].h;
    float f1 = (((x2-x)/(x2-x1))*f11) + (((x-x1)/(x2-x1))*f21);
    float f2 = (((x2-x)/(x2-x1))*f12) + (((x-x1)/(x2-x1))*f22);
    return (((z2-z)/(z2-z1))*f1) + (((z-z1)/(z2-z1))*f2);
  }
}
