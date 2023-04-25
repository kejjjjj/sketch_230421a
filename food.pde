class Edible
{
    Tile tile;
    color col;
    Edible(color _col)
    {
       tile = game.tiles[int(random(game.tiles.length-1))];
       
       while(tile.snake_tile == true)
     {
       tile = game.tiles[int(random(game.tiles.length-1))];
     }
     
        col = _col;
    }
    boolean isEaten()
    {
      Snake_body head = snake.get_head();
      if(head == null)
          return false;
          
      return head.tile.index == tile.index;
    }
    void draw_edible()
    {
      fill(col);
      rect(tile.pos.x + 5, tile.pos.y + 5, tile_size-10, tile_size-10, 20);
    }
    void update()
    {
      if(isEaten() == false)
      {
        
      }else
        println("EATEN!");
      
    }
    
}
