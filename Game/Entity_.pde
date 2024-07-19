abstract class Entity {
  //Linear and Angular -> Static data: Position. Kinematic data: Velocity. Dynamic data: Acceleration.
  PVector pos, vel, acc, rPos, rVel, rAcc;
  
  //Mass and damping factor
  float mass, damping;
  
  //Attributes
  float size, energy, hp, maxHP, dex, dmg, def;
  color colour;
  
  public Entity() {
    this.pos = new PVector(0,0,0);
    this.vel = new PVector(0,0,0);
    this.acc = new PVector(0,0,0);
    this.rPos = new PVector(0,0,0);
    this.rVel = new PVector(0,0,0);
    this.rAcc = new PVector(0,0,0);
    this.mass = 1;
    this.damping = 1;
    this.size = 1;
    this.energy = 1;
    this.hp = 1;
    this.maxHP = 1;
    this.dex = 0.5;
    this.dmg = 1;
    this.def = 1;
    this.colour = color(255);
  }
  
  void run() {
    this.update();
    this.display();
  }
  
  void addForce(PVector force) {
    if(mass <= 0f) return; //Infinite mass
    acc.add(force.copy().div(mass));
  }
  
  void addTorque(PVector rotation) {
   if(mass <= 0f) return; //Infinite mass
   rAcc.add(rotation.copy().div(mass));
  }
  
  void update() { //or Integrate
    vel.mult(this.damping); //Apply damping
    rVel.mult(this.damping);
    vel.add(acc); //Update velocity
    rVel.add(rAcc);
    pos.add(vel); //Update position
    rPos.add(rVel);
    acc.mult(0); //Clear acceleration/accumlator
    rAcc.mult(0);
    this.hp = constrain(this.hp, 0, this.maxHP);
  }
  
  abstract void draw();
  
  void display() {
    fps.pushMatrix();
    this.draw();
    fps.popMatrix();
  }
  
  boolean dead() {
    return hp <= 0; 
  }
  
  //PLAYER COMMANDS
  void fire() {
    Bullet bullet = new Bullet(this);
    bullets.add(bullet);
    bullet.fire();
    this.hp -= this.energy * this.dmg;
  }
  
  void dash() {
    this.addForce(this.vel.mult(10));
    this.hp -= this.energy * 2 * this.dmg;
  }
  
  void block() {
    this.def = 0.5;
    this.vel.mult(0.01);
  }
  
  void hurt(float damage) {
    this.hp -= damage * def;
  }
  
  void heal(float health) {
    this.hp += health;
  }
}
