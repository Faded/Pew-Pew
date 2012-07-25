package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class Asteroid extends FlxSprite 
	{
		[Embed(source = "/images/asteroid.png")]
		private var _asteroid:Class;
		
		public function Asteroid(x: Number, y: Number):void
		{
			super(x, y, _asteroid);
			velocity.x = -400;
		}
		
		override public function  update():void 
		{
			velocity.y = Math.cos(x / 50) * 50;
			super.update();
		}
		
	}
}