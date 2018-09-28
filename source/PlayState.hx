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

	private var level:Level;

	private var paused:Bool = false;

	private var bg0:FlxBackdrop;
	private var bg1:FlxBackdrop;
	private var bg2:FlxBackdrop;


	override public function create():Void
	{
		super.create();

		FlxG.fixedTimestep = true;
		FlxG.mouse.useSystemCursor = true;

		player = new Player();
		level = new Level();
		hud = new HUD();
		pausedText = new FlxText(0, FlxG.height / 2, FlxG.width);
		pausedText.text = "Game Paused";
		pausedText.scrollFactor.set(0, 0);
		pausedText.alignment = CENTER;

		bg0 = new FlxBackdrop(AssetPaths.bg__png, 0.25, 0, true, false);
		bg1 = new FlxBackdrop(AssetPaths.bg1__png, 0.5, 0, true, false);
		bg2 = new FlxBackdrop(AssetPaths.bg2__png, 0.5, 0, true, false);

		add(bg0);
		add(bg1);
		add(level.platforms);
		add(level.boulders);
		add(player);
		add(player.boi);
		add(player.exhaust);
		add(hud);
		respawnPlayer(player, level);

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
		if(level.current != 10) player.checkBounds(level, playerFellOffMap);
		if(player.boi.mode == 3) FlxG.collide(level.platforms, player.boi);

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
			loadCurrentLevel();
			respawnPlayer(player, level);
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
		if (P.alive && P.exists)
		{
			CameraFX.transition(function func() {
				setLevel(T.to);
				respawnPlayer(P,level);
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
			loadCurrentLevel();
			respawnPlayer(player, level);
		});
	}

	private function setLevel(new_level:Int)
	{
		this.level.current = new_level;
		loadCurrentLevel();
	}

	private function playerFellOffMap():Void
	{
		CameraFX.transition(function f() {
			loadCurrentLevel();
			respawnPlayer(player, level);
		});
	}


	private function loadCurrentLevel():Void
	{
		remove(level.platforms);
		remove(level.boulders);
		remove(level.hazards);
		level.load();
		add(level.platforms);
		add(level.boulders);
		add(level.hazards);

		if(level.current == 7){
			changeBackdrop();
		}
		hud.clearText();
	}

	private function respawnPlayer(player:Player, level:Level)
	{
		player.x = level.spawn.x;
		player.y = level.spawn.y;
		player.velocity.x = 0;
		player.velocity.y = 0;
		player.boi.setPos(player.x, player.y);
		player.facing = FlxObject.RIGHT;
		player.jetpack = level.jetpackEnabled;
	}

	private function changeBackdrop()
	{
		remove(bg0);
		remove(bg1);
		add(bg2);
	}

	private function endGame():Void
	{
		haxe.Timer.delay(function f0() {
			hud.updateHUD("Disabling camera...");
		}, 4000);

		haxe.Timer.delay(function f1() {
			CameraFX.transition(function f() {
				CameraFX.clearFilters();
				remove(player);
				remove(level.platforms);
				remove(bg2);
				SoundPlayer.stopMusic();
			});
		},5000);

		haxe.Timer.delay(function f2() {
			hud.updateHUD("Transmission sent...");
		},12000);

		haxe.Timer.delay(function f3() {hud.updateHUD("Transmission received.");}, 17000);	
	}

	private function triggerEvent(P:Player, E):Void
	{
		if (Std.is(E, HUDEvent)) {
			E.trigger(hud);
		} else if (Std.is(E, SpecialEvent) && !E.flag) {
			switch E.eventid {
				case "disableJetpack": {
					hud.updateHUD("CRITICAL: Disabling enhanced propulsion to conserve power.");
					player.jetpack = false;
					player.exhaust.disable();
				}
				case "disableBoi": {
					hud.updateHUD("CRITICAL: Disabling B.O.I. to conserve power.");
					player.boi.mode = 3;
				}
				case "disableDrill": {
					hud.updateHUD("WARNING: Disabling drill functionality to conserve power.");
					player.boi.mode = 2;
				}
				case "irCamera": {
					CameraFX.clearFilters();
					hud.updateHUD("WARNING: Switching to IR camera to conserve power.");
					CameraFX.addFilter(CameraFX.red);
				}
				case "disappearBoi": {
					player.boi.mode = 5;
				}
				case "blurCamera": {
					hud.updateHUD("CRITICAL: Camera Losing Power.");
					CameraFX.clearFilters();
					CameraFX.addFilter(CameraFX.blur);
					CameraFX.addFilter(CameraFX.red);
				}
				case "grayCamera": {
					hud.updateHUD("WARNING: Power Supply Extremely Low.");
					CameraFX.clearFilters();
					CameraFX.addFilter(CameraFX.blur);
					CameraFX.addFilter(CameraFX.gray);
				}
				case "endGame": {
					endGame();
				}
				default: "Invalid event triggered.";
			}
			E.flag = true;
		}
	}
}
