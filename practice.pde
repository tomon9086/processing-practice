/**
 * Processing practice
 * 
 * 
 */

import java.util.Comparator;
import java.util.Arrays;

int[][] points = new int[0][2];

void setup() {
  size(640, 360);
  noStroke();
  //rectMode(CENTER);
}

void draw() {
  background(30);
  for (int i = 0; i < points.length; i++) {
    int[] pos = points[i];
    int factor = 5;
    int tx = (int)random(-factor, factor);
    int ty = (int)random(-factor, factor);
    pos[0] += tx;
    pos[1] += ty;
    int radius = 3;
    fill(255);
    ellipse(pos[0], pos[1], radius, radius);
    //int[] nearest = nearest(pos[0], pos[1]);
    //stroke(255);
    //line(pos[0], pos[1], nearest[0], nearest[1]);
    int[][] near = near(pos[0], pos[1], 4);
    for(int j = 1; j < near.length; j++) {
      stroke(255);
      line(pos[0], pos[1], near[j][0], near[j][1]);
    }
  }
}

void mousePressed() {
  int[] point = { mouseX, mouseY };
  points = (int[][])append(points, point);
}

int[] nearest(int x, int y) {
  int[] ret = { x, y };
  float min = -1;
  for (int i = 0; i < points.length; i++) {
    int dx = points[i][0] - x;
    int dy = points[i][1] - y;
    float d = sqrt(dx * dx + dy * dy);
    if (d != 0 && (min < 0 || d < min)) {
      ret[0] = points[i][0];
      ret[1] = points[i][1];
      min = d;
    }
  }
  return ret;
}

int[][] near(int x, int y, int n) {
  int l = points.length;
  if(n > l) {
    n = l;
  }
  float[][] dists = new float[l][2];
  int[][] ret = new int[n][2];
  for (int i = 0; i < l; i++) {
    int dx = points[i][0] - x;
    int dy = points[i][1] - y;
    dists[i][0] = (float)i;
    dists[i][1] = sqrt(dx * dx + dy * dy);
  }
  Arrays.sort(dists, new Comparator() {
    public int compare(Object a, Object b) {
      float diff = ((float[])a)[1] - ((float[])b)[1];
      int ret = 0;
      if(diff < 0) {
        ret = -1;
      } else if(diff > 0) {
        ret = 1;
      }
      return ret;
    }
  });
  for(int i = 0; i < n; i++) {
    ret[i][0] = points[(int)dists[i][0]][0];
    ret[i][1] = points[(int)dists[i][0]][1];
  }
  return ret;
}
