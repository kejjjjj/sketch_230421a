import java.util.function.Function;
import java.util.HashMap;

public class MoveKey
{

  char _key;
  boolean isPressed;
  int veldir;
  boolean ready_to_move;
  MoveKey(char Argkey, int Argveldir)
  {
     _key = Argkey;
     isPressed = false;
     veldir = Argveldir;
     ready_to_move = false;
  }
  void KeyPressEvent(){
    if(!isPressed){
      isPressed = true;
      ready_to_move = true;
      println("key '" + str(_key) + "' pressed");
    }
  }
  void KeyReleaseEvent(){
    if(isPressed){
      isPressed = false;
      println("key '" + str(_key) + "' released");
    }
  }
}

HashMap<Character, MoveKey> dirs = new HashMap<Character, MoveKey>(){{
    put('w', new MoveKey('w', 0));  
    put('a', new MoveKey('a', -90));
    put('s', new MoveKey('s', -180));
    put('d', new MoveKey('d', 90));
}};
final int NORTH = 0;
final int EAST = 90;
final int SOUTH = -180;
final int WEST = -90;
float time_until_update = 1.f;
public class Snake_body
{
    Snake_body(int _index)
    {
      index = _index;
      pos = new PVector(0,0);
      veldir = 90;
      inside_until_nextframe = false;
    }
    
    Snake_body next;
    Snake_body previous;
    PVector pos;
    color col;
    int veldir;
    int index;
    Tile tile;
    boolean inside_until_nextframe;
   // float queued_veldir[1];
    
    boolean is_front()
    { 
      return index == 0; 
    }
    
    void update_direction()
    {

       if(is_front() == false){
         veldir = next.veldir; 
         return;
       }
         
       var dir = dirs.get(char(key));
       if(dir == null)
          return;

       if(dir.ready_to_move == false)
         return;
         
       if(abs(veldir - (dir.veldir)) == 180)
       {
         return;
       }
       veldir = dir.veldir;
       
       dir.ready_to_move = false;
    }
    void update_head()
    {
      
      
      if(next != null){
          return;
      }
      
       Tile neighbor = tile.getNeighbor(veldir);
       if(neighbor == null)
       {
         println("death");
         snake.dead = true;
         return;
       }
       
       if(neighbor.snake_tile == true){
         println("death");
         snake.dead = true;
         return;
       
       }
       
       tile = neighbor;
       pos.x = tile.pos.x;
       pos.y = tile.pos.y;
      
      
    }
    void update_tail()
    {
        
      if(next == null){
          return;
      }
      
       tile = next.tile;
       pos.x = next.tile.pos.x;
       pos.y = next.tile.pos.y;
  
      //pos.x += ((int)sin(radians(veldir)) * 10) * elapsedtime;
      //pos.y -= ((int)cos(radians(veldir)) * 10) * elapsedtime;
    }
    void draw_body()
    {
      stroke(color(255,255,255));
      if(snake.dead == false)
         fill(0);
      else
        fill(color(255,0,0));
       rect(tile.pos.x, tile.pos.y, tile_size, tile_size);
       noStroke();
    }

    void update()
    {
      
      
       
     
        if(snake.dead == false && time_until_update <= 0){
          
          if(inside_until_nextframe == false){
            update_direction();
            update_head();
            update_tail();
            tile.snake_tile = true;
            if(edible.isEaten()){
              edible = new Edible(edible.col);
              snake.increase_length();
              println("LONGER!");
            }
            
          }else
            inside_until_nextframe = false;
         
        }
        draw_body();
        
    }
    
    int inverse_veldir(int _veldir)
    {
      switch(_veldir){
        case -90:
          return 90;
        case 0:
          return 180;
          case 90:
          return -90;
        case 180:
          return 0;
        default:
          return 0;
      }
          
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
       final int len = body.length-1;
       body = (Snake_body[])expand(body, len+2);
       body[len+1] = new Snake_body(len+1);
       body[len].previous = body[len+1];
       
       body[len+1].tile = body[len].tile;
       body[len+1].pos = body[len].pos;
       body[len+1].veldir = body[len].veldir;
       body[len+1].inside_until_nextframe = true;
       body[len+1].index = len+1;
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
    
    
    time_until_update -= 4;
      for(int i =body.length-1; i >= 0; i--)
      {
          body[i].update();
      }
      if(time_until_update <= 0){
         for(int i = 0 ; i< game.tiles.length; i++)
            game.tiles[i].snake_tile = false;
      
       time_until_update = frameRate;
      }
       edible.draw_edible();
  }
  
};
