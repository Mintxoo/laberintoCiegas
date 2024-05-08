import processing.serial.*;

Serial serialPort;

// Mostrar laberinto
int[][] maze = {
//     0  1  2  3  4  5  6  7  8  9  10 11 12 13 14  j
/*0 */{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
/*1 */{1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1},
/*2 */{1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1},
/*3 */{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
/*4 */{1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1},
/*5 */{1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1},
/*6 */{1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1},
/*7 */{1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0 ,1},
/*8 */{1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0 ,1},
/*9 */{1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1 ,1},
/*10*/{1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1 ,1},
/*11*/{1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0 ,1},
/*12*/{1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0 ,1},
/*13*/{1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0 ,1},
/*14*/{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ,1},
/*i*/
};

Coordinates coordinatesCat = new Coordinates(1,1);
Coordinates coordinatesMouse = new Coordinates(3,6);
int w, h; // Ancho y alto de cada celda

void setup() {
  size(400, 400);
  serialPort = new Serial(this, "COM8", 9600);
  w = width / maze[0].length;
  h = height / maze[1].length;
  drawMaze();
}

int[] sensorsData = new int[4]; // guarda la distancia de los sensores
String data;
boolean[] ledArray = new boolean[12]; // 6 for every player, values: 0(green),1(red)

void draw() {
  data = serialPort.readStringUntil('\n'); // Lee una línea de datos
  println(data);
  if (data != null) {
    println("queee"+data);
    String[] distances = split(data, ',');
    sensorsData[0] = int(distances[0]);
    sensorsData[1] = int(distances[1]);
    sensorsData[2] = int(distances[2]);
    sensorsData[3] = int(distances[3]);
 
    processMovement();
    
    changeLeds();
    serialPort.write(booleanArrayToString(ledArray));
  }
  delay(1000);
}

String booleanArrayToString(boolean[] array) {
  String result = "";
  for (boolean value : array) {
    result += value ? '1' : '0'; // Convertir true a '1' y false a '0'
  }
  return result;
}

void processMovement() {
  Coordinates newCoordinates;
  /* RATON --> player 1 */
  int p1_f = sensorsData[0]; // sensor in front
  int p1_r = sensorsData[1]; // sensor in right
  if (35 > p1_f) { // move up
    newCoordinates = moveUp(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Arriba");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }
  else if (35 > p1_r) { // move right
    newCoordinates = moveRight(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Derecha");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }
  else if (45 < p1_r) { // move left
    newCoordinates = moveLeft(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Izquierda");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }
  else if (45 < p1_f){ // move down
    newCoordinates = moveDown(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Abajo");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }

  /* GATO --> player 2 */
  int p2_f = sensorsData[2]; // sensor in front
  int p2_r = sensorsData[3]; // sensor in right
  if (35 > p2_f) { // move up
    newCoordinates = moveUp(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Arriba");
    }
    else{
      println("Movimiento valido CAT: INICIO (" + coordinatesCat.getX() + "," + coordinatesCat.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesCat = newCoordinates;
    }
  }
  else if (35 > p2_r) { // move right
    newCoordinates = moveRight(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Derecha");
    }
    else{
      println("Movimiento valido CAT: INICIO (" + coordinatesCat.getX() + "," + coordinatesCat.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesCat = newCoordinates;
    }
  }
  else if (45 < p2_r) { // move left
    newCoordinates = moveLeft(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Izquierda");
    }
    else{
      println("Movimiento valido CAT: INICIO (" + coordinatesCat.getX() + "," + coordinatesCat.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesCat = newCoordinates;
    }
  }
  else if (45 < p2_f){ // move down
    newCoordinates = moveDown(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Abajo");
    }
    else{
      println("Movimiento valido CAT: INICIO (" + coordinatesCat.getX() + "," + coordinatesCat.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesCat = newCoordinates;
    }
  }
  
  
  // Compruebo si el juego ha acabado
  if(isFinalMouse(maze, coordinatesMouse)){
    println("--------------------------------------------");
    println("MOUSE VICTORIA: Has completado el laberinto.");
    println("--------------------------------------------");
    exit();
  }
  if(isFinalCat(coordinatesMouse, coordinatesCat)){
    println("------------------------------------------");
    println("CAT VICTORIA: Has completado el laberinto.");
    println("------------------------------------------");
    exit();
  }
  
  drawMaze();
}

void changeLeds(){
  // RATON --> player 1
  if (maze[coordinatesMouse.getX()-1][coordinatesMouse.getY()] == 0){ // no wall at the left
    ledArray[0] = false;
  }else{
    ledArray[0] = true;
  }
  if (maze[coordinatesMouse.getX()][coordinatesMouse.getY()-1] == 0){ // no wall at the top
    ledArray[1] = false;
    ledArray[2] = false;
  }else{
    ledArray[1] = true;
    ledArray[2] = true;
  } 
  if (maze[coordinatesMouse.getX()+1][coordinatesMouse.getY()] == 0){ // no wall at the right
    ledArray[3] = false;
  }else{
    ledArray[3] = true;
  }
  if (maze[coordinatesMouse.getX()][coordinatesMouse.getY()+1] == 0){ // no wall at the bottom
    ledArray[4] = false;
    ledArray[5] = false;
  }else{
    ledArray[4] = true;
    ledArray[5] = true;
  }  
  
  // GATO --> player 2
  if (maze[coordinatesCat.getX()-1][coordinatesCat.getY()] == 0){ // no wall at the left
    ledArray[6] = false;
  }else{
    ledArray[6] = true;
  }
  if (maze[coordinatesCat.getX()][coordinatesCat.getY()-1] == 0){ // no wall at the top
    ledArray[7] = false;
    ledArray[8] = false;
  }else{
    ledArray[7] = true;
    ledArray[8] = true;
  } 
  if (maze[coordinatesCat.getX()+1][coordinatesCat.getY()] == 0){ // no wall at the right
    ledArray[9] = false;
  }else{
    ledArray[9] = true;
  }
  if (maze[coordinatesCat.getX()][coordinatesCat.getY()+1] == 0){ // no wall at the bottom
    ledArray[10] = false;
    ledArray[11] = false;
  }else{
    ledArray[10] = true;
    ledArray[11] = true;
  }
  
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
      if (i == coordinatesCat.getX() && j == coordinatesCat.getY()){
          fill(126,126,126);
        }
      else if (i == coordinatesMouse.getX() && j == coordinatesMouse.getY()){
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
boolean isFinalMouse(int[][] maze, Coordinates coordinatesMouse)
{
  return(coordinatesMouse.getX() == (maze.length -2) && coordinatesMouse.getY() == (maze[0].length -2));
}
boolean isFinalCat(Coordinates coordinatesMouse, Coordinates coordinatesCat)
{
  return(coordinatesCat.getX() == coordinatesMouse.getX() && coordinatesCat.getY() == coordinatesMouse.getY());
}
