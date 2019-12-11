Mainscreen ms;
Game level;
Diedscreen ds;
controlButtons cb;
boolean mainscreen = false;
boolean inGame = false;
boolean POV = true;
boolean dsTrue = false;
int count = 0;
int totalPoints = 0;
int mouseXPos;
int mouseYPos;

//Setup Program
void setup() {
  //width, height
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight, P3D);
  colorMode(RGB, 255);
  noStroke();
  lights();
  rectMode(CENTER);
  ellipseMode(RADIUS);  //Draw from the center of the ellipse
  ms = new Mainscreen();//loadImage("XBg.png"));
  ds = new Diedscreen();
  cb = new controlButtons();
  mainscreen = true;
}

//In game perspective (1st person: 0, -320, 554.2563)


//Draw Image
void draw() {
  background(0, 0, 0); //Draw Background
  translate(width/2, height/2);
  if (mainscreen) {
    ms.drawMainscreen();
  } else if (inGame){
    level.iterate();
    dsTrue = level.drawGame();
    cb.drawButtons();
    if (dsTrue) ds.drawMainscreen();
  }
}

//Actions for when Mouse is Pressed
void mousePressed() {
  mouseXPos = mouseX;
  mouseYPos = mouseY;
  //mouseXPos = mouseX - (width/2);
  //mouseYPos = mouseY - (height/2);
  println(mouseXPos, " ", mouseYPos);
}

void mouseDragged() {
}

//Reset all our booleans to false
void mouseReleased() {
  //if (ms.mouseInObject(1) || ds.mouseInObject(1)){
  //  exit();
  if (!inGame && (ms.mouseInObject(0))){
    inGame = true;
    mainscreen = false;
    level = new Game(loadImage("SkyBg.jpg"));
  } else if (dsTrue && ds.mouseInObject(0)){
    inGame = true;
    mainscreen = false;
    level = new Game(loadImage("SkyBg.jpg"));
  }
  
  if (cb.inShape[0]) level.movePlayer(1);
  else if (cb.inShape[1]) level.movePlayer(0);
  else if (cb.inShape[2] || cb.inShape[3]) level.movePlayer(6);
  
  //int xMax = max(mouseXPos, mouseX);
  //int xMin = min(mouseXPos, mouseX);
  //int yMax = max(mouseYPos, mouseY);
  //int yMin = min(mouseYPos, mouseY);
  
  //if (xMax - xMin > yMax - yMin){
  //  if (mouseXPos > mouseX){
  //    level.movePlayer(0);
  //  } else {
  //    level.movePlayer(1);
  //  }
  //} else {
  //  //if (mouseY < mouseXPos){
  //  //  level.movePlayer(4);
  //  //} else {
  //  //  level.movePlayer(5);
  //  //}
  //}
}

void keyPressed(){
}


/************************
 *** MAINSCREEN CLASS ***
 ************************/
class Mainscreen{
  private PImage bg;
  private PFont mont;
  private boolean[] inShape = new boolean[2];
  private int[] playInfo = new int[4];
  private int[] exitInfo = new int[4];
  
  Mainscreen(){
    //bg = background;
    //bg.resize(displayWidth, displayHeight);
    
    //Setup Font
    //mont = createFont("/Fonts/Montserrat/Montserrat-Bold.ttf", 40);
    //textFont(mont);
    
    //Setup Play and Exit button locations and translations
    playInfo[0] = 0; //Y translation
    playInfo[1] = 300; //X location
    playInfo[2] = 80; //Y location
    playInfo[3] = 5; //Radius of rectangle
    
    exitInfo[0] = 30; //Y translation
    exitInfo[1] = 150; //X location
    exitInfo[2] = 40; //Y location
    exitInfo[3] = 5; //Radius of rectangle
    
    //In Play Button and Exit Button
    inShape[0] = false;
    inShape[1] = false;
  }
  
  //Draw Title on Mainscreen
  void title(){
    pushMatrix();
    translate(0, -3*height/8);
    textSize(64);
    textAlign(CENTER, CENTER);
    fill(255);
    text("The Game", 0, 0, 0); 
    popMatrix();
  }
  
  //Draw play button on the mainscreen
  void playButton(){
    pushMatrix();
    if (!inShape[0]){ //If mouse is not in the shape
      //Draw background box
      translate(0, playInfo[0]);
      fill(50);
      strokeWeight(3);
      stroke(255);
      rect(0, 0, playInfo[1], playInfo[2], playInfo[3]);
    } else { //If the mouse is in the shape
      //Draw background box
      translate(0, playInfo[0]);
      fill(80);
      strokeWeight(5);
      stroke(255);
      rect(0, 0, playInfo[1], playInfo[2], playInfo[3]);
    }
    
      //Draw text
      textAlign(CENTER, CENTER);
      fill(255);
      textSize(64);
      text("Play", 0, -6); 
    popMatrix();
  }
  
  void exitButton(){
    pushMatrix();
    if (!inShape[1]){ //If mouse is not in shape
      //Draw background box
      translate(0, exitInfo[0]);
      fill(50);
      strokeWeight(3);
      stroke(255);
      rect(0, 0, exitInfo[1], exitInfo[2], exitInfo[3]);
    } else { //If mouse is in shape
      //Draw background box
      translate(0, exitInfo[0]);
      fill(80);
      strokeWeight(3);
      stroke(255);
      rect(0, 0, exitInfo[1], exitInfo[2], exitInfo[3]);
    }
    
    //Draw text
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(32);
    text("Quit", 0, -5); 
    popMatrix();
  }
  
  //Check to see if mouse is in a shape
  void mouseCheck(){
    int mouseXPos = mouseX - (width/2);
    int mouseYPos = mouseY - (height/2);
    
    //check Play button:
    if ((mouseXPos < playInfo[1]/2) && (mouseXPos > -playInfo[1]/2) && (mouseYPos < playInfo[2]/2 + playInfo[0]) && (mouseYPos > -playInfo[2]/2 + playInfo[0])){
      inShape[0] = true;
      inShape[1] = false;
    } else if ((mouseXPos < exitInfo[1]/2) && (mouseXPos > -exitInfo[1]/2) && (mouseYPos < exitInfo[2]/2 + exitInfo[0]) && (mouseYPos > -exitInfo[2]/2 + exitInfo[0])){
      inShape[0] = false;
      inShape[1] = true;
    } else {
      inShape[0] = false;
      inShape[1] = false;
    }
  }
  
  //Draw pointer on screen
  void showPointer(){
    int mouseXPos = mouseX - (width/2);
    int mouseYPos = mouseY - (height/2);
    strokeWeight(5);
    stroke(255);
    point(mouseXPos, mouseYPos);
  }
  
  //Returns if mouse is in shape
  boolean mouseInObject(int obj){
    return inShape[obj];
  }
  
  void drawMainscreen(){
    background(0);
    title();
    playButton();
    //exitButton();
    //showPointer();
    mouseCheck();
  }
}

/************************
 ****** GAME CLASS ******
 ************************/
class Game{
  Floor gameFloor;
  Player player;
  ParticleSystem particles;
  private PImage bg;
  private PFont mont;
  boolean exploded = false;
  boolean jump = false;
  boolean fallDown = false;
  int zCounter = -10;
  int airCounter = 0;
  int playerTranslationX = 0, playerTranslationZ = 1400, playerTranslationXto = 0, playerTranslationZto = 1400, playerTranslationY = 0, playerTranslationYto = 0;
  
  Game(PImage background){
    bg = background;
    //mont = createFont("/Fonts/Montserrat/Montserrat-Bold.ttf", 40);
    //textFont(mont);
    gameFloor = new Floor(75, 75, 75);
    player = new Player();
    particles = new ParticleSystem(new PVector(0, 0, 0));
    totalPoints = 0;
  }
  
  void iterate(){
    if (!exploded){
      zCounter = zCounter + 10 + ((totalPoints / 25) * 5);
      if (zCounter > 200){
        gameFloor.popFirstRow();
        gameFloor.pushLastRow();
        zCounter = 0;
      }
    }
  }
  
  void jumpPlayer(){
    if (jump){
      if (fallDown && playerTranslationY == 0){
        fallDown = false;
        jump = false;
      } else if (!fallDown && playerTranslationY <= -200){
        if (airCounter < 80) airCounter++;
        else {
          fallDown = true;
          airCounter = 0;
        }
      } else if (!fallDown && playerTranslationY > -200){
        playerTranslationY -= 20;
      } else if (fallDown && playerTranslationY < 0){
        playerTranslationY += 20;
      } 
    }
  }
  
  boolean drawGame(){
    background(0,0,0);
    processMovement();
    jumpPlayer();
    
    if (POV){
      camera(playerTranslationX, playerTranslationY - 100, playerTranslationZ + 55, playerTranslationX, playerTranslationY - 100, -10000 - playerTranslationZ, 0, 1, 0);
    } else {
      camera(1500, -2000, 2500, 0, -320, 0, 0, 1, 0);
    }
    
    pushMatrix();
    translate(0, 0, zCounter);
    gameFloor.drawFloor();
    popMatrix();
    
    if (!gameFloor.getCollision(playerTranslationX, playerTranslationY, playerTranslationZ) && !exploded){
      pushMatrix();
      translate(playerTranslationX, playerTranslationY, playerTranslationZ);
      if (!POV && playerTranslationX > playerTranslationXto) player.drawPlayer(-PI/4);
      else if (!POV && playerTranslationX < playerTranslationXto) player.drawPlayer(PI/4);
      else if (!POV) player.drawPlayer(0);
      popMatrix();
      particles.origin = new PVector(playerTranslationX, -100 + playerTranslationY, playerTranslationZ);
      drawPoints();
    } else {
      if (!exploded){
        for (int i = 0; i < 100; i++) particles.addParticle(random(0, 255), random(0, 255), random(0, 255));
        exploded = true;
      } else {
        particles.run();
        return true;
      }      
    }  
    return false;
  }
  
  void processMovement(){
    if (playerTranslationX > playerTranslationXto){
      playerTranslationX -= 10;
    } else if (playerTranslationX < playerTranslationXto){
      playerTranslationX += 10;
    }
    
    if (playerTranslationZ > playerTranslationZto){
      playerTranslationZ -= 10;
    } else if (playerTranslationZ < playerTranslationZto){
      playerTranslationZ += 10;
    }
    //if (playerTranslationY > playerTranslationYto){
    //  playerTranslationY -= 10;
    //} else if (playerTranslationY < playerTranslationYto){
    //  playerTranslationY += 10;
    //}
  }
  
  void movePlayer(int direction){
    if (direction == 0){
      //Move player left
      if (playerTranslationXto > -1400){
        playerTranslationXto -= 200;
      }
    } else if (direction == 1){
      //Move player right
      if (playerTranslationXto < 1400){
        playerTranslationXto += 200;
      }
    } else if (direction == 2){
      //Move player forward
      if (playerTranslationZto > -1400){
        playerTranslationZto -= 200;
      }
    } else if (direction == 3){
      //Move player backwards
      if (playerTranslationZto < 1400){
        playerTranslationZto += 200;
      }
    } else if (direction == 4){
      //Move player forward
      if (playerTranslationYto > -200){
        playerTranslationYto -= 200;
      }
    } else if (direction == 5){
      //Move player backwards
      if (playerTranslationYto < 0){
        playerTranslationYto += 200;
      }
    } else if (direction == 6){
      jump = true;
    }
  }
  
  void togglePOV(){
    POV = !POV;
  }
  
  void drawPoints(){
    pushMatrix();
    beginCamera();
    camera();
    endCamera();
    fill(255);
    textAlign(LEFT, TOP);
    textSize(32);
    String points = "" + totalPoints;
    if (totalPoints == 1) points += " Point";
    else points += " Points";
    text(points, 7, 7);
    popMatrix();
  }
}

/*************************
 ****** FLOOR CLASS ******
 *************************/
class Floor{
  ArrayList<Tile> tileList;
  ArrayList<Obstacle> obstacleList;
  ArrayList<Coin> coinList, badList;
  int tilesX = 15;
  int tilesZ = 15;
  int w = 3000;
  int h = 10;
  int d = 3000;
  int[] colour = new int[3];
  int[] tileRange = new int[3];
  
  Floor(int r, int g, int b){
    colour[0] = r;
    colour[1] = g;
    colour[2] = b;
    
    tileList = new ArrayList<Tile>();
    obstacleList = new ArrayList<Obstacle>();
    coinList = new ArrayList<Coin>();
    badList = new ArrayList<Coin>();
    for (int i = 0; i < tilesX*tilesZ; i++){
      //Create Floor Tile
      tileList.add(new Tile(200, 10, 200, r, g, b));
      
      obstacleList.add(new Obstacle());
      coinList.add(new Coin(0));
      badList.add(new Coin(1));
    }
    tileRange = tileList.get(0).getRange();
  }
  
  void drawFloor(){
    int count = 0;
    for (int i = 0; i < tilesX; i++){
      for (int j = 0; j < tilesZ; j++){
        pushMatrix();
        translate(200*j + 100 - w/2, 0, -200*i - 100 + d/2);
        obstacleList.get(count).drawTile();
        coinList.get(count).drawTile();
        badList.get(count).drawTile();
        tileList.get(count++).drawTile();
        popMatrix();
      }
    }
  }
  
  void popFirstRow(){
    for (int i = 0; i < tilesX; i++){
      tileList.remove(0);
      obstacleList.remove(0);
      coinList.remove(0);
      badList.remove(0);
    }
  }
  
  void pushLastRow(){
    for (int i = 0; i < tilesX; i++){
      float chance = random(100);
      if (chance > 74){
        tileList.add(new Tile(200, 10, 200, colour[0], colour[1], colour[2]));
      } else if (chance > 49) {
        tileList.add(new Tile(200, 10, 200, 0, 0, 150));
      } else if (chance > 24) {
        tileList.add(new Tile(200, 10, 200, 0, 150, 0));
      } else {
        tileList.add(new Tile(200, 10, 200, 150, 0, 150));
      }
      
      chance = random(100);
      boolean addedObst = false;
      if (chance < 3) {
        obstacleList.add(new Obstacle(200, 200, 200, 250, 250, 0));
        addedObst = true;
      } else if (chance < 5){
        obstacleList.add(new Obstacle(200, 400, 200, 250, 250, 0));
        addedObst = true;
      } else {
        obstacleList.add(new Obstacle());
      }
      
      if (!addedObst){
        chance = random(100);
        if (chance < 4) {
          coinList.add(new Coin(20, 100, 20, 250, 0, 0, 0));
          badList.add(new Coin(1));
        } else if (chance < 6){
          badList.add(new Coin(20, 100, 20, 0, 0, 255, 1));
          coinList.add(new Coin(0));
        } else {
          coinList.add(new Coin(0));
          badList.add(new Coin(1));
        }
      } else {
        coinList.add(new Coin(0));
        badList.add(new Coin(1));
      }
    }
  }
  
  boolean getCollision(int x, int y, int z){
    int count = 0;
    for (int i = 0; i < tilesX; i++){
      for (int j = 0; j < tilesZ; j++){
        int valX = (200*j + 100 - w/2) - x;
        int valZ = (-200*i - 100 + d/2) - z;
        int tileType = obstacleList.get(count).type();
        
        if (obstacleList.get(count).isValid() && valX < tileRange[0] && valX > -tileRange[0] && valZ < tileRange[2] && valZ > -tileRange[2] && y < tileType && y > -tileType){
          //println("COLLIDED WITH: ", count, " (", x, ", ", y, ", ", z, ")", " ValX: ", valX, " ValZ: ", valZ, " TranX: ", 200*j + 100 - w/2);
          if (POV){
            obstacleList.set(count, new Obstacle());
          } else {
            obstacleList.get(count).changeColour(255, 0, 0);
          }
          return true;
        }
        
        tileType = coinList.get(count).h;
        if (coinList.get(count).isValid() && valX < tileRange[0] && valX > -tileRange[0] && valZ < tileRange[2] && valZ > -tileRange[2] && y < tileType && y > -tileType){
          //println("COLLIDED WITH: ", count, " (", x, ", ", y, ", ", z, ")", " ValX: ", valX, " ValZ: ", valZ, " TranX: ", 200*j + 100 - w/2);
          coinList.set(count, new Coin(0));
          totalPoints++;
          println("You have: ", totalPoints, " Points!");
        }
        
        tileType = badList.get(count).h;
        if (badList.get(count).isValid() && valX < tileRange[0] && valX > -tileRange[0] && valZ < tileRange[2] && valZ > -tileRange[2] && y < tileType && y > -tileType){
          //println("COLLIDED WITH: ", count, " (", x, ", ", y, ", ", z, ")", " ValX: ", valX, " ValZ: ", valZ, " TranX: ", 200*j + 100 - w/2);
          badList.set(count, new Coin(0));
          totalPoints--;
          println("You have: ", totalPoints, " Points!");
        }
        
        
        count++;
      }
    }
    return false;
  }
}

/************************
 ****** TILE CLASS ******
 ************************/
class Tile{
  int w;
  int h;
  int d;
  int[] colour = new int[3];
  Tile(int w_, int h_, int d_, int r, int g, int b){
    w = w_;
    h = h_;
    d = d_;
    colour[0] = r;
    colour[1] = g;
    colour[2] = b;
  }
  
  void drawTile(){
    stroke(255);
    strokeWeight(0);
    fill(colour[0], colour[1], colour[2]);
    box(w, h, d);
  }
  
  int[] getRange(){
    int[] range = new int[3];
    range[0] = w/2;
    range[1] = h/2;
    range[2] = d/2;
    return range;
  }
  
}

/************************
 ****** OBSTACLE CLASS ******
 ************************/
class Obstacle{
  int w;
  int h;
  int d;
  int[] colour = new int[3];
  
  Obstacle(){
    w = 0;
    h = 0;
    d = 0;
  };
  
  Obstacle(int w_, int h_, int d_, int r, int g, int b){
    w = w_;
    h = h_;
    d = d_;
    colour[0] = r;
    colour[1] = g;
    colour[2] = b;
  }
  
  void drawTile(){
    if (w != 0){
      stroke(255);
      strokeWeight(0);
      fill(colour[0], colour[1], colour[2]);
      box(w, h, d);
    }
  }
  
  boolean isValid(){
    return (w != 0);
  }
  
  void changeColour(int r, int g, int b){
    colour[0] = r;
    colour[1] = g;
    colour[2] = b;
  }
  
  int type(){
    if (h > 200){
      return 400;
    } else if (h > 1) {
      return 200;
    } else {
      return 0;
    }
  }
}


/************************
 ****** COIN CLASS ******
 ************************/
class Coin{
  int w;
  int h;
  int d;
  int[] colour = new int[3];
  float rotationCount = 0.0;
  float yBob = 0.0; 
  boolean yDirection = true; //True is up, false is down
  int coinType;
  
  Coin(int type){
    coinType = type;
    w = 0;
    h = 0;
    d = 0;
  };
  
  Coin(int w_, int h_, int d_, int r, int g, int b, int type){
    w = w_;
    h = h_;
    d = d_;
    colour[0] = r;
    colour[1] = g;
    colour[2] = b;
    coinType = type;
  }
  
  void drawTile(){
    if (w != 0){
      stroke(255);
      strokeWeight(0);
      fill(colour[0], colour[1], colour[2]);
      pushMatrix();
      translate(0, -100, 0);
      rotateY(degrees(rotationCount));
      rotationCount = rotationCount + 0.001;
      if (coinType == 0){
        sphereDetail(2);
        sphere(25);
      } else {
        sphereDetail(4);
        sphere(25);
      }
      popMatrix();
    }
  }
  
  boolean isValid(){
    return (w != 0);
  }
  
  void changeColour(int r, int g, int b){
    colour[0] = r;
    colour[1] = g;
    colour[2] = b;
  }
}

/**************************
 ****** PLAYER CLASS ******
 **************************/
class Player{
  PShape wings;
  Player(){
    wings = createShape();
    wings.beginShape();
    wings.stroke(150);
    wings.strokeWeight(0);
    wings.fill(150);
    wings.vertex(-125, 0, +50);
    wings.vertex(-50, 0, -50);
    wings.vertex(-50, 0, 50);
    wings.vertex(125, 0, 50);
    wings.vertex(50, 0, -50);
    wings.vertex(50, 0, 50);
    wings.endShape(CLOSE);
  }
  
  void drawPlayer(float rotation){
    pushMatrix();
    translate(0, -75, 0);
    rotateZ(rotation);
    sphereDetail(25);
    shape(wings);
    fill(255);
    sphere(75);
    popMatrix();
  }
}

/**********************************
 ****** PARTICLESYSTEM CLASS ******
 **********************************/
class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle(float r, float g, float b) {
    particles.add(new Particle(origin, r, g, b));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.outOfTime()) {
        particles.remove(i);
      }
    }
  }
}

/****************************
 ****** PARTICLE CLASS ******
 ****************************/
class Particle {
  PShape prism;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r, g, b;
  float timer;

  Particle(PVector l, float r_, float g_, float b_) {
    acceleration = new PVector(0, 0.05, 0);
    velocity = new PVector(random(-5, 5), random(-10, 0), random(-5, 5));
    position = l.copy();
    timer = 255.0;
    r = r_;
    g = g_;
    b = b_;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    timer -= 1.0;
  }

  // Method to display
  void display() {
    strokeWeight(0);
    //stroke(255, timer);
    fill(r, g, b, timer);
    
    beginShape();
    vertex(position.x - 25, position.y, position.z);
    vertex(position.x, position.y + 25, position.z);
    vertex(position.x + 25, position.y, position.z);
    endShape();
    
    //triangle(position.x - 25, position.y, position.x, position.y + 25, position.x + 25, position.y);
  }

  // Is the particle still useful?
  boolean outOfTime() {
    if (timer <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}

/************************
 *** DIEDSCREEN CLASS ***
 ************************/
class Diedscreen{
  private PFont mont;
  private boolean[] inShape = new boolean[2];
  private int[] playInfo = new int[4];
  private int[] exitInfo = new int[4];
  
  Diedscreen(){
    //Setup Font
    //mont = createFont("/Fonts/Montserrat/Montserrat-Bold.ttf", 40);
    //textFont(mont);
    
    //Setup Play and Exit button locations and translations
    playInfo[0] = -height/7; //Y translation
    playInfo[1] = 500; //X location
    playInfo[2] = 80; //Y location
    playInfo[3] = 5; //Radius of rectangle
    
    exitInfo[0] = 30; //Y translation
    exitInfo[1] = 150; //X location
    exitInfo[2] = 40; //Y location
    exitInfo[3] = 5; //Radius of rectangle
    
    //In Play Button and Exit Button
    inShape[0] = false;
    inShape[1] = false;
  }
  
  //Draw Title on Mainscreen
  void title(){
    pushMatrix();
    translate(0, -3*height/8);
    //textSize(32);
    textAlign(CENTER, CENTER);
    fill(255);
    text("YOU DIED!", 0, 0, 0); 
    String tmp = "You had: ";
    if (totalPoints == 1){
      tmp += totalPoints + " Point!";
    } else tmp += totalPoints + " Points!";
    fill(255);
    text(tmp, 0, 100, 0); 
    popMatrix();
  }
  
  //Draw play button on the mainscreen
  void playButton(){
    pushMatrix();
    if (!inShape[0]){ //If mouse is not in the shape
      //Draw background box
      translate(0, playInfo[0]);
      fill(50);
      strokeWeight(3);
      stroke(255);
      rect(0, 0, playInfo[1], playInfo[2], playInfo[3]);
    } else { //If the mouse is in the shape
      //Draw background box
      translate(0, playInfo[0]);
      fill(80);
      strokeWeight(3);
      stroke(255);
      rect(0, 0, playInfo[1], playInfo[2], playInfo[3]);
    }
    
      //Draw text
      textAlign(CENTER, CENTER);
      fill(255);
      textSize(64);
      text("Play Again", 0, -6); 
    popMatrix();
  }
  
  void exitButton(){
    pushMatrix();
    if (!inShape[1]){ //If mouse is not in shape
      //Draw background box
      translate(0, exitInfo[0]);
      fill(50);
      strokeWeight(3);
      stroke(255);
      rect(0, 0, exitInfo[1], exitInfo[2], exitInfo[3]);
    } else { //If mouse is in shape
      //Draw background box
      translate(0, exitInfo[0]);
      fill(80);
      strokeWeight(3);
      stroke(255);
      rect(0, 0, exitInfo[1], exitInfo[2], exitInfo[3]);
    }
    
    //Draw text
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(32);
    text("Quit", 0, -5); 
    popMatrix();
  }
  
  void drawSquare(){
    pushMatrix();
    stroke(255);
    strokeWeight(1);
    fill(75, 185);
    rect(0, 0, width - 20, height - 20);
    popMatrix();
  
}
  
  //Check to see if mouse is in a shape
  void mouseCheck(){
    int mouseXPos = mouseX - (width/2);
    int mouseYPos = mouseY - (height/2);
    
    //check Play button:
    if ((mouseXPos < playInfo[1]/2) && (mouseXPos > -playInfo[1]/2) && (mouseYPos < playInfo[2]/2 + playInfo[0]) && (mouseYPos > -playInfo[2]/2 + playInfo[0])){
      inShape[0] = true;
      inShape[1] = false;
    } else if ((mouseXPos < exitInfo[1]/2) && (mouseXPos > -exitInfo[1]/2) && (mouseYPos < exitInfo[2]/2 + exitInfo[0]) && (mouseYPos > -exitInfo[2]/2 + exitInfo[0])){
      inShape[0] = false;
      inShape[1] = true;
    } else {
      inShape[0] = false;
      inShape[1] = false;
    }
  }
  
  //Draw pointer on screen
  void showPointer(){
    int mouseXPos = mouseX - (width/2);
    int mouseYPos = mouseY - (height/2);
    strokeWeight(5);
    stroke(255);
    point(mouseXPos, mouseYPos);
  }
  
  //Returns if mouse is in shape
  boolean mouseInObject(int obj){
    return inShape[obj];
  }
  
  void drawMainscreen(){
    pushMatrix();
    //camera(0, 0, 714, 0, -0, 0, 0, 1, 0);
    beginCamera();
    camera();
    endCamera();
    translate(width/2, height/2);
    drawSquare();
    title();
    playButton();
    //exitButton();
    //showPointer();
    mouseCheck();
    popMatrix();
  }
}

class controlButtons{
  boolean[] inShape = new boolean[4];
  float[] xLoc = new float[4];
  float[] yLoc = new float[4];
  controlButtons(){
    inShape[0] = false;
    inShape[1] = false;
    inShape[2] = false;
    inShape[3] = false;
    
    xLoc[0] = screenX((width/2) + 63, (height/2) + 32, 630);
    xLoc[1] = screenX((width/2) - 63, (height/2) + 32, 630);
    xLoc[2] = screenX((width/2) + 63, (height/2) + 13, 630);
    xLoc[3] = screenX((width/2) - 63, (height/2) + 13, 630);
    
    yLoc[0] = screenY((width/2) + 63, (height/2) + 32, 630);
    yLoc[1] = screenY((width/2) - 63, (height/2) + 32, 630);
    yLoc[2] = screenY((width/2) + 63, (height/2) + 13, 630);
    yLoc[3] = screenY((width/2) - 63, (height/2) + 13, 630);
    
    println(xLoc[0], " ", xLoc[1], " ", xLoc[2], " ", xLoc[3], " ", yLoc[0], " ", yLoc[1], " ", yLoc[2], " ", yLoc[3]);
  }
  
  void drawButtons(){
    mouseCheck();
    drawRight();
    drawLeft();
    drawJump();
  }
  
  void drawLeft(){
    pushMatrix();
    beginCamera();
    camera();
    endCamera();
    translate((width/2) - 63, (height/2) + 32, 630);
    if (!inShape[1]){ //If mouse is not in the shape
      fill(50);
      strokeWeight(2);
      stroke(255);
      circle(0, 0, 8);
    } else { //If the mouse is in the shape
      fill(80);
      strokeWeight(2);
      stroke(255);
      circle(0, 0, 8);
    }
    
      //Draw text
      textAlign(CENTER, CENTER);
      fill(255);
      textSize(14);
      text("<", 0, -1); 
    popMatrix();
  }
  
  void drawJump(){
    pushMatrix();
    beginCamera();
    camera();
    endCamera();
    translate((width/2) - 63, (height/2) + 13, 630);
    if (!inShape[3]){ //If mouse is not in the shape
      fill(50);
      strokeWeight(2);
      stroke(255);
      circle(0, 0, 8);
    } else { //If the mouse is in the shape
      fill(80);
      strokeWeight(2);
      stroke(255);
      circle(0, 0, 8);
    }
    
    //Draw text
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(14);
    text("^", 0, 2); 
    popMatrix();
    
    pushMatrix();
    beginCamera();
    camera();
    endCamera();
    translate((width/2) + 63, (height/2) + 13, 630);
    if (!inShape[2]){ //If mouse is not in the shape
      fill(50);
      strokeWeight(2);
      stroke(255);
      circle(0, 0, 8);
    } else { //If the mouse is in the shape
      fill(80);
      strokeWeight(2);
      stroke(255);
      circle(0, 0, 8);
    }
    
    //Draw text
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(14);
    text("^", 0, 2); 
    popMatrix();
  }
  
  
  
  void drawRight(){
      pushMatrix();
      beginCamera();
      camera();
      endCamera();
      translate((width/2) + 63, (height/2) + 32, 630);
      if (!inShape[0]){ //If mouse is not in the shape
        fill(50);
        strokeWeight(2);
        stroke(255);
        circle(0, 0, 8);
      } else { //If the mouse is in the shape
        fill(80);
        strokeWeight(2);
        stroke(255);
        circle(0, 0, 8);
      }
      
        //Draw text
        textAlign(CENTER, CENTER);
        fill(255);
        textSize(14);
        text(">", 0, -1); 
      popMatrix();
    }
  
  void mouseCheck(){
    int mouseXPos = mouseX;// - (width/2);
    int mouseYPos = mouseY;// - (height/2);
    
    //check Play button:
    if ((mouseXPos < xLoc[0] + 70) && (mouseXPos > xLoc[0] - 70) && (mouseYPos < yLoc[0] + 70) && (mouseYPos > yLoc[0] - 70)){
      inShape[0] = true;
      inShape[1] = false;
      inShape[2] = false;
      inShape[3] = false;
    } else if ((mouseXPos < xLoc[1] + 70) && (mouseXPos > xLoc[1] - 70) && (mouseYPos < yLoc[1] + 70) && (mouseYPos > yLoc[1] - 70)){
      inShape[1] = true;
      inShape[0] = false;
      inShape[2] = false;
      inShape[3] = false;
    } else if ((mouseXPos < xLoc[2] + 70) && (mouseXPos > xLoc[2] - 70) && (mouseYPos < yLoc[2] + 70) && (mouseYPos > yLoc[2] - 70)){
      inShape[2] = true;
      inShape[0] = false;
      inShape[1] = false;
      inShape[3] = false;
    } else if ((mouseXPos < xLoc[3] + 70) && (mouseXPos > xLoc[3] - 70) && (mouseYPos < yLoc[3] + 70) && (mouseYPos > yLoc[3] - 70)){
      inShape[3] = true;
      inShape[0] = false;
      inShape[2] = false;
      inShape[1] = false;
    } else {
      inShape[0] = false;
      inShape[1] = false;
      inShape[2] = false;
      inShape[3] = false;
    }
  }
  
}
