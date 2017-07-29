package;


import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxColor;


class Player extends FlxSprite
{
    var jetpack = true;
    
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
            acceleration.x *= 0.1;
        }

        if (jetpack)
        {
            if (FlxG.keys.pressed.UP)
            {
                acceleration.y = -JUMP_SPEED;
            } else {
                acceleration.y = GRAVITY;
            }
        }
        else
        {
            if(FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR))
            {
                velocity.y = -JUMP_SPEED;
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

        if (FlxG.keys.justPressed.B)
        {
            blurCamera(true);
        }

        super.update(elapsed);
    }

    //fix later
    public function blurCamera(blurred:Bool):Void
    {
        if(blurred){
            FlxG.cameras.bgColor = 0x11000000;
        }
        else {
            FlxG.cameras.bgColor = FlxColor.BLACK;
        }
    }

}
