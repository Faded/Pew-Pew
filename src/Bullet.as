package  
{
	import flash.geom.Point;
	import org.flixel.*;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class Bullet extends FlxSprite 
	{
		//{ vars
		[Embed(source = "/images/bullet.png")]
		public var _bulletIMG:Class;
		[Embed(source = "/images/bullet.png")]
		public var _bullet2IMG:Class;
		[Embed(source = "/images/bullet.png")]
		public var _bullet3IMG:Class;
		private var isWeaponTwo:Boolean;
		//} end vars

		public function Bullet(x:Number,y:Number):void 
		{
			super(x, y);
			//{ powerup actions
			if (PlayState._powerupOneCounter >= 1)
			{
				loadGraphic(_bulletIMG);
				velocity.x = 1000;
			}
			if (PlayState._powerupTwoCounter >= 1)
			{
				loadGraphic(_bullet2IMG);
				velocity.x = 500;
				isWeaponTwo = true;
			}
			if (PlayState._powerupThreeCounter >= 1)
			{
				var shotdirection:Point;
				shotdirection = Point.polar(700, ((FlxG.random() * 70) - 35) * 0.017453);
				velocity.x = shotdirection.x;
				velocity.y = shotdirection.y;
				loadGraphic(_bullet3IMG);
			}
			//} end powerup actions
		}
		override public function  update():void 
		{
			if (isWeaponTwo == true)
			{
				velocity.y = Math.cos(x / FlxG.random() * 50) * 300;
			}
			if (x > FlxG.width + 50)
			{
				kill();
			}
			super.update();
		}
	}
}