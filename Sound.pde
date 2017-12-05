import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;

AudioPlayer audioPlayer;

void initSounds()
{
  minim = new Minim(this);
  audioPlayer = minim.loadFile("SD.wav");
}

void playSound()
{
  audioPlayer.rewind();
  audioPlayer.play();
}
