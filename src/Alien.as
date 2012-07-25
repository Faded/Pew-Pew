package  
{
	import adobe.utils.CustomActions;
	import flash.display.NativeMenu;
	import org.flixel.*;
 
	import Explode;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class Alien extends FlxSprite
	{
		//{ vars
		[Embed(source = "/images/Alien.png")]
		private var _imgAlien:Class;
		//} end vars
		//{ spawn alien
		public function Alien(x: Number, y:Number):void
		{
			super(x, y, _imgAlien);
			velocity.x = -250;
		}		
		//} end spawn
		//{ alien actions/speed
		override public function update():void
		{
			velocity.y = Math.cos(x / 50) * 50;
			super.update();
		}
		//} end alien actions
		//{ alien powerup drops
		public function getPowerupSpawnPosition():FlxPoint
		{
			var powerupPos: FlxPoint = new FlxPoint(x, y);
			return powerupPos;
		}
		//} end powerup drops
		

		
	}
}