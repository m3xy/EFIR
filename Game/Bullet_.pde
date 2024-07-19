PVector gravity = new PVector(0,-0.2,0);

final class Bullet extends Entity {
  
  Entity firer;
  
  Bullet(Entity firer) {
    super();
    this.pos.set(firer.pos.copy());
    this.rPos.set(firer.rPos.copy());
    this.damping = 0.99;
    this.size = 3;
    this.energy = 40; //Bullet force
    this.firer = firer;
    this.colour = color(251, 183, 65);
  }
  
  void update() {
    super.update();
    
    //Collision detection
    if(this.pos.x > size/2 && this.pos.x < (map.land.length * map.lod) - map.lod - size/2 && this.pos.z > size/2 && this.pos.z < (map.land[0].length * map.lod) - map.lod - size/2) { //Within map
      for (Iterator<Enemy> iterator = enemies.list.iterator(); iterator.hasNext(); ) { 
        Enemy enemy = iterator.next();
        if(PVector.dist(this.pos, enemy.pos) <= this.size + enemy.size) {  //Hit enemy
          enemy.addForce(PVector.sub(enemy.pos, player.pos).normalize().mult(this.energy/2)); //Knockback from player not bullet
          enemy.hp -= firer.dmg * firer.energy;
          this.hp = 0;
        }
      }
      if(PVector.dist(this.pos, fire.pos) <= (this.size) + (fire.size)) {  //Hit fire
        fire.feed((fire.maxHP/2) * (firer.energy/firer.maxHP) * firer.dmg); //Tined
        this.hp = 0;
      }else if(this.pos.y < map.heightAt(this.pos)) { //Hit ground
        this.hp = 0;
        //this.vel.mult(0);
        //this.colour = color(0,0);
      }
    } else {
     this.hp = 0; 
    }
    this.addForce(gravity);  //Apply gravity (for potentially impossible to reach flames)
    
  }
  
  void draw() {
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.noStroke();
    fps.fill(this.colour);
    fps.sphere(this.size);
  }
  
  void fire() {
    this.addForce(new PVector(energy*(sin(this.rPos.x) * sin(this.rPos.y)), energy*cos(this.rPos.x), energy*(sin(this.rPos.x) * cos(this.rPos.y))));
  }
}
