import flixel.FlxG;

class Prompter
{
    var player:Player;
    var hud:HUD;

    var tutorialPrompts = [new Prompt(0, "prompter test")];


    public function new(p:Player,h:HUD)
    {
        player = p;
        hud = h;
    }

    public function update(lvl:Int):Void
    {
        if(lvl == 0) checkPrompts(tutorialPrompts);
    }

    public function checkPrompts(prompts:Array<Prompt>)
    {
        for(prompt in prompts){
            if(player.x > prompt.x && !prompt.delivered){
                prompt.play(hud);
            }
        }
    }
}


private class Prompt
{
    public var x:Int;
    public var delivered:Bool;
    var msg:String;

    public function new(x:Int,message:String)
    {
        this.x = x;
        msg = message;
        delivered = false;
    }

    public function play(hud:HUD):Void
    {
        delivered = true;
        hud.updateHUD(">"+msg);
    }
}