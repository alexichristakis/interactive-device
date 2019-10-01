import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.sound.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class processing extends PApplet {

int NUM_SHAPES = 3;
int RES = 200;
Shape[] shapes;
Input input;

public void setup() {
    // size(1000, 1000);
    
    strokeWeight(12);
    noFill();

    input = new Input();
    
    shapes = new Shape[NUM_SHAPES];
    shapes[0] = new Shape(this, width / 2.0f, height / 3.0f, 100, RES, input);
    shapes[1] = new Shape(this, width / 3.0f, 2.0f * height / 3.0f, 100, RES, input);
    shapes[2] = new Shape(this, 2.0f * width / 3.0f, 2.0f * height / 3.0f, 100, RES, input);
}

public void draw() {
    background(0);
    for (Shape shape : shapes) {
        shape.display();
    }
}

public void mousePressed() {
    input.pressMouse();
}

public void mouseReleased() {
    input.releaseMouse();
}
class Input {
    boolean mousePressed;
    Input() {
        this.mousePressed = false;
    }

    public void pressMouse() {
        this.mousePressed = true;
    }

    public void releaseMouse() {
        this.mousePressed = false;
    }
}


class Point {
    float x, y;
    Point(float x, float y) {
        this.x = x;
        this.y = y;
    }
}

class Shape {
    Input input;
    Point center;
    Point[] poly;
    SinOsc[] chord;
    float radius;
    int n;

    int root = 30;
    int[] major = { 4, 5, 6 };
    int[] minor = { 10, 12, 15 };

    Shape(PApplet parent, float cx, float cy, float radius, int n, Input input) {
        this.center = new Point(cx, cy);
        this.radius = radius;   
        this.n = n;
        this.input = input;

        this.poly = new Point[n + 1];
        for (int i = 0; i <= n; i++) {
            float x = center.x + 100*sin(map(i, 0, n-1, 0, TAU));
            float y = center.y + 100*cos(map(i, 0, n-1, 0, TAU));
            this.poly[i] = new Point(x, y);
        }

        this.chord = new SinOsc[3];
        for (int i = 0; i < 3; i++) {
            this.chord[i] = new SinOsc(parent);
            this.chord[i].freq(major[i] * root);
            this.chord[i].stop();
        }

    }

    public float logMap(float value, float start1, float stop1, float start2, float stop2) {
        start2 = log(start2);
        stop2 = log(stop2);

        float outgoing = exp(start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1)));

        return outgoing;
    }

    public void warpOsc() {
        float bias = 0;
        for (int i = 0; i < n; i++) {
            bias = max(bias, dist(mouseX, mouseY, poly[i].x, poly[i].y));
        }

        for (int i = 0; i < chord.length; i++) {
            chord[i].freq(map(bias, width, 0, major[i], minor[i]) * root);
        }
    }

    public void drawPoly(int dx, int dy) {
        float g = 0;
        if (input.mousePressed) g = random(-2, 2);
            
        beginShape();
        for (int i = 0; i < n; i++) {
            float bias = dist(mouseX, mouseY, poly[i].x, poly[i].y);
            vertex(
                poly[i].x + dx / logMap(bias, (float) width, 0.0f, (float) dx, 45.0f) + g, 
                poly[i].y + dy / logMap(bias, (float) height, 0.0f, (float) dy, 45.0f) + g
            );
        }
        endShape();

        warpOsc();
    }

    public void display() {
        blendMode(ADD);
        stroke(255, 0, 0);
        drawPoly(1000, 1000);
        
        stroke(0, 255, 0);
        drawPoly(1200, 1500);
        
        stroke(0, 0, 255);
        drawPoly(2000, 1700);

        if (input.mousePressed) {
            for (int i = 0; i < chord.length; i++) {
                chord[i].play();
                chord[i].amp(0.3f);
            }
        } else {
            for (int i = 0; i < chord.length; i++) {
                chord[i].amp(0.0f);
                chord[i].stop();
            }
        }
    }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
