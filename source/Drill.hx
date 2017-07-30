package;


import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxG;


class Drill extends FlxSprite
{

    private var player:Player;
    public var isSmashing = false;


    public function new(?X:Float=0,?Y:Float=0, p:Player)
    {
        super(X,Y);
        player = p;
        makeGraphic(5,5,FlxColor.BLACK);
        //immovable = true;
    }

    override public function update(elapsed:Float):Void
    {

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

        if(player.facing == FlxObject.RIGHT){
            x = player.x+10;
        }
        else{
            x = player.x-5;
        }
        
        
        y = player.y;

        super.update(elapsed);
    }


}