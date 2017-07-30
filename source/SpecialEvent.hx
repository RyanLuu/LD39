package;

import flixel.FlxSprite;

class SpecialEvent extends FlxSprite
{
	public var id:String;
	public function new(X:Float=0, Y:Float=0, id:String)
	{
		super(X, Y);
		width = 16;
		height = 480;
		this.id = id;
	}

	public static function trigger(id:String) {
		switch id {
			default: trace("Invalid SpecialEvent triggered.");
		}

	}
}