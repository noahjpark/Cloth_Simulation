// Noah Park
// park1623
// Ball class

class Ball {
  
  private float radius = 20;
  private float x;
  private float y;
  private float mass;
  private float xVel;
  private float yVel;
  
  public Ball(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public float getRadius(){
    return this.radius;
  }
  
  public float getXPos(){
    return this.x;
  }
  
  public float getYPos(){
    return this.y;
  }
  
  public float getXVel(){
    return this.xVel;
  }
  
  public float getYVel(){
    return this.yVel;
  }
  
  public float getMass(){
    return this.mass;
  }
  
}
