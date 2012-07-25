package  
{
	import flash.display.MovieClip;
	import PlayState;
	import images.*;
	import sounds.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import flash.events.AsyncErrorEvent;
	import flash.net.NetConnection; 
    import flash.net.NetStream; 
    import flash.events.NetStatusEvent; 
    import flash.media.Video; 
	/**
	 * ...
	 * @author Faded
	 */
	
	public class MenuState extends FlxState 
	{
		//{ variables
		[Embed(source = "/images/enter.png")]
		public var _enterIMG:Class;
		[Embed(source = "/sounds/sadistic.mp3")]
		public var SoundRisky:Class;
		[Embed(source = "/images/menutitle.png")]
		public var _titleIMG:Class;
		[Embed(source = "/sounds/button.mp3")]
		public var buttonSound:Class;
		private var startButton:FlxButtonPlus;
		private var optionsButton:FlxButtonPlus;
		private var aboutButton:FlxButtonPlus;
	
		//}end variables
		//{ menu screen
		
		override public function  create():void 
		{
			FlxG.camera.stopFX();
			FlxG.camera.flash(0xff000000, 1);

			var txt:FlxText
			txt = new FlxText(0, (FlxG.width / 2) - 320, FlxG.width)
			txt.loadGraphic(_titleIMG);
			this.add(txt);
			FlxG.mouse.show();
			startButton = new FlxButtonPlus(265, 260, startGame, null, "Start");
			add(startButton);
			/*
			optionsButton = new FlxButtonPlus(265, 282, optionsScreen, null, "Options");
			add(optionsButton);
			aboutButton = new FlxButtonPlus(265, 304, aboutLink, null, "About");
			add(aboutButton);*/
			//txt = new FlxText(0, FlxG.height - 150, FlxG.width, "Use Arrow keys to move and X to shoot.")
			//txt.setFormat(null, 10, 0xFFFFFFFF, "center");
			//this.add(txt);
			FlxG.playMusic(SoundRisky);
			//optionsButton.active = false;
			//aboutButton.active = false;
		}
		//} end menu screen
		//{ button funtions

		
		private function  startGame():void 
		{
			FlxG.mouse.hide();
			FlxG.camera.fade(0xff000000, 2);
			FlxG.switchState(new LevelState);
		}
		/*
		private function optionsScreen():void
		{

		}
		
		private function aboutLink():void
		{
			
		}
		*/
		//} end button functions
	}	
}