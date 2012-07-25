package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Faded
	 */
	public class StarState extends FlxState
	{
		private var starfield:StarField;
}
 
		public function StarState() 
		{
		}
 
		override public function create():void
		{
			starfield = new StarField(90, 4);
 
			add(starfield);
		}
 
		override public function update():void
		{
			super.update();
 
			if (FlxG.mouse.justReleased())
			{
				starfield.rotate(int(Math.random() * 359));
			}
		}
	}