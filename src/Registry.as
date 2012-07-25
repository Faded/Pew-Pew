package  
{
	import org.flixel.FlxGroup;
	import flash.display.Stage;
	import org.ShipUpgrade;
	import org.Ship;
	
	public class Registry
	{
		public static var player:Ship;
		public static var playerupgrade:ShipUpgrade;
		public static var enemyBullets:EnemyBullet;
		public static var aliens:Alien;
		public static var pinky:SpecialAlien;
		public static var playerbullet:Bullet;
		public static var stars:StarField;
		public static var hud:HUD;
		public static var powerups:Powerup;
		public static var asteroids:Asteroid;
		
		public function Registry() 
		{
			
		}
		
		public static function init(x:Number, y:Number):void
		{
			player = new Ship();
			playerupgrade = new ShipUpgrade();
			pinky = new SpecialAlien(x, y);
			aliens = new Alien(x, y);
			enemyBullets = new EnemyBullet();
			asteroids = new Asteroid(x, y);
			stars = new StarField();
		}
		
		public static function erase():void
		{
			player = null;
			playerupgrade = null;
			//aliens = null;
			enemyBullets = null;
			pinky = null;
			playerbullet = null;
			stars = null;
			hud = null;
			asteroids = null;
			powerups = null;
		}	
	}
}