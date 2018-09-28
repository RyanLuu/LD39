package;

import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.FlxG;

class Level
{
    public var current:Int;

	private var loader:FlxOgmoLoader;
    public var platforms:FlxTilemap;

    public var spawn:FlxPoint;
    public var grpTeleporter:FlxGroup;
    public var hazards:FlxGroup;
    public var boulders:FlxGroup;
    public var events:FlxGroup;
    public var jetpackEnabled:Bool;

    public function new(map:Int=0)
	{
        this.current = map;
        spawn = new FlxPoint();
        load();
    }

    public function load():Void
    {
        loader = new FlxOgmoLoader(getMapPath(current));
        this.grpTeleporter = new FlxGroup();
        this.hazards = new FlxGroup();
        this.boulders = new FlxGroup();
        this.events = new FlxGroup();
        this.platforms = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
        loader.loadEntities(placeEntities, "entities");
        this.jetpackEnabled = loader.getProperty("jetpackEnabled") == "True";
        platforms.follow();
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

        if (entityName == "hudEvent")
        {
            var message:String = entityData.get("message");
            events.add(new HUDEvent(x, y, message));
        }

        if (entityName == "specialEvent")
        {
            var id:String = entityData.get("eventid");
            var width:Int = Std.parseInt(entityData.get("width"));
            var height:Int = Std.parseInt(entityData.get("height"));
            events.add(new SpecialEvent(x, y, width, height, id));
            
        }
	}

    private function getMapPath(i:Int):String
    {
        return "assets/data/level" + i + ".oel";
    }
}