package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

class PlayState extends FlxState
{

	private var player:Player;
	private var hud:HUD;
	private var fx:FX;

	private var level:Level;
	
	private var currentMap = 0;
	

	override public function create():Void
	{
		super.create();

		FlxG.fixedTimestep = false;
		FlxG.mouse.useSystemCursor = true;

		player = new Player();
		level = new Level();
		hud = new HUD();

		add(level.platforms);
		add(player);
<<<<<<< HEAD
		player.enableDrill(this);
=======
>>>>>>> origin/master
		player.x = level.spawn.x;
		player.y = level.spawn.y;
		player.enableDrill(this);


		setupCamera(player);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(player, level.platforms);
		FlxG.overlap(player, level.grpTeleporter, playerTouchedTele);
		FlxG.overlap(player, level.hazards, playerHitHazard);

	}

	private function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
	}

	private function playerTouchedTele(P:Player, T:Teleportation):Void
	{
		if (P.alive && P.exists)
		{
			remove(level.platforms);
			level.setMap(currentMap + 1);
			add(level.platforms);

			var transitionIn = new FlxSprite(320, 120, AssetPaths.transition_in__png);
			FlxTween.tween(transitionIn, {x: transitionIn.x - 320 }, .33);
			add(transitionIn);
		}
	}

	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		//player takes damage
		trace("ur mum");
	}
}
