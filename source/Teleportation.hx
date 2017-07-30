package;

import flixel.FlxSprite;

class Teleportation extends FlxSprite
{
	public var to:Int;
	public function new(X:Float=0, Y:Float=0, to:Int=0)
	{
		super(X,Y);
		width = 16;
		height = 16;
		this.to = to;
	}
}