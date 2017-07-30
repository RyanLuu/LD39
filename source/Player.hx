package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxObject;

class Player extends FlxSprite
{
    var jetpack = true;

    public var boi:Boi;

    public static inline var RUN_SPEED = 80;
    public static inline var GRAVITY = 420;
    public static inline var JUMP_SPEED = 200;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.rover__png);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        drag.x = RUN_SPEED * 8;
        acceleration.y = GRAVITY;
        maxVelocity.x = RUN_SPEED;
        maxVelocity.y = JUMP_SPEED * 1.5;
        boi = new Boi(this);
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

        boi.mode = if (FlxG.keys.pressed.SPACE) 1 else 0;

        super.update(elapsed);
        boi.update(elapsed);
        /*
        if(velocity.x != 0)
        {
            if(facing == FlxObject.RIGHT){
                angle += 15;
            }
            else {
                angle -= 15;
            }
        }
        else if(angle % 90 != 0)
        {
            if(facing == FlxObject.RIGHT){
                angle += 15;
            }
            else {
                angle -= 15;
            }
        }
        else {
            angle = 0;
        }
        */
    }

    public function checkBounds(f: Void -> Void):Void
    {
        if (y > (FlxG.height*FlxG.camera.zoom+30)) f();
    }
}
