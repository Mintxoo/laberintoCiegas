import java.util.ArrayList;

public class LaberintoSolver {
    int[][] maze;
    boolean[][] visited;
    ArrayList<String> path;

    LaberintoSolver(int[][] maze) {
        this.maze = maze;
        this.visited = new boolean[maze.length][maze[0].length];
        this.path = new ArrayList<>();
    }

    boolean resolverLaberinto(int fila, int columna) {
        // Verificar si estamos fuera de los límites del laberinto
        if (fila < 0 || fila >= maze.length || columna < 0 || columna >= maze[0].length) {
            return true;
        }

        // Verificar si ya hemos visitado esta casilla o si es una pared
        if (visited[fila][columna] || maze[fila][columna] == 1) {
            return false;
        }

        // Marcar la casilla actual como visitada
        visited[fila][columna] = true;

        // Verificar si hemos llegado a un borde del laberinto
        if (fila == 0 || fila == maze.length - 1 || columna == 0 || columna == maze[0].length - 1) {
            path.add("(" + fila + ", " + columna + ")");
            return true;
        }

        // Intentar moverse en todas las direcciones posibles (arriba, derecha, abajo, izquierda)
        if (resolverLaberinto(fila - 1, columna) || resolverLaberinto(fila, columna + 1) ||
            resolverLaberinto(fila + 1, columna) || resolverLaberinto(fila, columna - 1)) {
            path.add("(" + fila + ", " + columna + ")");
            return true;
        }

        return false;
    }

    ArrayList<String> resolver() {
        resolverLaberinto(1, 1);
        return path;
    }
}
