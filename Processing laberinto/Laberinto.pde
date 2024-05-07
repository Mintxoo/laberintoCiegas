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
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 ,1},
};

int w, h; // Ancho y alto de cada celda

void setup() {
  size(400, 400);
  w = width / maze[0].length;
  h = height / maze[1].length;
  drawMaze();
  LaberintoSolver solver = new LaberintoSolver(maze);
  ArrayList<String> path = solver.resolver();
  if(path != null && !path.isEmpty()){
    System.out.println("Se encontró una solución.");
    for (int i = 0; i < path.size(); i++) {
      System.out.println(path.get(i));
    }
  }
  else{
    System.out.println("No existe una solución.");
  }
}

void draw() {
  // No necesitamos ningún loop de dibujo en draw(), ya que 
  // dibujamos el laberinto una sola vez en setup().
}

void drawMaze() {
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[0].length; j++) {
      if (maze[i][j] == 0) {
        fill(255); // Espacios libres blancos
      } 
      else if (maze[i][j] == 1) {
        fill(0); // Pared negra
      }
      rect(j * w, i * h, w, h);
    }
  }
}
