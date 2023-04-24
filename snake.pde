import java.util.function.Function;
import java.util.HashMap;

HashMap<Character, Integer> dirs = new HashMap<Character, Integer>(){{
    put('w', 0);  
    put('a', -90);
    put('s', -180);
    put('d', 90);
}};
final int NORTH = 0;
final int EAST = 90;
final int SOUTH = -180;
final int WEST = -90;

public class Snake_body
{
    Snake_body(int _index)
    {
      index = _index;
      pos = new PVector(0,0);
      veldir = 90;
    }
    
    Snake_body next;
    PVector pos;
    color col;
    int veldir;
    int index;
    Tile tile;
   // float queued_veldir[1];
    
    boolean is_front()
    { 
      return index == 0; 
    }
    
    void update_velocity()
    {

       if(is_front() == false){
         veldir = next.veldir; 
         return;
       }
         
        if(keyPressed == false)
            return;
        

       if(dirs.get(char(key)) == null)
          return;

       veldir = dirs.get(char(key));
       
       
      Snake_body head = snake.get_head();
      if(head == null){
          
          return;
      }
      
       
      
       Tile neighbor = head.tile.getNeighbor(veldir);
       if(neighbor == null)
       {
         snake.dead = true;
         return;
       }
       head.tile = neighbor;
       pos.x = head.tile.pos.x;
       pos.y = head.tile.pos.y;
    }
    void update_position()
    {
      Snake_body head = snake.get_head();
      if(head == null)
          return;
      
      
  
      //pos.x += ((int)sin(radians(veldir)) * 10) * elapsedtime;
      //pos.y -= ((int)cos(radians(veldir)) * 10) * elapsedtime;
    }
    void draw_body()
    {
       fill(0);
       rect(pos.x, pos.y, tile_size, tile_size);
    }

    void update()
    {
        if(snake.dead == false){
          update_velocity();
          update_position();
        }
        draw_body();
    }
    
};
class Snake
{
  Snake_body[] body;
  boolean dead = false;
  Snake(){
    body = new Snake_body[1];
    for(int i = 0; i < body.length; i++){
      body[i] = new Snake_body(i);
      body[i].tile = game.tiles[i];
    }
    dead = false;
  }
 
  void increase_length()
  {
       int len = body.length-1;
       body = (Snake_body[])append(body, body[len]);
       body[len+1].veldir = body[len].veldir;
       body[len+1].next = body[len];
       
  };
  Snake_body get_head()
  {
      for(int i = 0; i < body.length; i++)
      {
        if(body[i].is_front() == true)
            return body[i];
      }
      return null;
  }
  
  void update()
  {
      for(int i =0; i < body.length; i++)
      {
          body[i].update();
      }
  }
  
};
