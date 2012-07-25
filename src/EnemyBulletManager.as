package  
{
	import org.flixel.*;

	public class EnemyBulletManager extends FlxGroup
	{
		private var _enemyBullet:EnemyBullet;
		
		public function EnemyBulletManager(x:Number, y:Number) 
		{
			super();
			
			_enemyBullet.scrollFactor.x = 0;
			_enemyBullet.scrollFactor.y = 0;
			
			//	There are 40 enemy bullets in our pool
			for (var i:int = 0; i < 40; i++)
			{
				add(_enemyBullet);
			}
		}
		
		public function fire(bx:int, by:int):void
		{
			if (getFirstAvailable())
			{
				EnemyBullet(getFirstAvailable()).fire(bx, by);
			}
			
		}
		
	}

}