import java.lang.Math;

public class AStar extends A{
  protected int startX, startY, finishX, finishY;
  
  AStar(int[][] map, int startX, int startY, int finishX, int finishY){
    super(map, startX, startY, finishX, finishY);
    this.startX = startX;
    this.startY = startY;
    this.finishX = finishX;
    this.finishY = finishY;
  }
  
  protected int[][] getMoves(){
    int[][] moves = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; 
    return moves;
  }
  
  protected float heuristic(Node node){
    int[] position = node.getPosition();
    return (float)Math.sqrt(Math.pow(position[0] - finishX, 2) + Math.pow(position[1] - finishY, 2));
  }
  
  protected float pathCost(Node node){
    return node.getCameFrom().getRealDist() + 1;
  }

}
