package;

import flixel.FlxSprite;


class Drill extends FlxSprite {

    public var drilling:Bool;

    public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        drilling = false;
    }

}