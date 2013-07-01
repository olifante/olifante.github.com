//The MIT License (MIT) - See Licence.txt for details
//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

float currentFrame = 0;
int margin = 0;
int imageWidth = 0;
int imageHeight = 0;
PImage [] images1;
PImage [] images2;
PImage [] images3;
PImage [] images4;
PImage img1;
PImage img2;
PImage img3;
PImage img4;
Maxim maxim;
AudioPlayer player1;
int bins = 0;
float power1 = 0;
float power2 = 0;
float power3 = 0;
float power4 = 0;
float scaling = 0.20;
float offset = 1.35;
float threshold = 0.10;// vary this until the square appears on the beats
int wait = 0;
boolean playing = true;

void setup()
{
  size(840, 560);
  maxim = new Maxim(this);
  player1 = maxim.loadFile("ricoloop_yes.wav");
  player1.setLooping(true);
  imageMode(CENTER);
  images1 = loadImages("bold_venture_rabbit/movie", ".jpg", 100, 1000);
  images2 = loadImages("bold_venture_rabbit/movie", ".jpg", 100, 2000);
  images3 = loadImages("bold_venture_rabbit/movie", ".jpg", 100, 3000);
  images4 = loadImages("bold_venture_rabbit/movie", ".jpg", 100, 4000);
  imageWidth = images1[0].width;
  imageHeight = images1[0].height;
  background(10);
  colorMode(HSB);
}

void draw()
{
  if (playing) {
    fill(255);
    player1.play();
    bins = player1.bins();

    power1 = scaling*(offset + player1.getAveragePower(0, 200));
    power2 = scaling*(offset + player1.getAveragePower(200, 400));
    power3 = scaling*(offset + player1.getAveragePower(400, 600));
    power4 = scaling*(offset + player1.getAveragePower(600, 800));

    if (power1 && power2 && power3 && power4) {
      console.log("powers: " + power1 + ", " + power2 + ", " + power3 + ", " + power4);
    }

    //    rect(0, 0, imageWidth*power1, imageHeight*power1);
    //    if (power1>threshold && wait < 0) {
    //      rect(0, 0, 500, 500);
    //      wait=4;
    //    }
    //    wait--;

    background(10); 
    imageMode(CENTER);
    img1 = images1[(int)currentFrame];
    img2 = images2[(int)currentFrame];
    img3 = images3[(int)currentFrame];
    img4 = images4[(int)currentFrame];
    //    img1.resize(imageWidth*power1, imageHeight*power1);
    //    img2.resize(0, imageHeight*power2);
    //    img3.resize(0, imageHeight*power3);
    //    img4.resize(0, imageHeight*power4);
    colorMode(HSB);
    fill(0.2*255, 128, power1*255);
    rect(0, 0, 0.5*width, 0.5*height);
    fill(0.4*255, 128, power2*255);
    rect(0, 0.5*height, 0.5*width, 0.5*height);
    fill(0.6*255, 128, power3*255);
    rect(0.5*width, 0, 0.5*width, 0.5*height);
    fill(0.8*255, 128, power4*255);
    rect(0.5*width, 0.5*height, 0.5*width, 0.5*height);

    image(img4, (0.50+power4)*width, (0.50+power4)*height, imageWidth, imageHeight);
    image(img1, (0.50-power1)*width, (0.50-power1)*height, imageWidth, imageHeight);
    image(img2, (0.50-power2)*width, (0.50+power2)*height, imageWidth, imageHeight);
    image(img3, (0.50+power3)*width, (0.50-power3)*height, imageWidth, imageHeight);

    currentFrame= currentFrame + 1;
    if (currentFrame >= images1.length) {
      currentFrame = 0;
    }
  }
}

//The MIT License (MIT)

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


PImage [] loadImages(String stub, String extension, int numImages, int startImage)
{
  startImage = startImage || 0;
  finalImage = startImage + numImages;
  PImage [] images = new PImage[0];
  for(int i = startImage; i <= finalImage; i++)
  {
    PImage img = loadImage(stub+i+extension);
    if(img != null)
    {
      images = (PImage [])append(images,img);
    }
    else
    {
      break;
    }
  }
  return images;
}

