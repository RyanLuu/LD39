package;


import flixel.FlxSprite;
import flixel.util.FlxColor;


class Boulder extends FlxSprite
{

    var hitCount = 75;

    public function new(?X:Float, ?Y:Float):Void
    {
        super(X,Y);
        width = 32;
        height = 32;
        loadGraphic(AssetPaths.boulder__png);
        immovable = true;
    }

    public function smash():Void
    {
        hitCount--;
        if(hitCount <= 0)
        {
            //width = 0; 
            //height = 0; 
            //makeGraphic(16,16,FlxColor.RED);
            this.color = FlxColor.BLUE;
            drag.x = 300;
            acceleration.y = 420;
            immovable = false;
            //width = 0;
            //height = 0;
            //change image or something idk
        }
    }

}