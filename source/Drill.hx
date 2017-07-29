package;


import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;


class Drill extends FlxSprite
{

    private var player:Player;


    public function new(?X:Float=0,?Y:Float=0, p:Player)
    {
        super(X,Y);
        player = p;
        makeGraphic(5,5,FlxColor.BLACK);
        //immovable = true;
    }

    override public function update(elapsed:Float):Void
    {

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