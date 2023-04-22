import java.util.function.Function;
import java.util.HashMap;

HashMap<Character, Integer> dirs = new HashMap<Character, Integer>(){{
    put('w', 0);  
    put('a', -90);
    put('s', -180);
    put('d', 90);
}};

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
       {
          //println("nullptr: " + char(key));
          return;
       }
       veldir = dirs.get(char(key));
       //println("veldir: " + str(veldir));
            
    }
    void update_position()
    {
      pos.x += (int)sin(radians(veldir)) * 2;
      pos.y -= (int)cos(radians(veldir)) * 2;
    }
    void draw_body()
    {
      fill(0);
       rect(pos.x, pos.y, tile_size, tile_size);
    }
    void update()
    {
        update_velocity();
        update_position();
        draw_body();
    }
    
};
class Snake
{
  Snake_body[] body;
  Snake(){
    body = new Snake_body[1];
    for(int i = 0; i < body.length; i++){
      body[i] = new Snake_body(i);
    }
  }
 
  void increase_length()
  {
       int len = body.length-1;
       body = (Snake_body[])append(body, body[len]);
       body[len+1].veldir = body[len].veldir;
       body[len+1].next = body[len];
       
  };
  
  void update()
  {
      for(int i =0; i < body.length; i++)
      {
          body[i].update();
      }
  }
  
};
