import java.util.PriorityQueue;

abstract class A {
   protected int map[][];
   
   protected int startX, startY, finishX, finishY;
    
   abstract protected int[][] getMoves();
   
   abstract protected float heuristic(Node node);
   abstract protected float pathCost(Node node);

   protected PriorityQueue<Node> openlist = new PriorityQueue<Node>(100, new NodeComparator());

   protected int found;
   
   protected Node finalNode;

   A(int[][] map, int startX, int startY, int finishX, int finishY){
    this.map = map;
    
    this.startX = startX;
    this.startY = startY;
 
    this.finishX = finishX;
    this.finishY = finishY;
    
    found = 0;
    
    int[] nodePosition = {startX, startY};
    openlist.add(new Node(0, nodePosition, 0, null));
   }
   
   public Node getFinalNode(){
      return finalNode;
   }
   
   public int pathFound(){
     return found;
   }
   
   private boolean check(int[] position){
     if (position[0] < 0 || position[1] < 0 || position[0] > map.length-1 || position[1] > map.length-1)
       return false;
      else 
        return true;
   }
   
   public void findPathStep(){
     if (openlist.isEmpty()){
       found = -1;
       return;
     }
     
     Node curNode = openlist.poll();
     int[] position = curNode.getPosition();
     int[][] moves = getMoves();
     
     for (int[] move: moves){
       int[] newPosition = {position[0] + move[0], position[1] + move[1]};
       
       if (check(newPosition) && map[newPosition[0]][newPosition[1]] == 0){
         
         Node newNode = new Node(newPosition, curNode); 
         float realDist = pathCost(newNode);
         float dist = realDist + heuristic(newNode);
         newNode.setRealDist(realDist);
         newNode.setDist(dist);
         
         if ((newPosition[0] == finishX) && (newPosition[1] == finishY)){
           found = 1;
           finalNode = newNode;
         } else {
            map[newPosition[0]][newPosition[1]] = 2;
            openlist.add(newNode); 
         }
       }
     }
   
   }
   
   public void findPath(){
     while(found == 0)
       findPathStep();
   }

}
