


boolean [] keyHeldDown = new boolean[255];

Player player;

void setup() {
  size(800, 800);

  //noStroke();
  stroke(150);

  frameRate(50);

  player = new Player(width+width/2, height+height/2);

  initChunks();

  initCamera();
  initSounds();
  
  initPathFinding();
}

void keyPressed() {
  
  if(keyCode == 'O' && !keyHeldDown[keyCode])
  {
    printChunk();
  }
  
  keyHeldDown[keyCode] = true;
  
  println(str(frameCount)+" "+str(key));
  
  //println(str(frameCount)+" "+str(keyHeldDown['A'])+" "+str(keyHeldDown['S'])+" "+str(keyHeldDown['D'])+" "+str(keyHeldDown['W']));
}

void keyReleased() {
  //println(str(frameCount)+" "+str(key));
  keyHeldDown[keyCode] = false;
}

void mousePressed() {

  playSound();

  if (mouseButton==LEFT) {
    setGridAtLocation(mouseX+camX, mouseY+camY, (byte)1);
  } else if (mouseButton==RIGHT) {
    setGridAtLocation(mouseX+camX, mouseY+camY, (byte)0);
  }
}

void draw()
{
  background(255);

  if (mousePressed)
  {
    //playSound();
    if (mouseButton==LEFT) {
      setGridAtLocation(mouseX+camX, mouseY+camY, (byte)1);
    } else if (mouseButton==RIGHT) {
      setGridAtLocation(mouseX+camX, mouseY+camY, (byte)0);
    }
    
    updatePathFindingWallGrid();
  }

  //scale(1.0/3);
  updateGrids();

  pushMatrix();
  updateCamera();

  displayGrids();

  player.update();
  player.display();
  
  //pushMatrix();
  //translate(-width,-height);
  //updatePathFinding();
  //popMatrix();

  popMatrix();
  
  
}