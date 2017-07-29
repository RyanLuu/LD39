package;

import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup;


class PlayState extends FlxState
{

	private var player:Player;
	private var hud:HUD;

	private var map:FlxOgmoLoader;
	private var platforms:FlxTilemap;
	private var grpTeleporter:FlxGroup;
	private var grpMaps = [AssetPaths.TestingGrounds__oel, AssetPaths.TeleTesting__oel];
	private var currentMap = 0;


	override public function create():Void
	{
		super.create();

		map = new FlxOgmoLoader(AssetPaths.TestingGrounds__oel);
		platforms = map.loadTilemap(AssetPaths.tiles__png, 16, 16, "platforms");
		platforms.setTileProperties(0, FlxObject.ANY);
		platforms.setTileProperties(1, FlxObject.NONE);

		map.loadEntities(placeEntities, "entities");

		player = new Player();
		hud = new HUD();

		add(platforms);
		add(player);

		setupCamera(player);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(player, platforms);
		FlxG.overlap(player, grpTeleporter, playerTouchedTele);

	}

	public function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
	}

	private function placeEntities(entityName:String, entityData:Xml)
	{
		var x:Float = Std.parseInt(entityData.get("x"));
		var y:Float = Std.parseInt(entityData.get("y"));

		if (entityName == "player")
		{
			player.x = x;
			player.y - y;
		}

		if (entityName == "teleport")
		{
			grpTeleporter.add(new Teleportation(x,y));
		}
	}
	private function playerTouchedTele(P:Player, T:Teleportation):Void
	{
		if (P.alive && P.exists)
		{
			map = new FlxOgmoLoader(grpMaps[currentMap + 1]);
			platforms = map.loadTilemap(AssetPaths.tiles__png, 16, 16, "platforms");
			platforms.setTileProperties(0, FlxObject.ANY);
			platforms.setTileProperties(1, FlxObject.NONE);
		}
	}
}
