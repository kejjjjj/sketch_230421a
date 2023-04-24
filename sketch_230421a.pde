
class Tile
{
  Tile(int aindex){
   // println("tile constructor called");
    this.pos.x = 0;
    this.pos.y = 0;
    this.col = color(0,0,0);
    snake_tile = false;
    index = aindex;
  }
  
  Tile getNeighbor(int direction)
  {
      
      switch(direction)
      {
        case NORTH:
          if(index - game.columns < 0)
              return null;
            
          return game.tiles[index - game.columns];
            
        case EAST:
          int remainder = index % game.columns;
          //if the remainder is 0, then this cell is at the right edge
          if (remainder == game.columns - 1) {
            return null;
          }
          return game.tiles[index + 1];
          
        case SOUTH:
          if(index + game.columns >= game.tiles.length)
            return null;
            
          return game.tiles[index + game.columns];
          
        case WEST:
        
          if(index < 0 || index % game.columns == 0)
            return null;
            
          return game.tiles[index-1];

        default:
          return null;
      }
      
  }
  PVector pos = new PVector(0,0);
  color col = color(0,0,0);
  boolean snake_tile;
  int index;
};

class Game
{
  Tile[] tiles;
  int columns, rows;
  PVector dimensions;
  Game(int itiles){
    println("Game constructor called");
    tiles = new Tile[itiles];
    for(int i = 0; i < tiles.length; i++){
      tiles[i] = new Tile(i);
    }
  }
 
  void init_tiles()
  {
    int separator = int(sqrt(tiles.length));
     if(separator%2==0){
       separator+=1;
     }
    int y = 0, x = 0;
    for(int i =0 ; i < tiles.length; i++){
      
      if((i%2) == 0){
        tiles[i].col = color(144, 238, 144);
      }else{
        tiles[i].col = color(50, 205, 50);
      }
      
      if(i > 0){
        if(i % separator == 0){
           y += tile_size;
           x = 0;
           columns = 0;
           ++rows;
        }else{
           x += tile_size;
           ++columns;
        }
        
        tiles[i].pos.y = y;
        tiles[i].pos.x = x;
      }
      dimensions = new PVector(columns * tile_size, rows * tile_size);
    }
  }
  void draw_tiles()
  {
    for(int i =0 ; i < tiles.length; i++){ //<>// //<>//
      fill(tiles[i].col);
      rect(tiles[i].pos.x, tiles[i].pos.y, tile_size, tile_size); 
    }
  }
}

PVector window_size = new PVector(640, 640);
int tile_size = 40;
Game game = new Game(225); //15x15
Snake snake = new Snake();
int lastTime = 0;
float elapsedtime = 0;

void setup()
{
  frameRate(60);
  size(600, 600);
  game.init_tiles();
  background(255);
  
}

void draw()
{
    try{
      elapsedtime = float(millis() - lastTime) / 100;
      game.draw_tiles();
      snake.update();
      lastTime = millis();     
      text(str(elapsedtime), 100, 100);
    }
    catch(Exception err)
    {
      println("exception caught: " + err);
    }
}
