package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Faded
	 */
	public class StarField extends FlxGroup
	{
		public static const NUM_STARS:Number = 75;
		private var angle:Number;
		public function StarField(ang:Number = 90, speedMultiplier:Number = 4):void
		{
			super();
 
			angle = ang;
 
			var radang:Number = ang * Math.PI / 180;
			var cosang:Number = Math.cos(radang);
			var sinang:Number = Math.sin(radang);
 
			for (var i:int = 0; i < StarField.NUM_STARS; i++)
			{
				var str:FlxSprite = new FlxSprite(Math.random() * FlxG.width, Math.random() * FlxG.height);
				var vel:Number = Math.random() * -16 * speedMultiplier;

				var transp:uint = (Math.round(16 * (-vel / speedMultiplier) - 1) << 24);
 
				str.makeGraphic(2, 2, 0x00ffffff | transp);
				str.velocity.y = cosang * vel;
				str.velocity.x = sinang * vel;
				add(str);
			}
		}
		
		public function rotate(howMuch:Number = 1):void
		{
			angle += howMuch;
 
			var radang:Number = angle * Math.PI / 180;
			var cosang:Number = Math.cos(radang);
			var sinang:Number = Math.sin(radang);
 
			for each (var star:FlxSprite in members)
			{
				FlxU.rotatePoint(star.velocity.x, star.velocity.y, 0, 0, howMuch, star.velocity);
			}
		}
 
		override public function update():void
		{
			super.update();
 
			for each (var star:FlxSprite in members)
			{
				if (star.x > FlxG.width)
				{
					star.x = 0;
				}
				else if (star.x < 0)
				{
					star.x = FlxG.width;
				}
 
				if (star.y > FlxG.height)
				{
					star.y = 0;
				}
				else if (star.y < 0)
				{
					star.y = FlxG.height;
				}
			}
		}
	}
}