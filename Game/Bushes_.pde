final class Bushes {
  ArrayList<Bush> list;
  
  Bushes(int bushAmount) {
    list = new ArrayList<>();
    for(int i = 0; i < bushAmount; i++)
      list.add(new Bush(random(w-lod-(player.size*2)), random(h-lod-(player.size*2)), random(player.size, player.size*2)));
  }
  
  void run() {
    for (Iterator<Bush> iterator = list.iterator(); iterator.hasNext(); ) { 
      Bush bush = iterator.next();
      bush.run();
      if(bush.dead())
        iterator.remove();
    }
  }
}
