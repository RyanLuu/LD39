package;


import flixel.FlxSprite;
import flixel.FlxG;


class Player extends FlxSprite
{
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(10, 10);
        acceleration.y = 420/2;
        drag.x = 640/2;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if(FlxG.keys.pressed.LEFT)
        {
            //facing = LEFT;
            acceleration.x = -drag.x;
        }
        else if(FlxG.keys.pressed.RIGHT)
        {
            //facing = RIGHT;
            acceleration.x = drag.x;
        }

    }

}