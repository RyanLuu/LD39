package;


import flixel.addons.ui.FlxInputText;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class HUD extends FlxSpriteGroup
{

    private var tipsBox:FlxInputText;
    private var message:String;


    public function new():Void
    {
        super();

        message = new String("doods");
        tipsBox = new FlxInputText(100,100,150,message,18,255,0,true);

        add(tipsBox);

    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }


}