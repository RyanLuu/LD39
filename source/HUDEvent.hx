package;

import flixel.FlxSprite;

class HUDEvent extends FlxSprite
{
	public var message:String;
	public var flag:Bool;
	public function new(X:Float=0, Y:Float=0, message:String)
	{
		super(X, Y);
		width = 16;
		height = 480;
		this.message = message;
		this.flag = false;
	}

	public function trigger(hud:HUD)
	{
		if (!this.flag) {
			this.flag = true;
			hud.updateHUD(message);
		}
	}
}