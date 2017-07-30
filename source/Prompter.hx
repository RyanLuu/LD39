import flixel.FlxG;

class Prompter
{
    var player:Player;
    var hud:HUD;

    var prompts = [new Prompt(0, "prompter test")];


    public function new(p:Player,h:HUD)
    {
        player = p;
        hud = h;
    }

    public function update():Void
    {
        for(prompt in prompts){
            if(player.x > prompt.x){
                prompt.play(hud);
                prompts.remove(prompt);
            }
        }
    }
}


private class Prompt
{
    public var x:Int;
    var msg:String;

    public function new(x:Int,message:String)
    {
        this.x = x;
        msg = message;
    }

    public function play(hud:HUD):Void
    {
        hud.updateHUD(">"+msg);
    }
}