package  
{
	import flash.utils.Timer;
	import LevelState;
	import images.*;
	import sounds.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class LevelState extends FlxState 
	{
		//{ variables
		[Embed(source = "/images/levelBG.png")]
		public var _levelBGIMG:Class;
		private var level1Button:FlxButtonPlus;
		private var level2Button:FlxButtonPlus;
		private var level3Button:FlxButtonPlus;
	
		//}end variables
		//{ level selection
		
		override public function  create():void 
		{
			FlxG.camera.stopFX();
			FlxG.camera.flash(0xff000000, 2);
			var bg:FlxSprite = new FlxSprite(0, 0, _levelBGIMG);
			add(bg);
			FlxG.mouse.show();
			var txt:FlxText
			txt = new FlxText(0, FlxG.height - 450, FlxG.width, "Select a level.")
			txt.setFormat(null, 15, 0xFFFFFFFF, "center");
			this.add(txt);
			//{ level buttons
			level1Button = new FlxButtonPlus(100, 100, startLevel1, null, "I", 100, 25);
			add(level1Button);
			level2Button = new FlxButtonPlus(205, 100, startLevel2, null, "II", 100, 25);
			add(level2Button);
			level3Button = new FlxButtonPlus(310, 100, startLevel3, null, "III", 100, 25);
			add(level3Button);
			level2Button.active = false;
			level3Button.active = false;
			if (LevelsCompleted.levels >= 1)
			{
				level2Button.active = true;
			}
			if (LevelsCompleted.levels >= 2)
			{
				level3Button.active = true;
			}
			//} end level buttons
		}
		//} end level selection
		//{ button funtions
		
		private function  startLevel1():void 
		{
			FlxG.mouse.hide();
			FlxG.switchState(new PlayState);
		}
		private function  startLevel2():void 
		{
			FlxG.mouse.hide();
			FlxG.switchState(new Level2State);
		}
		private function startLevel3():void 
		{
			
		}
		//} end button functions
	}	
}