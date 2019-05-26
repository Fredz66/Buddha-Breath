package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var background:FlxBackdrop;
	var map:FlxTilemap;
	var player:Player;

	var tiles:Array<String> = [
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                                                                                                                                  ',
		'                 X                      XX                                                                                        ',
		'              X  X    X    X   XXXX      X                                                                                        ',
		'XXXXXXXXXXXXXXX  X    X    X    XX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
		'XXXXXXXXXXXXXXX  X    X    X    XX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
		'XXXXXXXXXXXXXXX  X    X    X    XX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
		'XXXXXXXXXXXXXXX  X    X    X    XX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
	];

	/*
	 * Convert array of string to array of int for tilemaps.
	**/
	public function StringsToMapData(strings:Array<String>):Array<Int> {
		var mapData:Array<Int> = [];

		for (row in strings) {
			for (i in 0...row.length) {
				switch row.charAt(i) {
					case ' ': mapData.push(0);
					case 'X': mapData.push(1);
					case '-': mapData.push(2);
					default:  mapData.push(0);
				}
			}
		}

		return mapData;
	}

	override public function create():Void
	{
		super.create();

		// Load background.
		background = new FlxBackdrop("assets/images/640.png");
		background.scrollFactor.x = 1;
		background.offset.y = -24;
		add(background);

		// Load map but don't show it.
		map = new FlxTilemap();
		map.loadMapFromArray(StringsToMapData(tiles), 130, 12, AssetPaths.tilesProto2__png, 32, 32);
		add(map);
		//map.visible = false;

		// Load player.
		player = new Player();
		add(player);

		// Camera follows the player, map follows the camera.
		FlxG.camera.follow(player, LOCKON, 1);
		map.follow();

		// Hide mouse cursor.
		FlxG.mouse.visible = false;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Toggle map visibility with H key.
		if (FlxG.keys.justPressed.H) {
			map.visible = !map.visible;
		}

		// Collision detection between the player and the map.
		FlxG.collide(player, map);

		// Detects fall and death.
		if (player.y > FlxG.height) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, death);
		}

		// Detects end of level.
		if (player.x > map.width) {
			FlxG.camera.fade(FlxColor.BLACK, .33, false, win);
		}

		//FlxG.debugger.visible = true;
		//FlxG.debugger.drawDebug = true;
	}

	function death():Void
	{
		FlxG.switchState(new GameOverState());
	}

	function win():Void
	{
		FlxG.switchState(new WinState());
	}
}