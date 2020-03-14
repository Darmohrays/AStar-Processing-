import java.util.PriorityQueue;
import java.lang.Math;

int state = 0;
/*
  0 - mark obstacles
  1 - set start
  2 - set finish
  3 - algorithm run
  4 - path founded
  5 - path not founded
*/
int window = 700;
int map[][];
float mapSize = 600;
float mapStartX = 50, mapStartY = 75;
int squares = 50;
float squareSize = mapSize / squares;
int startX = -1, startY = -1;
int finishX = -1, finishY = -1;
PFont f;
String textToDraw = "";
A astar;


void setup(){
  size(700, 750);
  map = new int[squares][squares];
  f = createFont("Arial", 16, true);
}

void draw(){
  background(227);
  drawMap();
  if (resetPushed())
    resetGame();
  if (state == 0){
    textToDraw = "Mark obstacles";
    if (keyPressed && key == 10)
      state++;
    if (mousePressed && is_mouse_on_map()){
     int x = getSquare('x');
     int y = getSquare('y');
     if (mouseButton == LEFT)
       map[x][y] = 1;
     if (mouseButton == RIGHT)
       map[x][y] = 0;
    }
  } else if (state == 1){
      textToDraw = "Mark start";
      if (mousePressed && is_mouse_on_map()){
        int x = getSquare('x');
        int y = getSquare('y');
        if (map[x][y] == 0){
          startX = x;
          startY = y;
          state = 2;
          }
        }
   } else if (state == 2){
       textToDraw = "Mark finish";
       if (mousePressed && is_mouse_on_map()){
        int x = getSquare('x');
        int y = getSquare('y');
        if (map[x][y] == 0 && (x != startX || y != startY)){
          finishX = x;
          finishY = y;
          int[] node = {startX, startY};
          astar = new AStar(map, startX, startY, finishX, finishY);
          state = 3;
      }
    }  
  } else if (state == 3){
      textToDraw = "Searching";
      if (astar.pathFound() == 1){
        state = 4;
        textToDraw = "Path Founded";
        drawPath(astar.getFinalNode());
      }
      else if (astar.pathFound() == -1){
        textToDraw = "There is no path!";
        state = 5;
      } else
         astar.findPathStep();
  }
}

void drawResetButton(){
  fill(237);
  rect(550, 700, 75, 40, 5);
  fill(0);
  textFont(f, 16);
  text("Reset", 565, 725);
}

boolean resetPushed(){
  if (mousePressed && mouseX > 550 && mouseX < 625 && mouseY > 700 && mouseY < 740)
    return true;
  
  return false; 
}

void resetGame(){
   for (int i = 0; i < squares; i++)
    for (int j = 0; j < squares; j++)
      map[i][j] = 0;
      
   startX = -1;
   startY = -1;
   finishX = -1;
   finishY = -1;
  
   state = 0;
}

int getSquare(char s){
  if (s == 'x') {
    float tempX = mouseX - mapStartX;
    return int(tempX / squareSize);
  }
  else {
    float tempY = mouseY - mapStartY;
    return int(tempY / squareSize);
  }
}

boolean is_mouse_on_map(){
  if (mouseX <= mapStartX || mouseX >= mapStartX + mapSize)
    return false;
  if (mouseY <= mapStartY || mouseY >= mapStartY + mapSize)
    return false;
    
  return true;
} 


void drawText(String text){
  textFont(f, 36);
  fill(0);
  text(text, 225, 55);
}

void drawMap(){
    fill(255);
    stroke(0);
    rect(mapStartX, mapStartY, mapSize, mapSize);
    for (int i = 0; i < squares; i++){
      float tempX = mapStartX + i*squareSize; 
       for (int j = 0; j < squares; j++){
        float tempY = mapStartY + j*squareSize;
        if (map[i][j] == 1)
          fill(0);
        else if((i == startX) && (j == startY))
          fill(0, 255, 0);
        else if((i == finishX) && (j == finishY))
          fill(255, 0, 0); 
        else if (map[i][j] == 3)
          fill(0, 200, 255);
        else if (map[i][j] == 2)
          fill(0, 0, 255);
        else fill(255);
        rect(tempX, tempY, squareSize, squareSize);
    }
  }
  drawResetButton();
  drawText(textToDraw);
}

boolean isNodeOnMap(int[] position){
  if (position[0] < 0 || position[0] >= squares)
    return false;
  if (position[1] < 0 || position[1] >= squares)
    return false;
  
  return true;
}

void drawPath(Node node){
  Node tempNode = node;
  while (!(tempNode == null)){
    int[] position = tempNode.getPosition();
    map[position[0]][position[1]] = 3;
    tempNode = tempNode.getCameFrom();
  }
}
