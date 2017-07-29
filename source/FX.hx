package;


import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxSprite;


class FX extends FlxSprite
{

    var emitter:FlxEmitter;
    var particle:FlxParticle;

    var player:Player;
    

    public function new(p:Player):Void
    {

        super();

        player = p;

        FlxG.camera.useBgAlphaBlending = true;
        emitter = new FlxEmitter(player.x, player.y, 10);
        emitter.width = player.width;
        emitter.acceleration.set(0,-40);
        emitter.velocity.set(-20,-75,20,-25);
        
        emitter.start(false, 0.1);

    }

    override public function update(elapsed:Float):Void
    {
        emitter.x = player.x;
        emitter.y = player.y;

        var particles:Int = 10;
        var colors:Array<Int> = [FlxColor.RED, FlxColor.GRAY];

        for(i in 0...particles)
        {
            particle = new FlxParticle();
            particle.makeGraphic(6,6, colors[Std.int(FlxG.random.float() * colors.length)]);
            particle.exists = false;
            emitter.add(particle);
        }

        super.update(elapsed);
    }


    public function addEmitter(state:FlxState)
    {
        state.add(emitter);
    }
    
    
}