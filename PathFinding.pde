import java.util.PriorityQueue;
import java.util.Comparator;

int [][] PathFindingWallGrid = new int[48][48];

PathFinder enemyPathFinder;

void initPathFinding()
{
  updatePathFindingWallGrid();
  
  enemyPathFinder = new PathFinder(17,17);
}

void updatePathFinding()
{
  enemyPathFinder.update();
}

void updatePathFindingWallGrid()
{
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i][j] = 1;
    }
  }
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i+32][j] = 1;
    }
  }
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i][j+32] = 1;
    }
  }
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i+32][j+32] = 1;
    }
  }
  
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i+32][j+16] = RightChunk.Grid[i][j];
    }
  }
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i+16][j+16] = CenterChunk.Grid[i][j];
    }
  }
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i+16][j+16] = CenterChunk.Grid[i][j];
    }
  }
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i+16][j+16] = CenterChunk.Grid[i][j];
    }
  }
  for (int i=0; i<16; i++){
    for (int j=0; j<16; j++){
      PathFindingWallGrid[i+16][j+16] = CenterChunk.Grid[i][j];
    }
  }
}

int intDist(int x1, int y1, int x2, int y2)
{
  int xd = abs(x1-x2);
  int yd = abs(y1-y2);
  int dd = abs(xd-yd);
  int ans = 0;//10 * (xd+yd);
  if (xd<yd)
  {
    ans = 14 * xd;
    ans += dd * 10;
  } else
  {
    ans = 14 * yd;
    ans += dd * 10;
  }
  return ans;
}

class PathFinder
{
  int xStart;
  int yStart;
  int xEnd;
  int yEnd;

  int startsss;

  pathGridTile [][] pathGrid = new pathGridTile[48][48];
  PriorityQueue<pathGridTile> pq;

  PathFinder(int x1, int y1)
  {
    xStart = x1;
    yStart = y1;

    reset();
  }

  void reset()
  {
    xEnd = gridify(player.x+20);
    yEnd = gridify(player.y+20);
    
    for (int i=0; i<PathFindingWallGrid.length; i++)
    {
      for (int j=0; j<PathFindingWallGrid[0].length; j++)
      {
        pathGrid[i][j] = new pathGridTile(i, j, xEnd, yEnd);
        //println(xEnd + "\t" + yEnd);
      }
    }

    pq = new PriorityQueue<pathGridTile>();
    pq.offer(pathGrid[xStart][yStart]);
    pathGrid[xStart][yStart].updateWith(0, 0);
    pathGrid[xStart][yStart].vis = 2;

    startsss = 1;
  }

  void addToPQ(pathGridTile curTile)
  {
    if (curTile.vis==0)
    {
      curTile.vis = 1;
      pq.offer(curTile);
    }
  }

  void findd()
  {
    while (!pq.isEmpty ()&&startsss==1)
    {
      pathGridTile curTile = (pathGridTile)pq.poll();
      curTile.vis = 2;
      
      //println(pq.size() + "\t" + curTile.x + "\t" + curTile.y);

      if (curTile.x==xEnd&&curTile.y==yEnd)
      {
        startsss = 0;
      }

      if (curTile.y+1<48&&pathGrid[curTile.x][curTile.y+1].vis!=2&&PathFindingWallGrid[curTile.x][curTile.y+1]==0) {
        pathGrid[curTile.x][curTile.y+1].updateWith(curTile.G+10, 1);
        addToPQ(pathGrid[curTile.x][curTile.y+1]);
      }
      if (curTile.y-1>=0&&pathGrid[curTile.x][curTile.y-1].vis!=2&&PathFindingWallGrid[curTile.x][curTile.y-1]==0) {
        pathGrid[curTile.x][curTile.y-1].updateWith(curTile.G+10, 2);
        addToPQ(pathGrid[curTile.x][curTile.y-1]);
      }
      if (curTile.x+1<48&&pathGrid[curTile.x+1][curTile.y].vis!=2&&PathFindingWallGrid[curTile.x+1][curTile.y]==0) {
        pathGrid[curTile.x+1][curTile.y].updateWith(curTile.G+10, 3);
        addToPQ(pathGrid[curTile.x+1][curTile.y]);
      }
      if (curTile.x-1>=0&&pathGrid[curTile.x-1][curTile.y].vis!=2&&PathFindingWallGrid[curTile.x-1][curTile.y]==0) {
        pathGrid[curTile.x-1][curTile.y].updateWith(curTile.G+10, 4);
        addToPQ(pathGrid[curTile.x-1][curTile.y]);
      }

      if (curTile.x+1<48&&curTile.y+1<48&&pathGrid[curTile.x+1][curTile.y+1].vis!=2&&PathFindingWallGrid[curTile.x+1][curTile.y+1]==0
                                                                   &&PathFindingWallGrid[curTile.x+1][curTile.y]==0&&PathFindingWallGrid[curTile.x][curTile.y+1]==0) {
        pathGrid[curTile.x+1][curTile.y+1].updateWith(curTile.G+14, 5);
        addToPQ(pathGrid[curTile.x+1][curTile.y+1]);
      }
      if (curTile.x+1<48&&curTile.y-1>=0&&pathGrid[curTile.x+1][curTile.y-1].vis!=2&&PathFindingWallGrid[curTile.x+1][curTile.y-1]==0
                                                                   &&PathFindingWallGrid[curTile.x+1][curTile.y]==0&&PathFindingWallGrid[curTile.x][curTile.y-1]==0) {
        pathGrid[curTile.x+1][curTile.y-1].updateWith(curTile.G+14, 6);
        addToPQ(pathGrid[curTile.x+1][curTile.y-1]);
      }
      if (curTile.x-1>=0&&curTile.y+1<48&&pathGrid[curTile.x-1][curTile.y+1].vis!=2&&PathFindingWallGrid[curTile.x-1][curTile.y+1]==0
                                                                   &&PathFindingWallGrid[curTile.x-1][curTile.y]==0&&PathFindingWallGrid[curTile.x][curTile.y+1]==0) {
        pathGrid[curTile.x-1][curTile.y+1].updateWith(curTile.G+14, 7);
        addToPQ(pathGrid[curTile.x-1][curTile.y+1]);
      }
      if (curTile.x-1>=0&&curTile.y-1>=0&&pathGrid[curTile.x-1][curTile.y-1].vis!=2&&PathFindingWallGrid[curTile.x-1][curTile.y-1]==0
                                                                   &&PathFindingWallGrid[curTile.x-1][curTile.y]==0&&PathFindingWallGrid[curTile.x][curTile.y-1]==0) {
        pathGrid[curTile.x-1][curTile.y-1].updateWith(curTile.G+14, 8);
        addToPQ(pathGrid[curTile.x-1][curTile.y-1]);
      }
    }
  }

  void update()
  { 
    strokeWeight(5);
    stroke(450, 500, 500);
    pathGridTile curPathDisplayTile = pathGrid[xEnd][yEnd];
    while (curPathDisplayTile.x!=xStart||curPathDisplayTile.y!=yStart)
    {
      int i = curPathDisplayTile.x;
      int j = curPathDisplayTile.y;
      int x1 = i*50+25;
      int y1 = j*50+25;

      //println(i + "\t" + j);

      if (pathGrid[i][j].parent==1) {      
        line(x1, y1, x1, y1-50); 
        curPathDisplayTile = pathGrid[i][j-1];
      } else if (pathGrid[i][j].parent==2) { 
        line(x1, y1, x1, y1+50); 
        curPathDisplayTile = pathGrid[i][j+1];
      } else if (pathGrid[i][j].parent==3) { 
        line(x1, y1, x1-50, y1); 
        curPathDisplayTile = pathGrid[i-1][j];
      } else if (pathGrid[i][j].parent==4) { 
        line(x1, y1, x1+50, y1); 
        curPathDisplayTile = pathGrid[i+1][j];
      } else if (pathGrid[i][j].parent==5) { 
        line(x1, y1, x1-50, y1-50); 
        curPathDisplayTile = pathGrid[i-1][j-1];
      } else if (pathGrid[i][j].parent==6) { 
        line(x1, y1, x1-50, y1+50); 
        curPathDisplayTile = pathGrid[i-1][j+1];
      } else if (pathGrid[i][j].parent==7) { 
        line(x1, y1, x1+50, y1-50); 
        curPathDisplayTile = pathGrid[i+1][j-1];
      } else if (pathGrid[i][j].parent==8) { 
        line(x1, y1, x1+50, y1+50); 
        curPathDisplayTile = pathGrid[i+1][j+1];
      } else
      {
        break;
      }
    }

    stroke(100);
    strokeWeight(1);

    reset();

    startsss = 1;

    findd();
  }
}

class pathGridTile implements Comparable<pathGridTile>
{
  int G, H, F;
  int x, y;

  int vis;

  int parent;

  pathGridTile(int x1, int y1, int xe, int ye)
  {
    G = 10000;
    H = intDist(x1, y1, xe, ye);
    F = G + H;
    x = x1;
    y = y1;
    vis = 0;
    parent = 0;
  }

  public int compareTo(pathGridTile other) {
    if (F!=other.F)
    {
      return F - other.F;
    } else
    {
      if (H!=other.H)
        return H - other.H;
      else
        return G - other.G;
    }
  }

  void updateWith(int g1, int p1)
  {
    if (g1<G&&vis!=2)
    {
      G = g1;
      F = G + H;
      parent = p1;
    }
  }
}

