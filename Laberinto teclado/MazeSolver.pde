import java.util.ArrayList;

public class MazeSolver {
    int[][] maze;
    boolean[][] visited;
    int distance;

    MazeSolver(int[][] maze) {
        this.maze = maze;
        this.visited = new boolean[maze.length][maze[0].length];
    }

    public boolean resolveMaze(int x1, int y1, int x2, int y2){
      distance = 0;
  // Comprobar si se ha visitado una casilla o si la posición es válida
    if(visited[x1][y1] || maze[x1][y1] == 1){
      return false;
    }
    visited[x1][y1] = true;
        
    // Comprobar si ha llegado al objetivo
    if(x1 == x2 && y1 == y2){
      distance++;
      return true;
    }
        
    // Intentar moverse en todas las direcciones
    if(this.resolveMaze(x1-1,y1,x2,y2) || this.resolveMaze(x1+1,y1,x2,y2) || this.resolveMaze(x1,y1-1,x2,y2) || this.resolveMaze(x1,y1+1,x2,y2)){
      distance++;
      return true;
    }
    return false;
  }
}
