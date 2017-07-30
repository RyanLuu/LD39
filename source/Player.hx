package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxObject;

class Player extends FlxSprite
{
    var jetpack = true;
    var drill = true;

    public var drillObj:Drill;

    public static inline var RUN_SPEED = 80;
    public static inline var GRAVITY = 420;
    public static inline var JUMP_SPEED = 200;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        makeGraphic(10, 10);
        drag.x = RUN_SPEED * 8;
        acceleration.y = GRAVITY;
        maxVelocity.x = RUN_SPEED;
        maxVelocity.y = JUMP_SPEED;
        drillObj = new Drill();
        drillObj.makeGraphic(5, 5, FlxColor.BLACK);
    }

    override public function update(elapsed:Float):Void
    {
        acceleration.x = 0;
        if(FlxG.keys.pressed.LEFT)
        {
            facing = FlxObject.LEFT;
            acceleration.x -= drag.x;
        }
        else if(FlxG.keys.pressed.RIGHT)
        {
            facing = FlxObject.RIGHT;
            acceleration.x += drag.x;
        }
        if (!isTouching(FlxObject.FLOOR))
        {
            acceleration.x *= 0.5;
        }

        if (drill)
        {
            drillObj.drilling = FlxG.keys.pressed.SPACE;
        }

        if (jetpack)
        {
            acceleration.y = if (FlxG.keys.pressed.UP) -JUMP_SPEED * 0.5 else GRAVITY;
        }
        if(FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR))
        {
            velocity.y = -JUMP_SPEED;
            if (jetpack) {
                velocity.y *= 0.5;
            }
        }
    
        if (FlxG.keys.justPressed.CONTROL)
        {
            jetpack = !jetpack;
            if (!jetpack)
            {
                acceleration.y = GRAVITY;
            }
        }

        super.update(elapsed);
        
    }

    public function updateDrill()
    {
        drillObj.x = if (facing == FlxObject.RIGHT) x + 10 else x - 5;
        drillObj.y = y;
    }

    public function checkBounds(f: Void -> Void):Void
    {
        if (y > (FlxG.height*FlxG.camera.zoom+30)) f();
    }
}
