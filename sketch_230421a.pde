
class Tile
{
  Tile(){
   // println("tile constructor called");
    this.pos.x = 0;
    this.pos.y = 0;
    this.col = color(0,0,0);
  }
  PVector pos = new PVector(0,0);
  color col = color(0,0,0);
};

class Game
{
  Tile[] tiles;
  Game(int itiles){
    println("Game constructor called");
    tiles = new Tile[itiles];
    for(int i = 0; i < tiles.length; i++){
      tiles[i] = new Tile();
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
        }else{
           x += tile_size;
        }
        
        tiles[i].pos.y = y;
        tiles[i].pos.x = x;
      }
      
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

void setup()
{
  
  size(600, 600);
  game.init_tiles();
  background(255);
  
}

void draw()
{
    game.draw_tiles();
    snake.update();
    //text(str(12), 100, 100);
}
