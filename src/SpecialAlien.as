package  
{
	import adobe.utils.CustomActions;
	import flash.display.NativeMenu;
	import flash.geom.Point;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Faded
	 */
	public class SpecialAlien extends FlxSprite
	{
		[Embed(source = "/images/SpecialAlien.png")]
		private var _imgSpecialAlien:Class;
		/*
		private var fireTime:FlxDelay;
		private var willFire:Boolean = false;
		
		public function SpecialAlien(x:Number, y:Number):void
		{
			super(x, y, _imgSpecialAlien);
			
			//exists = false;
		}
		
		public function launch():void
		{
			x = 64 + int(Math.random() * (FlxG.width - 128));
			y = -16;
			velocity.x = -50 + int(Math.random() * 100);
			velocity.y = 50;
			
			//	Will they shoot at the player? 70% chance of doing so
			if (FlxMath.chanceRoll(70))
			{
				willFire = true;
				fireTime = new FlxDelay(1000 + int(Math.random() * 500));
				fireTime.start();
			}
			
			health = 4;
			exists = true;
		}
		
		
		override public function update():void
		{
			
			super.update();
			
			if (willFire && fireTime.hasExpired)
			{
				Registry.enemyBullets.fire(x, y);
				willFire = false;
			}
			
			if (y > FlxG.height)
			{
				exists = false;
			}
		}
		
		public function getPowerupSpawnPosition():FlxPoint
		{
			var powerupPos: FlxPoint = new FlxPoint(x, y);
			return powerupPos;
		}
		
	}
		*/
		private var lastReleased:int;
		private var releaseRate:int = 500;
		private var fireTime:FlxDelay;
		private var willFire:Boolean = false;
		private var _myalien:SpecialAlien;
		
		public function SpecialAlien(x:Number, y:Number):void
		{
				super(x, y, _imgSpecialAlien);
				velocity.x = -800;
		}
		
		public function launch():void
		{
			x = 64 + int(Math.random() * (FlxG.width - 128));
			y = -16;
			velocity.x = -50 + int(Math.random() * 100);
			velocity.y = 50;
			
			//	Will they shoot at the player? 70% chance of doing so
			if (FlxMath.chanceRoll(100))
			{
				willFire = true;
				fireTime = new FlxDelay(1000 + int(Math.random() * 500));
				fireTime.start();
			}
			
			health = 4;
			exists = true;
		}
		
		override public function update():void
		{
			velocity.y = Math.cos(x / 50) * 50;
			super.update();
			
			if (willFire && fireTime.hasExpired)
			{
				Registry.enemyBullets.fire(x, y);
				willFire = false;
			}
			
			
			if (y > FlxG.height)
			{
				exists = false;
			}
		}
		
		public function getPowerupSpawnPosition():FlxPoint
		{
			var powerupPos: FlxPoint = new FlxPoint(x, y);
			return powerupPos;
		}
	}
}