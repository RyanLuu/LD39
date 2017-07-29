package;

import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.math.FlxPoint;
import flixel.FlxSprite;

class PlayState extends FlxState
{

	private var player:Player;
	private var hud:HUD;
	private var fx:FX;

	private var map:FlxOgmoLoader;
	private var platforms:FlxTilemap;
	private var grpTeleporter:FlxGroup;
	private var grpMaps = [AssetPaths.TestingGrounds__oel, AssetPaths.TeleTesting__oel];
	private var currentMap = 0;
	private var hazards:FlxGroup;


	override public function create():Void
	{
		super.create();

		FlxG.fixedTimestep = false;
		FlxG.mouse.useSystemCursor = true;

		map = new FlxOgmoLoader(AssetPaths.TestingGrounds__oel);
		grpTeleporter = new FlxGroup();
		platforms = map.loadTilemap(AssetPaths.tiles__png, 16, 16, "platforms");
		platforms.follow();
		platforms.setTileProperties(0, FlxObject.ANY);
		platforms.setTileProperties(1, FlxObject.NONE);


		player = new Player();
		map.loadEntities(placeEntities, "entities");
		hud = new HUD();

		add(platforms);
		add(player);
		player.enableDrill(this);

		setupCamera(player);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(player, platforms);
		FlxG.overlap(player, grpTeleporter, playerTouchedTele);
		FlxG.overlap(player, hazards, playerHitHazard);

	}

	private function setupCamera(player:Player):Void
	{
		FlxG.camera.follow(player, TOPDOWN, 1);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		if (entityName == "player")
		{
			player.x = x;
			player.y = y;
		}

		if (entityName == "teleport")
		{
			grpTeleporter.add(new Teleportation(x,y));
		}

		if (entityName == "hazard")
		{
			hazards.add(new Hazard(x,y));
		}
	}
	private function playerTouchedTele(P:Player, T:Teleportation):Void
	{
		if (P.alive && P.exists)//wat no maney? sack a cack!
		{
			remove(platforms);
			map = new FlxOgmoLoader(grpMaps[currentMap + 1]);
			platforms = map.loadTilemap(AssetPaths.tiles__png, 16, 16, "platforms");
			platforms.setTileProperties(0, FlxObject.ANY);
			platforms.setTileProperties(1, FlxObject.NONE);
			add(platforms);

			var transitionIn = new FlxSprite(320,120,AssetPaths.transition_in__png);
			FlxTween.tween(transitionIn, {x: transitionIn.x - 320 }, .33);
			add(transitionIn);
		}
	}

	private function playerHitHazard(player:Player, hazard:Hazard):Void
	{
		//player takes damage
		trace("ur mum");
	}
}
