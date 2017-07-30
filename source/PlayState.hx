package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class PlayState extends FlxState
{

	private var player:Player;
	private var hud:HUD;
	private var fx:FX;

	private var level:Level;

	private var currentLevel:Int = 0;

	override public function create():Void
	{
		super.create();

		FlxG.fixedTimestep = true;
		FlxG.mouse.useSystemCursor = true;

		player = new Player();
		level = new Level();
		hud = new HUD();

		add(level.platforms);
		add(level.boulders);
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
		FlxG.overlap(player.drillObj, level.boulders, drillSmashed);
		FlxG.overlap(player, level.boulders, bodyslam);
		FlxG.collide(level.platforms, level.boulders);
		FlxG.collide(level.boulders, level.boulders);
		player.y = Math.round(player.y); // eliminate jittering caused by floating point inaccuracy
		player.updateDrill();
		player.checkBounds(playerFellOffMap);
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

		if (FlxG.keys.justPressed.F12)
		{
			FlxG.debugger.visible = !FlxG.debugger.visible;
		}
	}

	private function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
		FlxG.camera.focusOn(new FlxPoint(player.x, player.y));
	}

	private function playerTouchedTele(P:Player, T:Teleportation):Void
	{
		CameraFX.fade();
		if (P.alive && P.exists)
		{

			CameraFX.fade();
			setLevel(T.to);
			hud.updateHUD(">Teleported!");
			sendPlayerToSpawn(P, level);
		}
	}

	private function bodyslam(player:Player, boulder:Boulder)
	{
		if (player.velocity.y > 275) {
			boulder.smash();
		}
		FlxG.collide(player, boulder);
	}

	private function drillSmashed(drill:Drill, boulder:Boulder):Void
	{
		if(drill.drilling)
		{
			boulder.drill();
		}
	}


	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		CameraFX.fade();
		sendPlayerToSpawn(player, level);

		resetLevel();
		hud.updateHUD(">You Died!");
	}

	private function setLevel(level:Int)
	{
		currentLevel = level;
		this.level.setMap(level);
	}

	private function playerFellOffMap():Void
	{
		CameraFX.fade();
		sendPlayerToSpawn(player, level);

		resetLevel();
		hud.updateHUD(">You Died!");
	}


	private function resetLevel():Void
	{
		remove(level.platforms);
		remove(level.boulders);
		remove(level.hazards);
		level.reset();
		setLevel(currentLevel);
		add(level.platforms);
		add(level.boulders);
		add(level.hazards);
	}

	private function sendPlayerToSpawn(player:Player, level:Level)
	{
		player.x = level.spawn.x;
		player.y = level.spawn.y;
	}
}
