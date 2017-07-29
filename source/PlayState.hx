package;

import flixel.FlxState;

class PlayState extends FlxState
{

	private var player:Player;
	private var hud:HUD;


	override public function create():Void
	{
		super.create();

		player = new Player();
		hud = new HUD();

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	public function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
	}
}
