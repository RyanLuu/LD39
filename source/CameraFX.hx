package;

import flixel.FlxCamera;
import flixel.util.FlxColor;
import flash.filters.BlurFilter;
import flash.filters.ColorMatrixFilter;
import flash.filters.BitmapFilter;
import flixel.FlxG;

class CameraFX {

    public static var blur = new BlurFilter();
    public static var gray = new ColorMatrixFilter([.5,.5,.5,0,0,.5,.5,.5,0,0,.5,.5,.5,0,0,0,0,0,1,0]);
    public static var red = new ColorMatrixFilter([3,3,3,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0]);

    private static var filters = [];
    private static var blurry = false;

    public static function fade()
    {
        FlxG.camera.flash(FlxColor.BLACK, 1);
    }

    public static function addFilter(filter:BitmapFilter) {
        filters.push(filter);
        updateFilters();
    }

    private static function updateFilters() {
        FlxG.camera.setFilters(filters);
    }

    public static function clearFilters() {
        filters = [];
        FlxG.camera.setFilters(filters);
    }
}