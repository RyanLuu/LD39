package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;

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
		add(player.drillObj);
		add(hud);
		sendPlayerToSpawn(player, level);

		setupCamera(player);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(player, level.platforms);
		//FlxCollision.pixelPerfectCheck(player, level.platforms, 1);
		FlxG.overlap(player, level.grpTeleporter, playerTouchedTele);
		FlxG.overlap(player, level.hazards, playerHitHazard);
		FlxG.overlap(player.drillObj, level.breakables, drillSmashed);
		FlxG.collide(player, level.breakables);
		FlxG.collide(level.platforms, level.breakables);
		FlxG.collide(level.breakables, level.breakables);
		player.y = Math.round(player.y); // eliminate jittering caused by floating point inaccuracy
		player.updateDrill();
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

		if (FlxG.keys.justPressed.B)
        {
			CameraFX.addFilter(CameraFX.blur);
			hud.updateHUD("Camera Malfunction Detected");
        }

        if (FlxG.keys.justPressed.I)
        {
			CameraFX.addFilter(CameraFX.red);
			hud.updateHUD("Color Camera Failure: Switching to IR Sensor");
        }

		if(FlxG.keys.justPressed.R)
		{
			CameraFX.clearFilters();
			hud.updateHUD("Color Camera Power Restored");
		}

	}

	private function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
	}

	private function playerTouchedTele(P:Player, T:Teleportation):Void
	{
		CameraFX.fade();
		if (P.alive && P.exists)
		{

			CameraFX.fade();
			currentMap++;
			resetLevel();
			hud.updateHUD(">Teleported!");
			sendPlayerToSpawn(P, level);
		}
	}

	private function drillSmashed(drill:Drill, block:BreakableBlock):Void
	{
		if(drill.drilling)
		{
			block.smash();
		}
	}


	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		CameraFX.fade();
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
	}

	private function sendPlayerToSpawn(player:Player, level:Level)
	{
		player.x = level.spawn.x;
		player.y = level.spawn.y;
	}
}
