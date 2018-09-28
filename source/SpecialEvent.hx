package;

import flixel.FlxSprite;

class SpecialEvent extends FlxSprite
{
	public var eventid:String;
	public var flag:Bool;

	public function new(X:Float=0, Y:Float=0, ?width=16, ?height=480, eventid:String)
	{
		super(X, Y);
		this.width = width;
		this.height = height;
		this.eventid = eventid;
		flag = false;
	}

	public function trigger()
	{
		flag = true;
	}
}