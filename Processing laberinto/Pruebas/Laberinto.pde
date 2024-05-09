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
  
  MazeSolver mazeSolver = new MazeSolver(maze);
  // Distancia Mouse
  if(mazeSolver.resolveMaze(coordinatesMouse.getX(), coordinatesMouse.getY(), 13, 13)){
    println("Distancia mouse salida: " + mazeSolver.distance);
  }
  else{println("Error mouse");}
  
  // Distancia Cat
  mazeSolver = new MazeSolver(maze);
  if(mazeSolver.resolveMaze(coordinatesMouse.getX(), coordinatesMouse.getY(), coordinatesCat.getX(), coordinatesCat.getY())){
    println("Distancia mouse cat: " + mazeSolver.distance);
  }
  else{println("Error cat mouse");}
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
