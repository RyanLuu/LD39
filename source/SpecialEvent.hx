package;

import flixel.FlxSprite;

class SpecialEvent extends FlxSprite
{
	public var eventid:String;

	public function new(X:Float=0, Y:Float=0, eventid:String)
	{
		super(X, Y);
		width = 16;
		height = 480;
		this.eventid = eventid;
	}
}