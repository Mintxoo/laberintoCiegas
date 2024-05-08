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
  /* RATON */
  if (keyCode == UP) {
    newCoordinates = moveUp(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Arriba");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }
  else if (keyCode == DOWN) {
    newCoordinates = moveDown(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Abajo");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }
  else if (keyCode == LEFT) {
    newCoordinates = moveLeft(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Izquierda");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }
  else if (keyCode == RIGHT) {
    newCoordinates = moveRight(coordinatesMouse);
    if(newCoordinates == coordinatesMouse){
      println("Movimiento invalido MOUSE: Derecha");
    }
    else{
      println("Movimiento valido MOUSE: INICIO (" + coordinatesMouse.getX() + "," + coordinatesMouse.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesMouse = newCoordinates;
    }
  }
  
  /* GATO */
  if (key == 'w') {
    newCoordinates = moveUp(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Arriba");
    }
    else{
      println("Movimiento valido CAT: INICIO (" + coordinatesCat.getX() + "," + coordinatesCat.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesCat = newCoordinates;
    }
  }
  else if (key == 's') {
    newCoordinates = moveDown(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Abajo");
    }
    else{
      println("Movimiento valido CAT: INICIO (" + coordinatesCat.getX() + "," + coordinatesCat.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesCat = newCoordinates;
    }
  }
  else if (key == 'a') {
    newCoordinates = moveLeft(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Izquierda");
    }
    else{
      println("Movimiento valido CAT: INICIO (" + coordinatesCat.getX() + "," + coordinatesCat.getY() + ") FINAL (" + newCoordinates.getX() + "," + newCoordinates.getY() + ")");
      coordinatesCat = newCoordinates;
    }
  }
  else if (key == 'd') {
    newCoordinates = moveRight(coordinatesCat);
    if(newCoordinates == coordinatesCat){
      println("Movimiento invalido CAT: Derecha");
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
