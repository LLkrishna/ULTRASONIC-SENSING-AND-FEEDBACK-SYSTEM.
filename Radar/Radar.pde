// Import necessary libraries
import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

// Declare serial port variable
Serial myPort;

// Declare variables for angle, distance, data, and "noObject" status
String angle = "";
String distance = "";
String data = "";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1 = 0;
int index2 = 0;
PFont orcFont;

void setup() {
  // Set the canvas size and enable smoothing
  size(1366, 768);
  smooth();
  
  // Initialize the serial port communication
  myPort = new Serial(this, "COM9", 9600);
  myPort.bufferUntil('.');
  
  // Load a custom font
  //orcFont = loadFont("Arial-Black-48.vlw");
}

void draw() {
  // Set background color and draw radar display
  fill(98, 245, 31);
  noStroke();
  fill(0, 4);
  rect(0, 0, width, 1010);
  fill(98, 245, 31);
  drawRadar();
  drawLine();
  drawObject();
  drawText();
}

void serialEvent(Serial myPort) {
  // Read and parse data from the serial port
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length() - 1);
  index1 = data.indexOf(",");
  angle = data.substring(0, index1);
  distance = data.substring(index1 + 1, data.length());
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  // Draw the radar display
  pushMatrix();
  translate(683, 384);
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  // Draw concentric circles
  circle(0, 0, 140);
  circle(0, 0, 280);
  circle(0, 0, 420);
  circle(0, 0, 560);
  circle(0, 0, 700);
  // Draw radial lines
  line(0,0,-348*cos(radians (30)), -348*sin(radians (30))); 
line(0,0,-348*cos(radians (60)), -348*sin(radians (60)));
line(0, 0, -348*cos(radians (90)), -348*sin(radians (90)));
line(0,0,-348*cos(radians (120)), -348*sin(radians (120)));
line(0,0,-348*cos (radians (150)), -348*sin(radians (150)));

line(0,0,-348*cos(radians (210)), -348*sin(radians (210)));
line(0,0,-348*cos (radians (240)), -348*sin(radians (240)));
line(0,0,-348*cos(radians (270)), -348*sin(radians (270)));
line(0,0,-348*cos(radians (300)), -348*sin(radians (300)));
line(0,0,-348*cos(radians (330)), -348*sin(radians (330)));
line(-400*cos(radians (30)),0,348,0);
  // ...
  popMatrix();
}

void drawObject() {
  // Draw the detected object
  pushMatrix();
  translate(683, 384);
  strokeWeight(15);
  stroke(255, 10, 10);
  pixsDistance = iDistance * 10;
  if (iDistance < 50) {
    point(pixsDistance * cos(radians(iAngle * -1)), -pixsDistance * sin(radians(iAngle * -1)));
  }
  popMatrix();
}

void drawLine() {
  // Draw the radar line indicating object direction
  pushMatrix();
  strokeWeight(5);
  stroke(30, 250, 60);
  translate(683, 384);
  line(0, 0, 348 * cos(radians(iAngle * -1)), -348 * sin(radians(iAngle * -1)));
  popMatrix();
}

void drawText() {
  // Draw text information on the screen
  pushMatrix();
  if (iDistance > 50) {
    noObject = "";
  } else {
    noObject = "object detected";
  }
  fill(0, 0, 0);
  noStroke();
  square(0, 0, 300);
  fill(98, 245, 31);
  textSize(11);
  text("10cm", 733,384);
text("20cm",  803,384);
text("30cm",  873,384);
text("40cm",  943,384);
text("50cm", 1013,384);
  textSize(25);
  text("DTR:-" + noObject, 0, 80);
  text("Angle: " + iAngle + " *", 0, 150);
  text("Distance: ", 0, 220);
  if (iDistance < 50) {
    text("" + iDistance + " cm", 120, 220);
  }
  // Draw angle labels
  
textSize(25);
fill (98,245,60);
translate (417+500*cos (radians (30)),315-500*sin(radians (30)));
rotate(-radians(-30));
text("60",0,0);
resetMatrix();
translate (735+500*cos (radians (60)), 620-500*sin(radians (60)));
rotate(-radians(-60));
text("30",0,0);
resetMatrix();
translate (1045+500*cos (radians (90)),1350-960*sin(radians (90)));
rotate(radians (0));
text("0",0,0);
resetMatrix();
translate(912+500*cos(radians (120)), 457-500*sin(radians (120)));
rotate(radians (0));
text(" 90",0,0);
resetMatrix();
translate (916+500*cos(radians (150)),334-500*sin(radians (150)));
rotate(radians (-30));
text("120",0,0);
translate (435-500*cos (radians (30)), 488+500*sin(radians (30)));
rotate(-radians (0));
text("300",0,0);
resetMatrix(); 
translate(90+500*cos(radians (60)), 120+500*sin(radians (60)));
rotate(-radians (-60));
text("210",0,0);
resetMatrix();


translate (281-970*cos (radians (90)), 893-500*sin(radians (90)));
rotate(radians(0));
text("180",0,0);
resetMatrix();
translate (745-500*cos(radians (240)), 165-500*sin(radians (240)));
rotate(radians(-60));
text("330",0,0);
resetMatrix();
translate (890+500*cos (radians (150)), 442+500*sin(radians (150)));
rotate(radians (+30));
text("   240",0,0);
resetMatrix();
translate (361, 215);
rotate(radians (-60));
text("150",0,0);
resetMatrix();
translate (667,755);
rotate(radians (0));
text("270",0,0);

  // ...
  popMatrix();
}
