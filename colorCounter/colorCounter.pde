import java.util.Hashtable;


//loads an image walks 
void setup()
{
  size(1900, 500);
  Hashtable<Integer, Integer> colors = new Hashtable<Integer, Integer>();
  PImage p = loadImage("img.png");
  
  //add all colors to a hashtable
  p.loadPixels();
  for (int i = 0; i < p.pixels.length; i++)
  {
    int c = p.pixels[i];
    if (colors.containsKey(c))
    {
      Integer colorCount = colors.get(c) + 1; 
      int old = colors.put(c, colorCount);
    } else {
      colors.put(c, 1);
    }
  }

  int colorCount = colors.keySet().size();
  println("colorCount: " + colorCount);

  //draw bars of color across the screen
  float colorWidth = width*1.f/colors.keySet().size();
  int i = 0;
  for (Integer c : colors.keySet ())
  {
    fill(c);
    noStroke();
    rect(i*colorWidth, 0, colorWidth, height);
    i++;
  }


  //draw histogram of colors

  //get the most frequent color
  int maxCount = -1;
  stroke(0);
  for (Integer c : colors.keySet ())
  {
    maxCount = max(colors.get(c),maxCount);
  }
  println("maxCount: " + maxCount);

  //draw a (nomalized) line across the bottom of the window indicating color frequency in the image
  i = 0;
  stroke(0);
  noFill();
  beginShape();
  for (Integer c : colors.keySet ())
  {
    int currentCount = colors.get(c);
    vertex(i * colorWidth,
           height * (1-currentCount*1.f/(maxCount)) );
    i++;
  }
  endShape();

}

