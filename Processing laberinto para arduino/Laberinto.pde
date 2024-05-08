import processing.serial.*;

Serial serialPort;

// Mostrar laberinto
int[][] maze = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1},
  {1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
  {1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1},
  {1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1},
  {1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0 ,1},
  {1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0 ,1},
  {1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1 ,1},
  {1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1 ,1},
  {1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0 ,1},
  {1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0 ,1},
  {1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0 ,1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ,1},
};

Coordinates coordinates = new Coordinates(1,1);
int w, h; // Ancho y alto de cada celda

void setup() {
  size(400, 400);
  serialPort = new Serial(this, "COM3", 9600);
  w = width / maze[0].length;
  h = height / maze[1].length;
  drawMaze();
}

int[] sensorsData = new int[4]; // guarda la distancia de los sensores
String data;


void draw() {
  delay(1000); // lee inputs cada 1s
  if (serialPort.available() > 0) { // Si hay datos disponibles en el puerto serie
  
    data = serialPort.readStringUntil('\n'); // Lee una línea de datos
    // if (data != null) { igual hace falta
    String[] distances = split(data, ',');
    sensorsData[0] = int(distances[0]);
    sensorsData[1] = int(distances[1]);
    sensorsData[2] = int(distances[2]);
    sensorsData[3] = int(distances[3]);

    processMovement();
  }
  changeLeds();
  
}

void processMovement() {
  Coordinates newCoordinates;
  // player 1
  int p1_f = sensorsData[0]; // sensor in front
  int p1_r = sensorsData[1]; // sensor in right
  
  if (35 > p1_f) { // move up
    newCoordinates = moveUp(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Arriba");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (35 > p1_r) { // move right
    newCoordinates = moveRight(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Derecha");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (45 < p1_r) { // move left
    newCoordinates = moveLeft(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Izquierda");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (45 < p1_f){ // move down
    newCoordinates = moveDown(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Abajo");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  // else, stay still
  
  // player 2
  int p2_f = sensorsData[0]; // sensor in front
  int p2_r = sensorsData[1]; // sensor in right
  
  if (35 > p2_f) { // move up
    newCoordinates = moveUp(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Arriba");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (35 > p2_r) { // move right
    newCoordinates = moveRight(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Derecha");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (45 < p2_r) { // move left
    newCoordinates = moveLeft(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Izquierda");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (45 < p2_f){ // move down
    newCoordinates = moveDown(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Abajo");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  // else, stay still

  drawMaze();
  if(esFinal(maze, coordinates)){
    println("--------------------------------------");
    println("VICTORIA: Has completado el laberinto.");
    println("--------------------------------------");
    exit();
  }
}

int[] ledArray = new int[12]; // 6 for every player, values 1(green),2(yellow),3(red)

void changeLeds(){
  
}

// Movimiento
Coordinates moveUp(Coordinates coordinates){
  // Mover arriba
  Coordinates newCoordinates = new Coordinates(coordinates.getX()-1,coordinates.getY());
  // Comprobar validez
  if(maze[newCoordinates.getX()][newCoordinates.getY()] == 1){
    return coordinates; // Movimiento invalido
  }
  else{
    return newCoordinates;  // Movimiento valido
  }
}

Coordinates moveDown(Coordinates coordinates){
  // Mover abajo
  Coordinates newCoordinates = new Coordinates(coordinates.getX()+1,coordinates.getY());
  // Comprobar validez
  if(maze[newCoordinates.getX()][newCoordinates.getY()] == 1){
    return coordinates; // Movimiento invalido
  }
  else{
    return newCoordinates;  // Movimiento valido
  }
}

Coordinates moveLeft(Coordinates coordinates){
  // Mover izquierda
  Coordinates newCoordinates = new Coordinates(coordinates.getX(),coordinates.getY()-1);
  // Comprobar validez
  if(maze[newCoordinates.getX()][newCoordinates.getY()] == 1){
    return coordinates; // Movimiento invalido
  }
  else{
    return newCoordinates;  // Movimiento valido
  }
}

Coordinates moveRight(Coordinates coordinates){
  // Mover derecha
  Coordinates newCoordinates = new Coordinates(coordinates.getX(),coordinates.getY()+1);
  // Comprobar validez
  if(maze[newCoordinates.getX()][newCoordinates.getY()] == 1){
    return coordinates; // Movimiento invalido
  }
  else{
    return newCoordinates;  // Movimiento valido
  }
}

// Dibujar laberinto
void drawMaze() {
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[0].length; j++) {
      if (i == coordinates.getX() && j == coordinates.getY()){
        fill(0,255,0); // Casilla actual verde
      }
      else if (i == 1 && j == 1){
        fill(0,0,255); // Casilla inicial azul
      }
      else if(i == (maze.length -2) && j == (maze[0].length -2)){
        fill(255,0,0); // Casilla final roja
      }
      else if (maze[i][j] == 0) {
        fill(255); // Espacios libres blancos
      } 
      else if (maze[i][j] == 1) {
        fill(0); // Pared negra
      }
      rect(j * w, i * h, w, h);
    }
  }
}

// Final del juego
boolean esFinal(int[][] maze, Coordinates coordinates)
{
  return(coordinates.getX() == (maze.length -2) && coordinates.getY() == (maze[0].length -2));
}
