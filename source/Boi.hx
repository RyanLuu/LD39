import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class Boi extends FlxSprite {

    var player:Player;
    public var mode:Int;
    var desiredPos:FlxPoint;

    var ctr = 0.0;

    public function new(player:Player) {
        super(0, 0);
        this.player = player;
        loadGraphic(AssetPaths.boi__png);
        desiredPos = new FlxPoint();
    }

    override public function update(elapsed:Float):Void
    {
        ctr += elapsed;
        if (mode == 0) {
            desiredPos.x = if (player.facing == FlxObject.RIGHT) player.x - 16 else player.x + player.width + 16;
            desiredPos.y = player.y;
            desiredPos.y += Math.sin(ctr) * 4;
            if (angle >= 10) {
                angle = (angle + 10) % 360;
            }
            loadGraphic(AssetPaths.boi__png);
        } else if (mode == 1) {
            desiredPos.x = if (player.facing == FlxObject.RIGHT) player.x + player.width + 8 else player.x - 8;
            desiredPos.y = player.y + 8;
            angle = (angle + 10) % 360;
            loadGraphic(AssetPaths.boi_drill__png);
        } else if (mode == 2) { //no drill
            desiredPos.x = if (player.facing == FlxObject.RIGHT) player.x - 20 else player.x + player.width + 20;
            desiredPos.y = player.y;
            desiredPos.y += Math.sin(ctr) * 4;
            loadGraphic(AssetPaths.boi__png);
        } else if (mode == 3) { //disabled
            if (angle < 110) angle += 1;
            if (!isTouching(FlxObject.FLOOR)) y++; 
            desiredPos.x = x;
            desiredPos.y = y;
            //visible = false;
        } else if (mode == 4) { //re-enable mode
            visible = true;
            mode = 0;
        } else if (mode == 5){
            visible = false;
            immovable = true;
            desiredPos.x = x;
            desiredPos.y = y;
        }
        var dx = desiredPos.x - x;
        var dy = desiredPos.y - y;
        x += dx * 0.1;
        y += dy * 0.1;
    }

    public function setPos(X:Float, Y:Float)
    {
        x = X;
        y = Y;
        desiredPos.x = X;
        desiredPos.y = Y;
    }
}