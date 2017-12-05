

ArrayList<ChunkTemplate> ChunkTemplates;

ChunkProperties CenterChunk;
ChunkProperties TopChunk;
ChunkProperties BottomChunk;
ChunkProperties LeftChunk;
ChunkProperties RightChunk;

void initChunks()
{
  ChunkTemplates = new ArrayList<ChunkTemplate>();
  
  for(int i=0;i<15;i++)
  {
    ChunkTemplate newTemplate = new ChunkTemplate(i);
    ChunkTemplates.add(newTemplate);
  }
  
  initGridChunks();
}

void ChunkCopy(ChunkProperties srcChunk, ChunkProperties dstChunk)
{
  println("JJJ");
  
  dstChunk.OpenDirections = srcChunk.OpenDirections.clone();
  GridCopy(srcChunk.Grid,dstChunk.Grid);
}

int chunkify(int x1)
{
  return x1/width;
}

void printChunk()
{
  for (int i=0; i<CenterChunk.Grid.length; i++) {
    print("g:"+CenterChunk.Grid[0][i]);
    for (int j=1; j<CenterChunk.Grid[0].length; j++) {
      print(","+CenterChunk.Grid[j][i]);
    }
    println();
  }
}

void initGridChunks()
{
  CenterChunk = MakeNewChunk(ALL_DIRECTION);
  TopChunk = MakeNewChunk(BOTTOM_DIRECTION);
  BottomChunk = MakeNewChunk(TOP_DIRECTION);
  LeftChunk = MakeNewChunk(RIGHT_DIRECTION);
  RightChunk = MakeNewChunk(LEFT_DIRECTION);
}

ChunkProperties MakeNewChunk(int fromDirection)
{
  ArrayList<Integer> plausibleTemplate = new ArrayList<Integer>();

  if (fromDirection==4)
  {
    for (Integer i=0; i<ChunkTemplates.size(); i++)
    {
      if (ChunkTemplates.get(i).OpenDirections[0]&&ChunkTemplates.get(i).OpenDirections[1]&&ChunkTemplates.get(i).OpenDirections[2]&&ChunkTemplates.get(i).OpenDirections[3])
        plausibleTemplate.add(i);
    }
  } 
  else
  {
    for (Integer i=0; i<ChunkTemplates.size(); i++)
    {
      if (ChunkTemplates.get(i).OpenDirections[fromDirection])
        plausibleTemplate.add(i);
    }
  }
  
  println("GGG");
  
  ChunkProperties newChunk = new ChunkProperties(ChunkTemplates.get(plausibleTemplate.get((int)random(plausibleTemplate.size()))));

  return newChunk;
}

class ChunkProperties
{
  boolean [] OpenDirections;
  byte [][] Grid;
  
  int colorSeed;
  
  ChunkProperties(ChunkTemplate template)
  {
    println("HHH");
    
    OpenDirections = new boolean[4];
    
    OpenDirections[0] = template.OpenDirections[0];
    OpenDirections[1] = template.OpenDirections[1];
    OpenDirections[2] = template.OpenDirections[2];
    OpenDirections[3] = template.OpenDirections[3];
    
    Grid = new byte[16][16];
    
    GridCopy(template.GridTemplate,Grid);
    
    randomSeed(millis());
    colorSeed = (int)random(5345982);
  }
}

class ChunkTemplate
{
  byte [][] GridTemplate;
  
  boolean [] OpenDirections;

  ChunkTemplate(int id)
  {
    GridTemplate = new byte[16][16];
    OpenDirections = new boolean[4];

    String[] GridTemplateFile = loadStrings("GridTemplates/Template_" + id + ".txt");
    //println(GridTemplateFile.length);
    for (int i=0; i<GridTemplateFile.length; i++)
    {
      //println(GridTemplateFile[i]);
      String[] line = split(GridTemplateFile[i], ':');
      if(line[0].equals("g"))
      {
        String[] blocks = split(line[1], ',');
        for (int j=0; j<blocks.length; j++)
        {
          GridTemplate[j][i] = (byte)int(blocks[j]);
        }
      }
      else if(line[0].equals("o"))
      {
        String[] Directions = split(line[1], ',');
        for (int j=0; j<Directions.length; j++)
        {
          OpenDirections[j] = boolean(int(Directions[j]));
          //println(GridTemplateFile[i]);
        }
      }
    }
  }
}

