package;


import flixel.FlxSprite;
import flixel.util.FlxColor;


class BreakableBlock extends FlxSprite
{

    var hitCount = 175;

    public function new(?X:Float, ?Y:Float):Void
    {
        super(X,Y);
        width = 16;
        height = 16;
        makeGraphic(16,16,FlxColor.GREEN);
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