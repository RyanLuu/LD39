package;

import flixel.FlxSprite;


class Drill extends FlxSprite {

    public var drilling:Bool;
    /*
    if(FlxG.keys.pressed.SPACE){
        isSmashing = true;
        color = FlxColor.RED;
        angle += 15;
    }
    else {
        if(angle % 90 != 0)
        {
            angle += 5;
        }
        
        isSmashing = false;
        color = FlxColor.BLACK;
    }
    */
    public function new(?X:Float=0, ?Y:Float=0) {
        super(X, Y);
        drilling = false;
    }

}