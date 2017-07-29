package;

import flixel.FlxState;
import flixel.FlxG;

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
		add(level.breakables);
		add(hud);
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
<<<<<<< HEAD
		FlxG.overlap(player.drill, level.breakables, drillSmashed);
		FlxG.collide(player, level.breakables);
		FlxG.collide(level.platforms, level.breakables); //for moving block around

=======
>>>>>>> origin/master
	}

	private function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
	}

	private function playerTouchedTele(P:Player, T:Teleportation):Void
	{
		P.fadeCam();
		if (P.alive && P.exists)
		{
			remove(level.platforms);
			remove(level.breakables);
			remove(level.hazards);
			level.reset();
			level.setMap(currentMap + 1);
			add(level.platforms);
<<<<<<< HEAD
			add(level.breakables);
			add(level.hazards);

			var transitionIn = new FlxSprite(320, 120, AssetPaths.transition_in__png);
			FlxTween.tween(transitionIn, {x: transitionIn.x - 320 }, .33);
			//add(transitionIn);
			hud.updateHUD(">Teleporting!");
=======
			hud.updateHUD(">Teleported!");
>>>>>>> origin/master
		}
	}

	private function drillSmashed(drill:Drill, block:BreakableBlock):Void
	{
		block.smash();
	}


	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		player.x = level.spawn.x;
		player.y = level.spawn.y;
		trace("ur mum");
	}
}
