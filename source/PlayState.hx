package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.addons.display.FlxBackdrop;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{

	private var player:Player;
	private var hud:HUD;
	private var fx:FX;
	private var pausedText:FlxText;
	private var prompter:Prompter;

	private var level:Level;

	private var paused:Bool = false;


	override public function create():Void
	{
		super.create();

		FlxG.fixedTimestep = true;
		FlxG.mouse.useSystemCursor = true;

		player = new Player();
		level = new Level();
		hud = new HUD();
		//prompter = new Prompter(player,hud);
		pausedText = new FlxText(0, FlxG.height / 2, FlxG.width);
		pausedText.text = "Game Paused";
		pausedText.scrollFactor.set(0, 0);
		pausedText.alignment = CENTER;

		add(new FlxBackdrop(AssetPaths.bg__png, 0.25, 0, true, false));
		add(new FlxBackdrop(AssetPaths.bg1__png, 0.5, 0, true, false));
		add(level.platforms);
		add(level.boulders);
		add(player);
		add(player.boi);
		add(player.exhaust);
		add(hud);
		sendPlayerToSpawn(player, level);

		setupCamera(player);

		SoundPlayer.setup();
		SoundPlayer.loadTrack(1);
		SoundPlayer.playMusic();

	}

	override public function update(elapsed:Float):Void
	{

		super.update(elapsed);


		FlxG.overlap(player, level.grpTeleporter, playerTouchedTele);
		FlxG.collide(player, level.platforms);
		//FlxCollision.pixelPerfectCheck(player, level.platforms, 1);
		FlxG.overlap(player, level.hazards, playerHitHazard);
		FlxG.overlap(player, level.boulders, bodyslam);
		FlxG.collide(level.platforms, level.boulders);
		FlxG.collide(level.boulders, level.boulders);
		FlxG.overlap(player.boi, level.boulders, boiDrill);
		FlxG.overlap(player, level.events, triggerEvent);
		player.y = Math.round(player.y); // eliminate jittering caused by floating point inaccuracy
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


		if(FlxG.keys.justPressed.ESCAPE)
		{
			paused = !paused;
			if (paused) {
				add(pausedText);
				forEach(function(x) x.active = false, true);
				CameraFX.addFilter(CameraFX.gray);
				//SoundPlayer.stopMusic();
			} else {
				remove(pausedText);
				forEach(function(x) x.active = true, true);
				CameraFX.removeFilter(CameraFX.gray);
				//SoundPlayer.playMusic();
			}
		}

		

		if (FlxG.keys.justPressed.R) {
			resetLevel();
			sendPlayerToSpawn(player, level);
		}

		if (FlxG.keys.justPressed.F12)
		{
			FlxG.debugger.visible = !FlxG.debugger.visible;
		}

		//prompter.update(level.current);
	}

	private function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
		FlxG.camera.focusOn(new FlxPoint(player.x, player.y));
	}

	private function playerTouchedTele(P:Player, T:Teleportation):Void
	{
		if (P.alive && P.exists)
		{
			CameraFX.transition(function func() {
				setLevel(T.to);
				sendPlayerToSpawn(P,level);
			});
		}
	}

	private function bodyslam(player:Player, boulder:Boulder)
	{
		if (player.velocity.y > 275) {
			boulder.slam();
		}
		FlxG.collide(player, boulder);
	}

	private function boiDrill(boi:Boi, boulder:Boulder):Void
	{
		if(boi.mode == 1)
		{
			boulder.drill();
		}
	}


	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		CameraFX.transition(function f() {
			resetLevel();
			sendPlayerToSpawn(player, level);
		});
	}

	private function setLevel(new_level:Int)
	{
		this.level.current = new_level;
		resetLevel();
	}

	private function playerFellOffMap():Void
	{
		CameraFX.transition(function f() {
			resetLevel();
			sendPlayerToSpawn(player, level);
		});
	}


	private function resetLevel():Void
	{
		remove(level.platforms);
		remove(level.boulders);
		remove(level.hazards);
		level.load();
		add(level.platforms);
		add(level.boulders);
		add(level.hazards);
	}

	private function sendPlayerToSpawn(player:Player, level:Level)
	{
		player.x = level.spawn.x;
		player.y = level.spawn.y;
		player.velocity.x = 0;
		player.velocity.y = 0;
		player.boi.setPos(player.x, player.y);
	}

	private function triggerEvent(P:Player, E):Void
	{
		if (Std.is(E, HUDEvent)) {
			E.trigger(hud);
		} else if (Std.is(E, SpecialEvent)) {
			switch E.eventid {
				case "disableJetpack": {
					hud.updateHUD("WARNING: Disabling enhanced propulsion to conserve power.");
					player.jetpack = false;
					player.exhaust.disable();
				}
				case "disableBoi": {
					hud.updateHUD("WARNING: Disabling B.O.I. to conserve power.");
					player.boi.mode = 3;
				}
				case "disableDrill": {
					hud.updateHUD("WARNING: Disabling drill functionality to conserve power.");
					player.boi.mode = 2;
				}
				default: "Invalid event triggered.";
			}
		}
	}
}
