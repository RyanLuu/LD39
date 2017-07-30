package;


import openfl.media.Sound;
import openfl.net.URLRequest;


class SoundPlayer
{

    public static var bkgd0:URLRequest;

    public static var musicPlayer:Sound;
    public static var fxPlayer:Sound;


    public static function setup():Void
    {
        musicPlayer = new Sound();
        fxPlayer = new Sound();

        bkgd0 = new URLRequest("/assets/data/Spellbound.mp3");
    }

    public static function loadTrack(t:Int):Void
    {
        //if(t==0) musicPlayer.load(bkgd0);
        musicPlayer.load(new URLRequest(AssetPaths.Spellbound__mp3));
    } 

    public static function playMusic():Void
    {
        musicPlayer.play(0,0);
    }

    public static function stopMusic():Void
    {
        musicPlayer.close();
    }



}