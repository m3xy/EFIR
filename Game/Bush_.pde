final class Bush extends Entity {
  
  public Bush(float x, float z, float size) {
    super();
    this.pos.set(x, map.heightAt(new PVector(x, 0, z)), z);
    this.size = size;
    this.colour = color(255);
    this.mass = 0; //Immovable
  }
  
  void update() {
    super.update();
    //Collision detection
    //Player
    if(PVector.dist(player.pos, this.pos) <= this.size + player.size)
      player.addForce(PVector.sub(player.pos, this.pos).normalize().mult(player.dex));
    
    //Fire
    if(PVector.dist(fire.pos, this.pos) <= this.size + fire.size)
      this.hp = 0;
    
    //Enemies
    for(Enemy enemy : enemies.list)
      if(PVector.dist(enemy.pos, this.pos) <= this.size + enemy.size)
        enemy.addForce(PVector.sub(enemy.pos, this.pos).normalize().mult(enemy.dex));

    //Bullets
    for(Bullet bullet : bullets)
      if(PVector.dist(bullet.pos, this.pos) <= this.size + bullet.size)
        this.hp -= 0.25;
    
    //Fuel
    for(Fuel f : fuel)
      if(PVector.dist(f.pos, this.pos) <= this.size + f.size)
        f.addForce(PVector.sub(f.pos, this.pos).normalize().mult(f.dex));
    
    this.colour = color(map(this.pos.y, minH, maxH, 50, 70), map(this.hp, 0, this.maxHP, 0, 255));
  }
  
  void draw() {
    shrub.setFill(this.colour);
    fps.translate(this.pos.x, this.pos.y, this.pos.z);
    fps.noStroke();
    fps.scale(this.size/110);
    fps.shape(shrub);
  }
}
