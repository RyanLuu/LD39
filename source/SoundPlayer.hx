package;


import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.events.Event;


class SoundPlayer
{

    public static var bkgd0:URLRequest;
    public static var bkgd1:URLRequest;

    public static var musicPlayer:Sound;
    public static var fxPlayer0:Sound;
    public static var fxPlayer1:Sound;
    public static var fxPlayer2:Sound;


    public static function setup():Void
    {
        musicPlayer = new Sound();
        fxPlayer0 = new Sound();
        fxPlayer1 = new Sound();
        fxPlayer2 = new Sound();

        bkgd0 = new URLRequest(AssetPaths.Spellbound__mp3);
        bkgd1 = new URLRequest(AssetPaths.Constance__mp3);
        //musicPlayer.addEventListener(Event.COMPLETE, );
    }

    public static function loadTrack(t:Int):Void
    {
        if(t==0) musicPlayer.load(bkgd0);
        if(t==1) musicPlayer.load(bkgd1);
    } 

    public static function playMusic()
    {
        musicPlayer.play(0,9999);
    }

    public static function stopMusic():Void //il est broke
    {
        musicPlayer.close();
    }

    public static function playJump():Void
    {
        var player = nextOpenPlayer();
        player.load(new URLRequest(AssetPaths.Jump__mp3));
        player.play(0,0);

    }

    private static function nextOpenPlayer():Sound
    {
        if(fxPlayer0.bytesTotal == 0){ 
            return fxPlayer0;
        }
        else if (fxPlayer1.bytesTotal == 0){
            return fxPlayer1;
        }
        else if (fxPlayer2.bytesTotal == 0){
            return fxPlayer2;
        }
        else{
            //no players available
            //make a new one
            //not good for speed unless necessary
            return new Sound();
        }
        return new Sound();
        
    }



}