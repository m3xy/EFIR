void keyPressed() {
  switch(state) {
    case MENU:
      switch(key) {
        case ENTER :
          state = State.PLAY;
          restart();
          break;
        case 'h' :
        case 'H' :
          help = !help;
          break;
      }
      break;
    case PLAY:
      if (key == CODED) {
        //System.out.println(keyCode);
        //switch (keyCode) {
        //  case java.awt.event.KeyEvent.VK_F1:
        //  case java.awt.event.KeyEvent.VK_NUMPAD1:
        //    help = true;
        //    break;
        //}
      } else {
        switch (key) {  //Movement
          case 'w' :
          case 'W':
            player.forward = true;
            break;
          case 'a' :
          case 'A' :
            player.left = true;
            break;
          case 's' :
          case 'S' :
            player.backward = true;
            break;
          case 'd' :
          case 'D' :
            player.right = true;
            break;
          case ' ' :
            player.dash();
            break;
          case TAB :   //Map
            view = View.MAP;
            break;
          case 'h' :
          case 'H' :
            help = !help;
            break;
        }
      }
      break;
    case WIN:
    case LOSE:
      if(key == ENTER)
        state = State.MENU;
      break;
      
  }

}

void keyReleased() {
  if(state != State.PLAY) return;
  if (key == CODED) {
    switch (keyCode) {
    }
    
  } else {
    switch (key) {  //Movement
      case 'w' :
      case 'W' :
        player.forward = false;
        break;
      case 'a' :
      case 'A' :
        player.left = false;
        break;
      case 's' :
      case 'S' :
        player.backward = false;
        break;
      case 'd' :
      case 'D' :
        player.right = false;
        break;
      case TAB :    //Map
        view = View.FPS;
        break;
    }
  }

}

void mousePressed() {
  switch(state) {
    case MENU:
      //state = State.PLAY;
      //restart();
      break;
    case PLAY:
      switch(mouseButton) {
        case LEFT :
          player.firing = true;
          break;
        case RIGHT :
          player.blocking = true;
          break;
      }
      break;
    case WIN:
    case LOSE:
      //state = State.MENU;
      break;
  }

}

void mouseReleased() {
  if(state != State.PLAY) return;
  switch(mouseButton) {
    case LEFT :
      player.firing = false;
      break;
    case RIGHT :
      player.blocking = false;
      break;
  }
}

//Detects scrolling mouse wheel
void mouseWheel(MouseEvent event) {
  if(state != State.PLAY) return;
  zoom += 20 * event.getCount(); //Used in views to zoom
  zoom = constrain(zoom, -800, 800);
}
