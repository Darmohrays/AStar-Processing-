import java.util.Comparator;

class Node {
    private float dist;
    private int position[];
    private float realDist;
    private Node cameFrom;

    public Node(int[] position, Node cameFrom){
        this.position = position;
        this.cameFrom = cameFrom;
    }

    public Node(float dist, int[] position, float realDist, Node cameFrom){
        this.dist = dist;
        this.position = position;
        this.realDist = realDist;
        this.cameFrom = cameFrom;
    }

    @Override
    public String toString() {
        return "(" + position[0] + ", " + position[1] + ")";
    }

    public float getDist(){
        return dist;
    }
    
    public void setDist(float dist){
        this.dist = dist;
    }
    
    public int[] getPosition(){
        return position;
    }
    
    public float getRealDist(){
      return realDist;
    }
    
    public void setRealDist(float realDist){
        this.realDist = realDist;
    }
    
    public Node getCameFrom(){
      return cameFrom;
    }

}

class NodeComparator implements Comparator<Node>{
    public int compare(Node node1, Node node2){
        if (node1.getDist() > node2.getDist())
            return 1;
        else if (node1.getDist() < node2.getDist())
            return -1;
        else
            return 0;
    }
}
