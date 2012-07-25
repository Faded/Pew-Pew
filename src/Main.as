package 
{
	import org.flixel.*;
	/**
	 * @author Faded
	 */
	
	 [SWF(width = "640", "480", backgroundColor = "#000000")]
	 [Frame(factoryClass = "Preloader")]
	 public class Main extends FlxGame
	{
		public function Main():void 
		{
			super(640, 480, MenuState, 1);
			LevelsCompleted.load();
		}
	} 
}