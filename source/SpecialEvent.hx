package;

import flixel.FlxSprite;

class SpecialEvent extends FlxSprite
{
	public var eventid:String;
	private var flag:Bool;

	public function new(X:Float=0, Y:Float=0, eventid:String)
	{
		super(X, Y);
		width = 16;
		height = 480;
		this.eventid = eventid;
		this.flag = false;
	}

	public function raiseFlag()
	{
		flag = true;
	}

	public function flagged():Bool
	{
		return flag;
	}
}