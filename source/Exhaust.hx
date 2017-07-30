
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxObject;



class Exhaust extends FlxSprite
{

    var player:Player;

    public function new(p:Player)
    {
        super(0,0);
        //width = 10;
        //height = 10;
        player = p;
        loadGraphic(AssetPaths.flame__png, true, 8, 8);
        visible = false;
        //setFacingFlip(FlxObject.RIGHT,false,true);
        //setFacingFlip(FlxObject.LEFT,false,true);
        animation.add("burn",[0,1,2,3,4,5,6,7],3,true,false,false);
        animation.play("burn");
    }

    override public function update(elapsed:Float):Void
    {
        facing = player.facing;
        angle = if(facing == FlxObject.RIGHT) 90+20 else 90-20;
        angle = if(facing == FlxObject.RIGHT) 90+20 else 90-20;
        x = if(facing == FlxObject.RIGHT) player.x-4 else player.x+player.width - width+4;
        y = player.y + player.height -2;
        super.update(elapsed);
    }

    public function enable():Void
    {
        //animation.play("burn");
        visible = true;
    }

    public function disable():Void
    {
        //animation.stop();
        visible = false;
        //trace(""+x);
    }

}