package;

import flixel.FlxGame;
import openfl.display.Sprite;
import gui.MenuState;

class Main extends Sprite
{
    public static var scale:Int;
    public static var level:Int = 1;
	public static var pad:VirtualPad;
    public static var version:String = "v1.3.0-alpha";

    public function new()
    {
        super();

        var max = Math.max(openfl.system.Capabilities.screenResolutionX, openfl.system.Capabilities.screenResolutionY);

        //max = 1920;
        //max = 640;

        switch (max) {
            case 640: {
                scale = 1;
                addChild(new FlxGame(640, 360, MenuState, 1, 60, 60, true, true));
            }
            default: {
                scale = 3;
                addChild(new FlxGame(1920, 1080, MenuState, 1, 60, 60, true, true));
            }
        }
    }
}