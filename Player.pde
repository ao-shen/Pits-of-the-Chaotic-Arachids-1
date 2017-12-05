

class Player
{
  int x;
  int y;
  
  float xvel;
  float yvel;
  
  Player(int x1,int y1)
  {
    x = x1;
    y = y1;
    
    xvel = 0;
    yvel = 0;
  }
  
  void update()
  {
    
    if(keyHeldDown['A'])
      xvel-=3;
    if(keyHeldDown['D'])
      xvel+=3;
    if(keyHeldDown['W'])
      yvel-=3;
    if(keyHeldDown['S'])
      yvel+=3;
      
    xvel = constrain(xvel, -17, 17);
    yvel = constrain(yvel, -17, 17);
    //println(str(frameCount)+" "+str(xvel)+" "+str(yvel));
      
    x = constrain(x, 0, 3*width-gridSize);
    y = constrain(y, 0, 3*height-gridSize);
      
    //println(xvel + " " + yvel);
    xvel *= 0.7;
    if(abs(xvel)<0.1)
      xvel = 0;
      
    x += (int)xvel;
      
    float boundingBoxLeft = x + 5;
    float boundingBoxRight = x+gridSize - 5;
    float boundingBoxTop = y + 5;
    float boundingBoxBottom = y+gridSize - 5;
    
    if (xvel<0)
    {
      drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxTop+1),1);
      drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxBottom-1),1);
      
      if (gridAtLocation(boundingBoxLeft, boundingBoxTop+1)==1) {
        drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxTop+1),0);
        xvel = 0;
        x = gridify(boundingBoxLeft)*gridSize+gridSize - 5;
      }else if (gridAtLocation(boundingBoxLeft, boundingBoxBottom-1)==1) {
        drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxBottom-1),0);
        xvel = 0;
        x = gridify(boundingBoxLeft)*gridSize+gridSize - 5;
      }
    }
   if (xvel>0)
    {
      drawGrid(gridify(boundingBoxRight),gridify(boundingBoxTop+1),1);
      drawGrid(gridify(boundingBoxRight),gridify(boundingBoxBottom-1),1);
      
      if (gridAtLocation(boundingBoxRight, boundingBoxTop+1)==1) {
        drawGrid(gridify(boundingBoxRight),gridify(boundingBoxTop+1),0);
        xvel = 0;
        x = gridify(boundingBoxLeft)*gridSize + 5;
      }else if (gridAtLocation(boundingBoxRight, boundingBoxBottom-1)==1) {
        drawGrid(gridify(boundingBoxRight-1),gridify(boundingBoxBottom-1),0);
        xvel = 0;
        x = gridify(boundingBoxLeft)*gridSize + 5;
      }
    }
    
    yvel *= 0.7;
    if(abs(yvel)<0.1)
      yvel = 0;
      
    y += (int)yvel;

    boundingBoxLeft = x + 5;
    boundingBoxRight = x+gridSize - 5;
    boundingBoxTop = y + 5;
    boundingBoxBottom = y+gridSize - 5;
   
    if (yvel>0)
    {
      drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxBottom),1);
      drawGrid(gridify(boundingBoxRight-1),gridify(boundingBoxBottom),1);
      
      if (gridAtLocation(boundingBoxLeft, boundingBoxBottom)==1) {
        drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxBottom),0);
        yvel = 0;
        y = gridify(boundingBoxTop)*gridSize + 5;
      } else if (gridAtLocation(boundingBoxRight-1, boundingBoxBottom)==1) {
        drawGrid(gridify(boundingBoxRight-1),gridify(boundingBoxBottom),0);
        yvel = 0;
        y = gridify(boundingBoxTop)*gridSize + 5;
      }
    }
    if (yvel<0)
    {
      drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxTop),1);
      drawGrid(gridify(boundingBoxRight-1),gridify(boundingBoxTop),1);
      
      if (gridAtLocation(boundingBoxLeft, boundingBoxTop)==1) {
        drawGrid(gridify(boundingBoxLeft),gridify(boundingBoxTop),0);
        yvel = 0;
        y = gridify(boundingBoxTop)*gridSize+gridSize - 5;
      } else if (gridAtLocation(boundingBoxRight-1, boundingBoxTop)==1) {
        drawGrid(gridify(boundingBoxRight),gridify(boundingBoxTop),0);
        yvel = 0;
        y = gridify(boundingBoxTop)*gridSize+gridSize - 5;
      }
    }
    
    boundingBoxTop = y + 5;
    boundingBoxBottom = y+gridSize - 5;

    fill(0,255,255);
    rectMode(CORNERS);
    rect(boundingBoxLeft,boundingBoxTop,boundingBoxRight,boundingBoxBottom);
    rectMode(CORNER);
  }
  
  void display()
  {
    fill(#55FFFF);
    
    pushMatrix();
    
    translate(x,y);
    
    //rect(0,0,2*gridSize,2*gridSize);
    
    popMatrix();
  }
}