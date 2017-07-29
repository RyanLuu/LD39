package;

 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxGroup.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 using flixel.util.FlxSpriteUtil;

 class HUD extends FlxTypedGroup<FlxSprite>
 {
     private var back:FlxSprite;
     private var textMessage:FlxText;
     private var count = 0.0;
     private var out = "";
     private var text = "";

     public function new()
     {
         super();
         back = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
         back.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);
         textMessage = new FlxText(0, 2, 0, "", 8);
         textMessage.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
         textMessage.alignment = RIGHT;
         textMessage.x = textMessage.width - 4;
         add(back);
         add(textMessage);
         forEach(function(spr:FlxSprite)
         {
             spr.scrollFactor.set(0, 0);
         });
     }

     public function updateHUD(message:String = ""):Void
     {
         text = message;
         textMessage.x = 1;
     }

     override public function update(elapsed:Float):Void
     {
        count = count + 0.1;
        textMessage.text = text.substring(0, Std.int(count));
     }
 }