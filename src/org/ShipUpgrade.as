package org 
{
	import images.*;
	import org.flixel.*;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class ShipUpgrade extends FlxSprite
	{
		[Embed(source = "/images/ShipUpgrade.png")]
		private var _imgShipUp:Class;
		
		public function ShipUpgrade():void
		{
			super(50, 50, _imgShipUp);
		}
		
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.keys.LEFT)
			{
				velocity.x = -300;
			}
			else if (FlxG.keys.RIGHT)
			{
				velocity.x = 300;
			}
			
			if (FlxG.keys.UP)
			{
				velocity.y = -300;
			}
			else if (FlxG.keys.DOWN)
			{
				velocity.y = 300;
			}
			super.update();
			
			if (x > FlxG.width - width - 16)
			{
				x = FlxG.width - width - 16;
			}
			else if (x < 16)
			{
				x = 16;
			}
			
			if (y > FlxG.height - height - 16)
			{
				y = FlxG.height - height - 16;
			}
			else if (y < 48)
			{
				y = 48;
			}
		}
		
		public function getBulletSpawnPosition():FlxPoint 
		{
			var p:FlxPoint = new FlxPoint(x + 36, y + 12);
			return p;
		}
	}	
}