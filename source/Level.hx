package;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;

class Level
{
    public var current:Int;

	private var loader:FlxOgmoLoader;
    public var platforms:FlxTilemap;

    public var spawn:FlxPoint;
    public var grpTeleporter:FlxGroup;
    public var hazards:FlxGroup;
    public var boulders:FlxGroup;


    public function new(map:Int=0)
	{
        this.current = map;
        spawn = new FlxPoint();
        load();
        platforms.follow();
    }

    public function load():Void
    {
        grpTeleporter = new FlxGroup();
        hazards = new FlxGroup();
        boulders = new FlxGroup();
        loader = new FlxOgmoLoader(getMapPath(current));
        platforms = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
        loader.loadEntities(placeEntities, "entities");
    }

    private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

        if (entityName == "spawn")
        {
            spawn.set(x, y);
        }

		if (entityName == "teleport")
		{
            var to:Int = Std.parseInt(entityData.get("to"));
			grpTeleporter.add(new Teleportation(x,y, to));
		}

		if (entityName == "hazard")
		{
			hazards.add(new Hazard(x,y));
		}

        if (entityName == "boulder")
        {
            boulders.add(new Boulder(x,y));
        }        
	}

    private function getMapPath(i:Int):String
    {
        return "assets/data/level" + i + ".oel";
    }
}