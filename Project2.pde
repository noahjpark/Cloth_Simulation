// Noah Park
// park1623
// Project 2: Ropes/Cloth Simulation driver

import peasy.*;

PImage cloth;            // PImage for the cloth
PeasyCam c;              // Camera object for 3D

PVector[][] p;           // PVector array for the positions of the ropes
PVector[][] v;           // PVector array for the velocities of the ropes
PVector[][] vn;          // PVector array for the new velocities of the ropes

PVector ballPos;         // PVector for the ball's position

int numSegments = 30;    // Number of segments
int cols = 30;           // Integer representing the number of columns
int rows = 30;           // Integer representing the number of rows

float ballRadius = 50;   // Float representing the ball's radius
float restLength = 10;   // Float representing the resting length of the springs in the cloth
float ks = 500;          // Float for the spring constant
float kd = 250;          // Float for the damping factor

void setup(){
  size(1000, 1000, P3D);
  c = new PeasyCam(this, 150);
  c.setMinimumDistance(150);
  c.setMaximumDistance(750);  
  
  p = new PVector[rows][cols];
  v = new PVector[rows][cols];
  
  ballPos = new PVector(220, -180, 180);
  
  cloth = loadImage("korea.png");
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      p[i][j] = new PVector(j*20, 0, i*20);
      v[i][j] = new PVector(0, 0, 0);
    }
  }
}

void update(float dt){
  vn = v; // Start with old velocities
  
  // horizontal
  for(int i = 0; i < rows - 1; i++){
    for(int j = 0; j < cols; j++){
      PVector e = PVector.sub(p[i + 1][j], p[i][j]);
      float l = (float) Math.sqrt(e.dot(e));
      e.mult(1/l);
      float v1 = e.dot(v[i][j]);
      float v2 = e.dot(v[i + 1][j]);
      float f = (-ks*(restLength - l)) - (kd*(v1 - v2));
      e.mult(f);
      e.mult(dt);
      vn[i][j].add(e);
      vn[i + 1][j].sub(e);
    }
  }
  
  // Vertical
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols - 1; j++){
      PVector e = PVector.sub(p[i][j + 1], p[i][j]);
      float l = (float) Math.sqrt(e.dot(e));
      e.mult(1/l);
      float v1 = e.dot(v[i][j]);
      float v2 = e.dot(v[i][j + 1]);
      float f = (-ks*(restLength - l)) - (kd*(v1 - v2));
      e.mult(f);
      e.mult(dt);
      vn[i][j].add(e);
      vn[i][j + 1].sub(e);
    }
  }
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      vn[i][j].add(new PVector(0, -0.1, 0));
      if(i == 0) vn[i][j] = new PVector(0, 0, 0);
    }
  }
  
  v = vn;
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      // Collision Detection
      // Computing the unit length vector between the two positions
      float d = (float) Math.sqrt(Math.pow(p[i][j].x - ballPos.x, 2) + Math.pow(p[i][j].y - ballPos.y, 2) + Math.pow(p[i][j].z - ballPos.z, 2));
      
      if (d < ballRadius + 0.09) {
        PVector n = PVector.sub(ballPos, p[i][j]).mult(-1);
        n.normalize();
        PVector bounce = n.mult(v[i][j].dot(n));
        // limit velocity
        v[i][j].add(bounce.mult(-1.5).limit(1.5));
        p[i][j].add(n.mult(0.1 + ballRadius - d));
      }
      
      p[i][j].x += v[i][j].x * dt;
      p[i][j].y += v[i][j].y * dt;
      p[i][j].z += v[i][j].z * dt;
    }
  }
}

void keyPressed(){
  if(key == 'i') ballPos.y -= 20;
  else if(key == 'k') ballPos.y += 20;
  else if(key == 'j') ballPos.x -= 20;
  else if(key == 'l') ballPos.x += 20;
  else if(key == 'u') ballPos.z -= 20;
  else if(key == 'o') ballPos.z += 20;
}

void draw(){
  background(0, 0, 0);
  fill(0, 0, 0);
  for(int i = 0; i < 100; i++){
    update(1/(150.0*frameRate));
  }
  
  drawCloth();

  drawSphere();
}

void drawCloth(){
  // Draw the cloth with the American flag texture
  noStroke();
  for (int i = 0; i < rows - 1; i++) {
    for (int j = 0; j < cols - 1; j++) {
      float p1 = cloth.width / rows * i;
      float p2 = cloth.height / rows * (j + 1); 
      float p3 = cloth.width / rows * (i + 1); 
      float p4 = cloth.height / rows * j; 
      beginShape();
      texture(cloth);
      vertex(p[i][j].x, p[i][j].y, p[i][j].z, p1, p4);
      vertex(p[i+1][j].x, p[i+1][j].y, p[i+1][j].z, p3, p4);
      vertex(p[i+1][j+1].x, p[i+1][j+1].y, p[i+1][j+1].z, p3, p2);
      vertex(p[i][j+1].x, p[i][j+1].y, p[i][j+1].z, p1, p2);
      endShape();
    }
   }
}

void drawSphere(){
  // Draw the green sphere for user interaction
  pushMatrix();
  translate(ballPos.x, ballPos.y, ballPos.z);
  noStroke();
  fill(40, 128, 40);
  sphere(ballRadius);
  popMatrix();
}
