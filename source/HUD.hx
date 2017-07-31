package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

class HUD extends FlxTypedGroup<FlxSprite>
{
    private static var TEXT_SPEED = 0.5;
    private static var CLEAR_AFTER = 10;

    private var back:FlxSprite;
    private var textMessage:FlxText;
    private var count = 0.0;
    private var text = "";
    private var lastScl = 0;

    public function new()
    {
        super();
        back = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.fromInt(0x7F000000));
        back.scale.y = 0;
        back.origin.set(0, 0);
        textMessage = new FlxText(0, 2, FlxG.width, "", 8);
        // textMessage.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
        add(back);
        add(textMessage);
        forEach(function(spr:FlxSprite) spr.scrollFactor.set(0, 0));
    }

    public function updateHUD(message:String = ""):Void
    {
        text = "> " + message;
        count = 0;
        if (text.indexOf("CRITICAL:") == 2) {
            textMessage.color = FlxColor.RED;
        } else if (text.indexOf("WARNING:") == 2) {
            textMessage.color = FlxColor.YELLOW;
        } else if (text.indexOf("Transmission") == 2) {
            textMessage.color = FlxColor.GREEN;
        } else {
            textMessage.color = FlxColor.WHITE;
        }
    }

    override public function update(elapsed:Float):Void
    {
        if (text.length > 0) {
            count = count + TEXT_SPEED;
        }
        textMessage.text = text.substring(0, Std.int(count));
        if (count > text.length + CLEAR_AFTER)
        {
            text = "";
        }

        var scl = if (textMessage.text.length > 0) textMessage.text.split("\n").length else 0;
        if (scl != lastScl) {
            lastScl = scl;
            FlxTween.tween(back.scale, {y: scl}, 0.2);
        }
    }
}