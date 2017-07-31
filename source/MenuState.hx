package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;


class MenuState extends FlxState
{

    private var playButton:FlxButton;
    private var title:FlxText;
    private var down = true;

    override public function create():Void
	{
		FlxG.fixedTimestep = true;
		FlxG.mouse.useSystemCursor = true;

        playButton = new FlxButton(0, 0, "Play", clickPlay);
        title = new FlxText(80, 50, FlxG.width, "KRONKBOT", 24);
        title.setBorderStyle(SHADOW, FlxColor.GRAY, 4, 1);

        playButton.screenCenter();

		add(new FlxBackdrop(AssetPaths.bg__png, 0.25, 0, true, false));
		add(new FlxBackdrop(AssetPaths.bg1__png, 0.5, 0, true, false));
        add(playButton);
        add(title);

        super.create();
    }
    
    override public function update(elapsed:Float):Void
	{
        super.update(elapsed);

        // if (playButton.y < 130 && down == true) // down
        // {
        //     playButton.y = playButton.y + 0.5;

        //     if (playButton.y == 130) 
        //     {
        //         down = false;
        //     }
        // } 
        // else if (playButton.y > 110 && down == false) // up
        // {
        //     playButton.y = playButton.y - 0.5;

        //     if (playButton.y == 110) 
        //     {
        //         down = true;
        //     }
        // }
    }

    private function clickPlay():Void
    {
        CameraFX.transition(function f() FlxG.switchState(new PlayState()));
    }

}