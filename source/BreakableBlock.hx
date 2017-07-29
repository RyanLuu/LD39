package;



class BreakableBlock extends FlxSprite
{

    var hitCount = 3;

    public function new(X?:Float, Y?:Float):Void
    {
        super(X,Y);
        width = 16;
        height = 16;
    }

    public function smash(){
        hitCount--;
        if(hitCount <= 0)
        {
            width = 0;
            height = 0;
            //change image or something idk
        }
    }

}