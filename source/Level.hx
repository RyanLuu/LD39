package;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;

class Level
{
    private var maps = [AssetPaths.TestingGrounds__oel, AssetPaths.TeleTesting__oel];

	private var loader:FlxOgmoLoader;
    public var platforms:FlxTilemap;

    public var spawn:FlxPoint;
    public var grpTeleporter:FlxGroup;
    public var hazards:FlxGroup;

    public function new(map:Int=0)
	{
        setMap(map);
        platforms.follow();
        spawn = new FlxPoint();
        grpTeleporter = new FlxGroup();
        hazards = new FlxGroup();
        loader.loadEntities(placeEntities, "entities");
    }

    public function setMap(map)
    {
        loader = new FlxOgmoLoader(maps[map]);
        platforms = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "platforms");
		platforms.setTileProperties(0, FlxObject.ANY);
		platforms.setTileProperties(1, FlxObject.NONE);
    }

    private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		if (entityName == "player")
		{
            spawn.set(x, y);
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
}