package;


import flixel.FlxSprite;


class Player extends FlxSprite
{
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(10, 10);
        acceleration.y = 10;
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
    }

}