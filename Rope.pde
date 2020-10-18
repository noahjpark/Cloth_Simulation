// Noah Park
// park1623
// Rope class

class Rope {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector force;
  
  public Rope(float x, float y, float z){
    this.position = new PVector(x, y, z);
    this.velocity = new PVector(0, 0, 0);
    this.acceleration = new PVector(0, 0, 0);
    this.force = new PVector(0, 0, 0);
  }
  
  //public float force(){
  //  float xDifference = xEnd - xStart;
  //  float yDifference = yEnd - yStart;
  //  float distance = (float) Math.sqrt(Math.pow(xDifference, 2) + Math.pow(yDifference, 2));
    
  //  float forceLength = distance - len;
    
  //  return k*forceLength;
  //}
  
  //public float length(){
  //  float xDifference = xEnd - xStart;
  //  float yDifference = yEnd - yStart;
    
  //  return (float) Math.sqrt(Math.pow(xDifference, 2) + Math.pow(yDifference, 2));
  //}
  
}
