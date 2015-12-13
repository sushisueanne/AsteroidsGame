SpaceShip peaches= new SpaceShip();
boolean right, left, up, down; 
ArrayList<Asteroids> freds = new ArrayList<Asteroids>();
stars [] tubbs = new stars[250];

Bullets pickle= new Bullets;
public void setup() 
{
  size(600,600);
//stars
  for (int i=0; i<tubbs.length; i++){
    tubbs[i]=new stars();
  }

//asteroids
  for(int i=0; i<9; i++){
    freds.add(new Asteroids());
  }
}

public void draw() 
{
    background(0);
    peaches.move();
    peaches.show();

    if (up==true){
      peaches.accelerate(.5);
    }
    if(down==true){
      peaches.accelerate(-.5);
    }
    if(left==true){
      peaches.rotate(-10);
    }
    if(right==true){
      peaches.rotate(10);
    }

    for (int i=0; i<tubbs.length; i++){
      tubbs[i].show();
    }
    
   if (freds.size()<2){
      for (int i=0; i<9; i++){
       freds.add(i, new Asteroids());
       }
   }
   
   for (int i=0; i<freds.size()-1; i++){     
        if ( dist(peaches.getX(), peaches.getY(), freds.get(i).getX(), freds.get(i).getY())<40 ){
          freds.remove(i);
       } 
       
      freds.get(i).move();
      freds.get(i).show();
      }
}

public void keyPressed(){

  if (key=='w'){
    up=true;
  }
  if (key=='s'){
    down=true;
  }

  if (key=='a'){
    left=true;
  }
  if (key=='d'){
    right=true;
  }
  if (key=='h'){
    peaches.setX((int)(Math.random()*500));
    peaches.setY((int)(Math.random()*500));
    peaches.setDirectionX(0);
    peaches.setDirectionY(0);
    peaches.setPointDirection((int)(Math.random()*10));
  }
}

public void keyReleased(){ 
  if (key=='w'){
    up=false;
  }
  if (key=='s'){
    down=false;
  }
  if (key=='a'){
    left=false;
  }
  if (key=='d'){
    right=false;
  }
}

class SpaceShip extends Floater  
{   
    public SpaceShip (){
      corners=4;
      int [] xSEdge = {-8, 16,-8, -2};
      int [] ySEdge = {-8, 0, 8,0};
      xCorners = xSEdge;
      yCorners= ySEdge;
      myColor=255;
      myCenterX=(250);
      myCenterY=(250);
      myDirectionX=0;
    }

    public void setX (int x){
      myCenterX=x;
    }
    public int getX(){
      return (int) (myCenterX);
    }
    public void setY (int y) {
      myCenterY=y;
    }
    public int getY (){
      return (int)(myCenterY);
    }
    public void setDirectionX(double x){
      myDirectionX=x;
    }
    public double getDirectionX(){
      return myDirectionX;
    }
    public void setDirectionY(double y){
      myDirectionY=y;
    }
    public double getDirectionY(){
      return myDirectionY;
    }
    public void setPointDirection(int degrees){
      myPointDirection=degrees;
    }
    public double getPointDirection(){
      return myPointDirection;
    }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

class Asteroids extends Floater{
  int asteroidRotate;
  public Asteroids() {
    corners=6;
    int [] xAEdge= {10, 12, 19, 20, 24,27};
    int [] yAEdge= {-20, 13, -30, 19, -20, 25};
    xCorners= xAEdge;
    yCorners= yAEdge;
    myColor= 250;
    myCenterY=(double)(Math.random()*675)-225;
    myCenterX=(double)(Math.random()*675)-225;
    myDirectionX=(double)(Math.random()*5)-2;
    myDirectionY=(double)(Math.random()*5)-2;
    myPointDirection=(double)(Math.random()*361);
    asteroidRotate=(int)(Math.random()*14)-7;
  }

  public void setX (int x){
      myCenterX=x;
    }
    public int getX(){
      return (int) (myCenterX);
    }
    public void setY (int y) {
      myCenterY=y;
    }
    public int getY (){
      return (int)(myCenterY);
    } 
    public void setDirectionX(double x){
      myDirectionX=x;
    }
    public double getDirectionX(){
      return myDirectionX;
    }
    public void setDirectionY(double y){
      myDirectionY=y;
    }
    public double getDirectionY(){
      return myDirectionY;
    }
    public void setPointDirection(int degrees){
      myPointDirection=degrees;
    }
    public double getPointDirection(){
      return myPointDirection;
    }
    public void move(){
      rotate(asteroidRotate);
      super.move();
    }
}

class Bullets extends Floater{
  Bullets(SpaceShip theShip){
    myColor=200;
    myCenterY=theShip.getY();
    myCenterX=theShip.getX();
    myPointDirection=theShip.getPointDirection();
    double dRadians= myPointDirection*(Math.PI/180);
    myDirectionX= 5*Math.cos(dRadians)+ theShip.getDirectionX;
    myDirectionY= 5*Math.sin(dRadians) + theShip.getDirectionY;
  }
  public void setX (int x){
      myCenterX=x;
    }
    public int getX(){
      return (int) (myCenterX);
    }
    public void setY (int y) {
      myCenterY=y;
    }
    public int getY (){
      return (int)(myCenterY);
    } 
    public void setDirectionX(double x){
      myDirectionX=x;
    }
    public double getDirectionX(){
      return myDirectionX;
    }
    public void setDirectionY(double y){
      myDirectionY=y;
    }
    public double getDirectionY(){
      return myDirectionY;
    }
    public void setPointDirection(int degrees){
      myPointDirection=degrees;
    }
    public double getPointDirection(){
      return myPointDirection;
    }
    public void show(){
      fill(myColor);
      stroke(myColor);
      ellipse((float)myCenterX, (float) myCenterY, 3, 3 );
    }
}



class stars {
  int starX, starY;
  public stars (){
    starX=(int)(Math.random()*600);
    starY=(int)(Math.random()*600);
  }

  public void show (){
    fill(255);
    ellipse(starX,starY,1,1);
  }

}