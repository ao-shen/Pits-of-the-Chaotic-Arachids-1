

int ALL_DIRECTION = 4;
int TOP_DIRECTION = 0;
int BOTTOM_DIRECTION = 1;
int LEFT_DIRECTION = 2;
int RIGHT_DIRECTION = 3;

int gridSize = 50;

void GridCopy(byte [][] srcGrid, byte [][] dstGrid)
{
  println("KKK");
  for (int i = 0; i < srcGrid.length; i++)
    dstGrid[i] = srcGrid[i].clone();
}

void updateGrids()
{
  
  boolean didGoToNewChunk = true;
  if (player.x>=2*width) // Right
  {
    ChunkCopy(CenterChunk, LeftChunk);
    ChunkCopy(RightChunk, CenterChunk);
    RightChunk = MakeNewChunk(LEFT_DIRECTION);
    TopChunk = MakeNewChunk(BOTTOM_DIRECTION);
    BottomChunk = MakeNewChunk(TOP_DIRECTION);

    player.x -= width;
    camX -= width;
  } else if (player.y>=2*height) // Bottom
  {
    ChunkCopy(CenterChunk, TopChunk);
    ChunkCopy(BottomChunk, CenterChunk);
    RightChunk = MakeNewChunk(LEFT_DIRECTION);
    BottomChunk = MakeNewChunk(TOP_DIRECTION);
    LeftChunk = MakeNewChunk(RIGHT_DIRECTION);

    player.y -= height;
    camY -= height;
  } else if (player.x>=width&&player.y>=height) // Center
  {
    // Nothing
    didGoToNewChunk = false;
  } else if (player.y>=height) // Left
  {
    ChunkCopy(CenterChunk, RightChunk);
    ChunkCopy(LeftChunk, CenterChunk);
    LeftChunk = MakeNewChunk(RIGHT_DIRECTION);
    TopChunk = MakeNewChunk(BOTTOM_DIRECTION);
    BottomChunk = MakeNewChunk(TOP_DIRECTION);

    player.x += width;
    camX += width;
  } else // Top
  {
    ChunkCopy(CenterChunk, BottomChunk);
    ChunkCopy(TopChunk, CenterChunk);
    RightChunk = MakeNewChunk(LEFT_DIRECTION);
    TopChunk = MakeNewChunk(BOTTOM_DIRECTION);
    LeftChunk = MakeNewChunk(RIGHT_DIRECTION);

    player.y += height;
    camY += height;
  }
  if(didGoToNewChunk)
  {
    updatePathFindingWallGrid();
  }
}

void displayGrids()
{
  pushMatrix();
  translate(width, height);randomSeed(CenterChunk.colorSeed);
  displayGrid(CenterChunk.Grid);
  popMatrix();
  pushMatrix();
  translate(width, 0);randomSeed(TopChunk.colorSeed);
  displayGrid(TopChunk.Grid);
  popMatrix();
  pushMatrix();
  translate(width, 2*height);randomSeed(BottomChunk.colorSeed);
  displayGrid(BottomChunk.Grid);
  popMatrix();
  pushMatrix();
  translate(0, height);randomSeed(LeftChunk.colorSeed);
  displayGrid(LeftChunk.Grid);
  popMatrix();
  pushMatrix();
  translate(2*width, height);randomSeed(RightChunk.colorSeed);
  displayGrid(RightChunk.Grid);
  popMatrix();
}
void displayGrid(byte [][] grid)
{
  for (int i=0; i<grid.length; i++) {
    for (int j=0; j<grid[0].length; j++) {
      if (grid[i][j]==0)
        fill(random(150, 200), random(220, 255), random(150, 200));
      else if (grid[i][j]==1)
        fill(0);
      rect(i*gridSize, j*gridSize, gridSize, gridSize);
    }
  }
}

void setGridAtLocation(float x1, float y1, byte v1)
{
  if (x1>=2*width)
    RightChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)] = v1;
  else if (y1>=2*height)
    BottomChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)] = v1;
  else if (x1>=width&&y1>=height)
    CenterChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)] = v1;
  else if (y1>=height)
    LeftChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)] = v1;
  else// if(x1>=width)
  TopChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)] = v1;
}

int gridAtLocation(float x1, float y1)
{
  if (x1>=2*width)
    return (int)(RightChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)]);
  else if (y1>=2*height)
    return (int)(BottomChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)]);
  else if (x1>=width&&y1>=height)
    return (int)(CenterChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)]);
  else if (y1>=height)
    return (int)(LeftChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)]);
  else// if(x1>=width)
  return (int)(TopChunk.Grid[(int)(x1%width/gridSize)][(int)(y1%height/gridSize)]);
}

int gridify(float x1)
{
  return (int)(x1/gridSize);
}

void drawGrid(int i1, int j1, int c1)
{
  if (c1 == 0)
    fill(255, 150, 150);
  else if (c1 == 1)
    fill(255, 255, 150);
  //rect(i1*gridSize, j1*gridSize, gridSize, gridSize);
}

