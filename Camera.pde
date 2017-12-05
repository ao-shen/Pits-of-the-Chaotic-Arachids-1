
float camX;
float camY;

float camVelX;
float camVelY;

void initCamera()
{
  camX = width;
  camY = height;
  camVelX = 0;
  camVelY = 0;
}

void updateCamera()
{   
  camVelX = int(width-(camX)) / 30.0;
  camVelY = int(height-(camY)) / 30.0;
  
  camX += camVelX;
  camY += camVelY;
  
  camX = constrain(camX,0,2*width);
  camY = constrain(camY,0,2*height);
  
  translate(-camX,-camY); 
}
