package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxObject;

class Player extends FlxSprite
{
    var jetpack = true;

    public var boi:Boi;
    public var exhaust:Exhaust;

    public static inline var RUN_SPEED = 80;
    public static inline var GRAVITY = 420;
    public static inline var JUMP_SPEED = 210;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.rover__png, true, 24, 24);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        drag.x = RUN_SPEED * 8;
        acceleration.y = GRAVITY;
        maxVelocity.x = RUN_SPEED;
        maxVelocity.y = JUMP_SPEED * 1.5;
        boi = new Boi(this);
        exhaust = new Exhaust(this);
        animation.add("idle", [0,1,2,1], 6);
        animation.play("idle");
    }

    override public function update(elapsed:Float):Void
    {
        acceleration.x = 0;

        if (!isTouching(FlxObject.FLOOR))
        {
            acceleration.x *= 0.5;
        }

        if (FlxG.keys.pressed.LEFT)
        {
            facing = FlxObject.LEFT; 
            acceleration.x = -drag.x;
        }
        else if (FlxG.keys.pressed.RIGHT)
        {
            facing = FlxObject.RIGHT;
            acceleration.x = drag.x;                
        }

        if (jetpack)
        {
            acceleration.y = if (FlxG.keys.pressed.UP) -JUMP_SPEED * 0.5 else GRAVITY;
            if (FlxG.keys.pressed.UP) exhaust.enable() else exhaust.disable();
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
        exhaust.update(elapsed);
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

        super.update(elapsed);
        
    }

    public function updateDrill()
    {
        drillObj.x = if (facing == FlxObject.RIGHT) x + 10 else x - 5;
        drillObj.y = y;

        if(drillObj.drilling) drillObj.angle += 10;
        if(drillObj.angle % 90 != 0) drillObj.angle += 5;
        */
    }

    public function checkBounds(f: Void -> Void):Void
    {
        if (y > (FlxG.height*FlxG.camera.zoom+30)) f();
    }
}
