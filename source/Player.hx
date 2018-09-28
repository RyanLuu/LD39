package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxObject;

class Player extends FlxSprite
{
    public var jetpack = true;

    public var boi:Boi;
    public var exhaust:Exhaust;

    public var jumping = false;

    public static inline var RUN_SPEED = 80;
    public static inline var GRAVITY = 420;
    public static inline var JUMP_SPEED = 210;
    public static inline var TERMINAL_VELOCITY = 310;

    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);
        loadGraphic(AssetPaths.rover__png, true, 24, 24);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);
        drag.x = RUN_SPEED * 8;
        maxVelocity.x = RUN_SPEED;
        maxVelocity.y = TERMINAL_VELOCITY;
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

        if (FlxG.keys.anyPressed([LEFT, A]))
        {
            facing = FlxObject.LEFT; 
            acceleration.x = -drag.x;
        }
        else if (FlxG.keys.anyPressed([RIGHT, D]))
        {
            facing = FlxObject.RIGHT;
            acceleration.x = drag.x;                
        }

        if (jetpack)
        {
            if (FlxG.keys.anyPressed([UP, W])) {
                acceleration.y = -JUMP_SPEED * 0.5;
                exhaust.enable();
            } else {
                acceleration.y = GRAVITY;
                exhaust.disable();
            }
            if (FlxG.keys.anyJustPressed([UP,W])) SoundPlayer.playJet();
            
        } else {
            acceleration.y = GRAVITY;
            exhaust.disable();
        }
        if(FlxG.keys.anyJustPressed([UP, W]) && isTouching(FlxObject.FLOOR))
        {
            velocity.y = -JUMP_SPEED;
            if (jetpack) {
                velocity.y *= 0.5;
            } else {
                SoundPlayer.playJump();
                jumping = true;
            }
        }

        if (jumping)
        {
            jumping = velocity.y < 0;
            if (!FlxG.keys.anyPressed([UP, W])) {
                acceleration.y = GRAVITY * 1.5;
            }
        }

        if(boi.mode != 2 && boi.mode != 3 && boi.mode != 5) boi.mode = if (FlxG.keys.pressed.SPACE) 1 else 0;

        super.update(elapsed);
        boi.update(elapsed);
        exhaust.update(elapsed);
    }

    public function checkBounds(level:Level, f: Void -> Void):Void
    {
        
        if (y > level.platforms.height) f();
    }

    public function slowDown():Void
    {
        drag.x += 40;
    }
}
