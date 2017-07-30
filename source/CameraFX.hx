package;

import flixel.FlxCamera;
import flixel.util.FlxColor;
import flash.filters.BlurFilter;
import flixel.FlxG;

class CameraFX {

    private static var filters = [];
    private static var blurry = false;

    public static function fade()
    {
        FlxG.camera.flash(FlxColor.BLACK, 1);
    }

    public static function toggleBlur():Void
    {
        for (filter in filters) {
            if (Std.is(filter, BlurFilter)) {
                filters.remove(filter);
                FlxG.camera.setFilters(filters);
                return;
            }
        }
        var filter = new BlurFilter();
        filters.push(filter);
        FlxG.camera.setFilters(filters);
    }
}