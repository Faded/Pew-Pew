package  
{
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Faded
	 */
	public class Explode extends FlxSprite
	{
		[Embed(source = "/images/explosion.png")]
		public var ANIMATION:Class;
		private var boomSpot:FlxPoint; 
		
		public function Explode(X:Number, Y:Number) 
		{
			super(X,Y);
			loadGraphic(ANIMATION, true, false, 64, 64);
			addAnimation("Explode", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25], 50, false);
			play("Explode");
		}
		override public function update():void 
		{
			super.update();
		}

	}
}