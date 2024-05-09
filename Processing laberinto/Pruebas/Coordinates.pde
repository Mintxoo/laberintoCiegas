// Clase que representa las coordenadas en dos dimensiones
public class Coordinates{
  private int x;
  private int y;
  
  // Constructor
  public Coordinates(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  // Getters
  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }
  
  // Setters
  public void setX(int x){
    this.x = x;
  }
  
  public void setY(int y){
    this.y = y;
  }
}
