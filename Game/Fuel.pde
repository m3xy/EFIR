final class Fuel extends Entity {
  
  Fuel(float x, float y, float z, float hp) {
    super();
    this.pos.set(x,y,z);
    this.size = 6;
    this.maxHP = hp;
    this.hp = this.maxHP;
  }
  
  void update() {
    super.update();
    
    //Collision detection
    if(PVector.dist(this.pos, player.pos) < this.size + player.size) {
      this.hp = 0;
      player.heal(player.maxHP); //May overheal
    }
    
    this.hurt(0.1);
    this.colour = color(251, 183, 65, map(this.hp, 0, this.maxHP, 0, 255));
  }
  
  void draw() {
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.noStroke();
    fps.fill(this.colour);
    fps.sphere(size);
  }
}
