package  
{
	import flash.geom.Point;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxVelocity;

	public class EnemyBullet extends FlxSprite
	{
		[Embed(source = "/images/enemy-bullet.png")] private var bulletPNG:Class;
		
		public var damage:int = 25;
		public var speed:int = 240;
		
		public function EnemyBullet() 
		{
			super(0, 0, bulletPNG);
			
			//	We do this so it's ready for pool allocation straight away
			exists = false;
		}

		public function fire(bx:int, by:int):void
		{
			x = bx;
			y = by;
			
			FlxVelocity.moveTowardsObject(this, Registry.player, speed);
			
			exists = true;
		}
		
		override public function update():void
		{
			super.update();
			
			//	Bullet off the screen?
			if (exists && (y < 0 || y > FlxG.height || x < 0 || x > FlxG.width))
			{
				exists = false;
			}
		}
		
		
	}

}