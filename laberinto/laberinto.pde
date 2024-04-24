import processing.sound.*;

final NavigationMethod method = new MouseMethod(); //CartesianMethod, PolarMethod, MouseMethod
final int N_TARGETS = 10;

final ArrayList<Target> targets = new ArrayList<Target>();
long startTime;
PImage colorMap;
PImage maskMap;
final color OBSTACLE_COLOR = color(255, 0, 0);
boolean obstacleAt(float x, float y) {
  final int ix = (int) constrain(x, 0, maskMap.width - 1);
  final int iy = (int) constrain(y, 0, maskMap.height - 1);
  return maskMap.pixels[ix + iy*maskMap.width] == OBSTACLE_COLOR;
}

SoundFile soundCollect, soundWin;

void settings() {
  colorMap = loadImage("./colorMap.jpg");  
  maskMap = loadImage("./collisionMap.png");
  assert(colorMap.width == maskMap.width && colorMap.height == maskMap.height);
  final int maxWidth = displayWidth - 20;
  if ( colorMap.width > maxWidth) { //TODO all the sizes and speeds should also be rescaled
    colorMap.resize(maxWidth, 0);
    maskMap.resize(maxWidth, 0);
  }
  size( colorMap.width, colorMap.height);
}

void setup() {
  soundCollect = new SoundFile(this, "collect.mp3");
  soundWin = new SoundFile(this, "win.mp3");
  restartTrial( false );
}

void restartTrial(boolean showResult) {
  if (showResult) {
    final long tct = millis() - startTime;
    println("TCT " + tct);
    soundWin.play();
  }
  method.circle.x = width/2;
  method.circle.y = height/2;
  createCircles(N_TARGETS);
  startTime = millis();
}

ArrayList<Target> toRemove = new ArrayList<Target>();
void draw() {
  //graphics
  image(colorMap, 0, 0);
  for (Target t : targets)
    t.draw();
  method.draw();

  //logic
  toRemove.clear();
  for (Target t : targets) {
    t.logic();
    if ( t.collideWith( method.circle ))
      toRemove.add( t );
  }

  final float prevX = method.circle.x;
  final float prevY = method.circle.y;

  method.logic(); 

  if ( obstacleAt( method.circle.x, method.circle.y) ) {
    method.circle.x = prevX;
    method.circle.y = prevY;
  }
  method.circle.x = constrain(method.circle.x, 0, width);
  method.circle.y = constrain(method.circle.y, 0, height);

  if (toRemove.isEmpty() == false) {
    soundCollect.play();
    targets.removeAll( toRemove );
    toRemove.clear();

    if ( targets.isEmpty() ) {
      restartTrial( true );
    }
  }
}


class Circle {
  float x, y, rad = 15;
  color col = color(255, 0, 0);

  void draw() {
    fill(col);
    circle(x, y, rad*2);
  }

  boolean collideWith( Circle c) {
    return dist(x, y, c.x, c.y) < rad+c.rad;
  }
}

class Grapple extends Circle{
  boolean active;
  float vx, vy;
  
  void draw(){
    fill(color(#4D4D4D));
    circle(x, y, rad*2);
  }
  
  void logic(){
  }
}

void createCircles(final int n) {
  for (int created = 0; created < n; ) {
    final float x = random(0, width);
    final float y = random(0, height);
    if ( obstacleAt(x, y) == false ) {
      targets.add( new Target(x, y) );
      created += 1;
    }
  }
}


class Target extends Circle {
  float t = 0;
  Target(float x, float y) {
    this.x = x; 
    this.y = y; 
    t = random(0, 2*PI);
  }

  void logic() {
    t += 0.1;
  }
  void draw() {
    fill( col );
    circle(x, y+cos(t)*5, rad*2);
  }
}



class NavigationMethod {
  Circle circle;

  NavigationMethod() {
    circle = new Circle();
    circle.rad = 20;
    circle.col = color(0, 255, 0);
  }

  void logic() {
  }
  void draw() { 
    circle.draw();
  }
}

/* Cartessian Method */
final float MOVE_SPEED = 2;
class CartesianMethod extends NavigationMethod {  
  void logic() {
    if (isPressed( UP )) circle.y -= MOVE_SPEED;
    if (isPressed( DOWN )) circle.y += MOVE_SPEED;
    if (isPressed( LEFT )) circle.x -= MOVE_SPEED;
    if (isPressed( RIGHT )) circle.x += MOVE_SPEED;
  }
}

/* Polar Method */
final float ANGLE_SPEED = radians(5);
class PolarMethod extends NavigationMethod {
  float angle = 0;
  void logic() {
    if (isPressed( UP ) || isPressed( DOWN )) {
      final float dir = isPressed( UP ) ? 1 : -0.8;
      goForward( dir * MOVE_SPEED );
    }
    if (isPressed( LEFT )) angle -= ANGLE_SPEED;
    if (isPressed( RIGHT )) angle += ANGLE_SPEED;
  }

  void goForward( float distance ) {
    final float dx = distance * cos( angle );
    final float dy = distance * sin( angle );
    circle.x += dx;
    circle.y += dy;
  }

  void draw() {
    super.draw();
    final float dx = circle.rad * cos( angle );
    final float dy = circle.rad * sin( angle );
    circle(circle.x + dx, circle.y + dy, 5);
  }
}


/* Mouse Method */
class MouseMethod extends PolarMethod {  
  void logic() {
    angle = atan2( mouseY - circle.y, mouseX - circle.x);
    goForward( MOVE_SPEED );
  }
}


/* Grapple Method */
class GrappleMethod extends CartesianMethod {
}





/*for multikey input*/
HashMap<Integer, Boolean> keys = new HashMap<Integer, Boolean>();
void keyPressed() { 
  keys.put( keyCode, true );
}
void keyReleased() { 
  keys.remove( keyCode );
}
boolean isPressed(int code) { 
  return keys.containsKey( code );
}
