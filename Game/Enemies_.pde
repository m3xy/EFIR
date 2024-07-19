final class Enemies {
  ArrayList<Enemy> list;
  
  Enemies() {
    list = new ArrayList<>();
  }
  
  void run() {
    if((int)random(60 * 5) == 1 && this.list.size() < 10) {  //Roughly try spawn once every 5 seconds (assumes 60fps), 10 max
      PVector pos = new PVector(random(w), 0, random(h));
        if(PVector.dist(pos, fire.pos) >= fire.hp){
        list.add(new Enemy(pos, 10));
      } 
    }
    for (Iterator<Enemy> iterator = list.iterator(); iterator.hasNext(); ) { 
      Enemy enemy = iterator.next();
      enemy.run();
      if(enemy.dead()) {
        enemy.drop();
        iterator.remove();
      }
        
    }
  }
  
  
}
