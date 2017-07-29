package;

import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;


class PlayState extends FlxState
{

	private var player:Player;
	private var hud:HUD;

	private var map:FlxOgmoLoader;
	private var platforms:FlxTilemap;


	override public function create():Void
	{
		super.create();

		player = new Player();
		hud = new HUD();

		map = new FlxOgmoLoader(AssetPaths.TestingGrounds__oel);
		platforms = map.loadTilemap(AssetPaths.tiles__png, 16, 16, "platforms");
		platforms.setTileProperties(1, FlxObject.ANY);
		platforms.setTileProperties(0, FlxObject.NONE);
		
		add(platforms);
		add(player);

		setupCamera(player);

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
