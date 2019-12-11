PShape player;
void setup(){
  size(640, 640, P3D);
  colorMode(RGB, 255);
  noLoop();
  //player = createShape(ELLIPSE, 0, -100, 100, 100);
  player = loadShape("sphere.OBJ");
  player.setTexture(loadImage("ball.png"));
}

void draw(){
  background(0);
  translate(width/2, height/2);
  fill(255);
  strokeWeight(5);
  stroke(255);
  //point(0, 0);
  shape(player, 0, 0, 100, 100);
}
