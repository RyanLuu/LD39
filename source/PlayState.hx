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
		add(level.breakables);
		add(hud);
		player.x = level.spawn.x;
		player.y = level.spawn.y;
		player.enableDrill(this);


		setupCamera(player);

	}

	override public function update(elapsed:Float):Void
	{

		FlxG.collide(player, level.platforms);
		FlxG.overlap(player, level.grpTeleporter, playerTouchedTele);
		FlxG.overlap(player, level.hazards, playerHitHazard);
		FlxG.overlap(player.drill, level.breakables, drillSmashed);
		FlxG.collide(player, level.breakables);
		FlxG.collide(level.platforms, level.breakables); //for moving block around

		super.update(elapsed);

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

			P.fadeCam();
			remove(level.platforms);
			remove(level.breakables);
			remove(level.hazards);
			level.reset();
			level.setMap(currentMap + 1);
			add(level.platforms);
			add(level.breakables);
			add(level.hazards);
			add(level.breakables);
			add(level.hazards);
			P.x = level.spawn.x;
			P.y = level.spawn.y;
			hud.updateHUD(">Teleported!");
		}
	}

	private function drillSmashed(drill:Drill, block:BreakableBlock):Void
	{
		block.smash();
	}


	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		player.fadeCam();
		player.x = level.spawn.x;
		player.y = level.spawn.y;
		trace("ur mum");
	}
}
