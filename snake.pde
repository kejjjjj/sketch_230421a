public class Snake_body
{
    Snake_body(Snake_body prev)
    {
      previous = prev;
      velocity.x = 0;
      velocity.y = 0;
    }
    
    Snake_body previous;
    PVector pos;
    color col;
    PVector velocity;
    
    void update_pos(){
      
     // pos += velocity;
      
      
    
    }
    
};
class Snake
{
  
  Snake_body[] body = new Snake_body[2];
  
  void increase_length()
  {
       body = (Snake_body[])append(body, body[body.length-1]);
  };
  
};
