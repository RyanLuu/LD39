package;


import flixel.FlxSprite;
import flixel.util.FlxColor;


class Boulder extends FlxSprite
{

    var hitCount = 30;
    var slamCount = 2;

    public function new(?X:Float, ?Y:Float):Void
    {
        super(X,Y);
        width = 32;
        height = 32;
        loadGraphic(AssetPaths.boulder__png);
        immovable = true;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

    public function smash()
    {
        hitCount = 0;
        this.color = FlxColor.BLUE;
        drag.x = 300;
        acceleration.y = 420;
        immovable = false;
    }

    public function slam()
    {
        slamCount--;
        if(slamCount <= 0) smash();
    }

    public function drill():Void
    {
        hitCount--;
        if(hitCount <= 0)
        {
            //width = 0; 
            //height = 0; 
            //makeGraphic(16,16,FlxColor.RED);
            smash();
            //width = 0;
            //height = 0;
            //change image or something idk
        }
    }
}