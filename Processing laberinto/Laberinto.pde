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
  w = width / maze[0].length;
  h = height / maze[1].length;
  drawMaze();
}

void draw() {
  // No necesitamos ningún loop de dibujo en draw(), ya que 
  // dibujamos el laberinto una sola vez en setup().
}

void keyPressed() {
  Coordinates newCoordinates;
  if (keyCode == UP) {
    newCoordinates = moveUp(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Arriba");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (keyCode == DOWN) {
    newCoordinates = moveDown(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Abajo");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (keyCode == LEFT) {
    newCoordinates = moveLeft(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Izquierda");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  else if (keyCode == RIGHT) {
    newCoordinates = moveRight(coordinates);
    if(newCoordinates == coordinates){
      println("Movimiento invalido: Derecha");
    }
    else{
      println("Movimiento valido: INICIO (" + coordinates.getX() + "," + coordinates.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinates = newCoordinates;
    }
  }
  drawMaze();
  if(esFinal(maze, coordinates)){
    println("--------------------------------------");
    println("VICTORIA: Has completado el laberinto.");
    println("--------------------------------------");
    exit();
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
