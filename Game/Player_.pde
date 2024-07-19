long cooldown = 100; //ms

final class Player extends Entity {
  boolean forward = false, backward = false, left = false, right = false, firing = false, blocking = false;
  long cd = 0;
  
  public Player(float x, float z, float hp) {
    super();
    this.pos.set(x,0,z);
    this.rPos.set(PI+(4*QUARTER_PI/3),random(TWO_PI),0); //Look up and random directoin
    this.damping = 0.5;
    this.size = 20;
    this.energy = 2; //Amount of health taken from using abilities
    this.maxHP = hp;
    this.hp = maxHP;
  }

  void update() {
    if(forward)
      this.addForce(new PVector(-dex*sin(this.rPos.y),0,-dex*cos(this.rPos.y)));
    if(backward)
      this.addForce(new PVector(dex*sin(this.rPos.y),0,dex*cos(this.rPos.y)));
    if(left)
      this.addForce(new PVector(dex*sin(this.rPos.y + HALF_PI),0,dex*cos(this.rPos.y + HALF_PI)));
    if(right)
      this.addForce(new PVector(dex*sin(this.rPos.y - HALF_PI),0,dex*cos(this.rPos.y - HALF_PI)));
    super.update();
    
    //Collision with land
    this.pos.x = constrain(this.pos.x, 0 + size/2, (map.land.length * map.lod) - map.lod - size/2);
    this.pos.z = constrain(this.pos.z, 0 + size/2, (map.land[0].length * map.lod) - map.lod - size/2);
    this.pos.y = map.heightAt(this.pos) + size/2;
    
    if(firing && System.currentTimeMillis() - cd >= cooldown) {
      fire();
      cd = System.currentTimeMillis();
    }
    
    if(blocking)
      block();
    else
      this.def = 1.0;
    
    this.colour = color(255, map(this.hp, 0, this.maxHP, 0, 255));
  }
  
  void draw() {
    hero.setFill(this.colour);
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    //fps.lightFalloff(0.8, 0.0, 0.00005); //Faster falloff
    //fps.pointLight(255, 255, 255, 0, maxH, 0);  //Vision light
    fps.rotateY(this.rPos.y + PI);
    //fps.rotateX(-this.rPos.x - HALF_PI);
    //fps.rotateZ(this.rPos.z);
    if(blocking) {
      fps.noFill();
      fps.stroke(0);
      //fps.strokeWeight(10);
      fps.box(size);
    }    
    switch(view) {
      case FPS:
        break;
      case MAP:      
        fps.scale(0.2);
        fps.shape(hero);
        break;
    }
  }
}
