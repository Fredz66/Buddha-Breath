package;

import flixel.FlxGame;
import openfl.display.Sprite;
import gui.MenuState;

class Main extends Sprite
{
    public static var level:Int = 1;
	public static var pad:VirtualPad;

    public function new()
    {
        super();
        addChild(new FlxGame(1920, 1080, MenuState, 1, 60, 60, true, true));
    }
}