package;

import flixel.FlxSprite;

class HUDEvent extends FlxSprite
{
	public var message:String;
	public function new(X:Float=0, Y:Float=0, message:String)
	{
		super(X,Y);
		width = 16;
		height = 480;
		this.message = message;
	}
}