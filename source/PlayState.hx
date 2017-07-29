package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxCollision;


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
		add(level.breakables);
		add(player);
		add(hud);
		sendPlayerToSpawn(player, level);
		player.enableDrill(this);

		setupCamera(player);

	}

	override public function update(elapsed:Float):Void
	{

		FlxG.collide(player, level.platforms);
		//FlxCollision.pixelPerfectCheck(player, level.platforms, 1);
		FlxG.overlap(player, level.grpTeleporter, playerTouchedTele);
		FlxG.overlap(player, level.hazards, playerHitHazard);
		FlxG.overlap(player.drill, level.breakables, drillSmashed);
		FlxG.collide(player, level.breakables);
		FlxG.collide(level.platforms, level.breakables); 
		FlxG.collide(level.breakables, level.breakables);

		//for(i in 0...level.breakables.length)
		//{
			//for(j in 0...level.breakables.length)
			//{
				//if(FlxG.pixelPerfectOverlap(cast (level.breakables.members[i], FlxSprite), cast (level.breakables.members[j]),200))
				//{
					//FlxG.collide(level.breakables.members[i], level.breakables.members[j]);
				//}
				//trace(i);
				//if(FlxCollision.pixelPerfectCheck(cast (level.breakables.members[i], FlxSprite), cast (level.breakables.members[j]),1))
				//{
					//FlxG.collide(level.breakables.members[i], level.breakables.members[j]);
				//}
			//}
		//}

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
			sendPlayerToSpawn(P, level);
		}
	}

	private function drillSmashed(drill:Drill, block:BreakableBlock):Void
	{
		block.smash();
	}


	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		player.fadeCam();
		sendPlayerToSpawn(player, level);

		resetLevel();
		hud.updateHUD(">You Died!");
	}

	private function resetLevel():Void
	{
		remove(level.platforms);
		remove(level.breakables);
		remove(level.hazards);
		level.reset();
		level.setMap(currentMap);
		add(level.platforms);
		add(level.breakables);
		add(level.hazards);
		add(level.breakables);
		add(level.hazards);
	}

	private function sendPlayerToSpawn(player:Player, level:Level)
	{
		player.x = level.spawn.x;
		player.y = level.spawn.y;
	}
}
