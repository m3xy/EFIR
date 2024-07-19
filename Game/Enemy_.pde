final class Enemy extends Entity {
  float offset = 0;
  
  Enemy(PVector pos, float hp){
    super();
    this.pos.set(pos);
    this.maxHP = hp;
    this.hp = this.maxHP;
    this.damping = 0.5;
    this.size = player.size;
    //super(new PVector(x,0,z), new PVector(PI+QUARTER_PI,random(TWO_PI),0), 1, 0.5, 0.2, hp);
  }
  
  void update() {
    //Collision with land
    this.pos.x = constrain(this.pos.x, 0 + size/2, (map.land.length * map.lod) - map.lod - size/2);
    this.pos.z = constrain(this.pos.z, 0 + size/2, (map.land[0].length * map.lod) - map.lod - size/2);
    this.pos.y = map.heightAt(this.pos) + size/2;
    
    super.update();
    
    //Collision detection
    
    if(PVector.dist(player.pos, fire.pos) > fire.hp && PVector.dist(this.pos, player.pos) < 20 * this.size)  //If player outside of fire radius and within range
      this.rPos.y = atan2(player.pos.x-this.pos.x, player.pos.z-this.pos.z); //Stares at player
    else if(PVector.dist(this.pos, fire.pos) < fire.hp * 1.05)
      this.rPos.y = atan2(this.pos.x-fire.pos.x, this.pos.z-fire.pos.z);
    else
      this.rPos.y = noise(this.offset) * TWO_PI * 2;
    this.addForce(new PVector(dex*sin(this.rPos.y),0,dex*cos(this.rPos.y))); //Move forwards
    this.offset += 0.01;
    
    if(PVector.dist(this.pos, fire.pos) < fire.hp) //Hit fire
      this.hp -= 0.1;
    if(PVector.dist(this.pos, player.pos) < this.size/2) { //Hit player
      this.hp = 0;
      this.energy = 0;
      player.hurt(0.2*player.maxHP);
    }
    
    this.colour = lerpColor(color(128), color(251, 183, 65, map(this.hp, 0, this.maxHP, 255, 0)), map(this.hp, 0, this.maxHP, 1, 0));
      
  }
  
  
  void draw() {
    ghost.setFill(this.colour);
    fps.translate(this.pos.x, this.pos.y - this.size/2, this.pos.z);
    fps.rotateY(this.rPos.y - HALF_PI);
    fps.scale(size/70);
    fps.shape(ghost);
    

  }
  
  void drop() {
    if(this.energy > 0)
      fuel.add(new Fuel(this.pos.x, this.pos.y, this.pos.z, 100));
  }
}
