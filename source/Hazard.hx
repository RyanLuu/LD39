package;

import flixel.FlxSprite;


class Hazard extends FlxSprite
{

    public static inline var DAMAGE = 1;

    public function new(?X:Float=0, ?Y:Float=0):Void
    {
        super(X,Y);
        width = 16;
        height = 16;
    }
}