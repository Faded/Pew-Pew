package  
{
	import org.flixel.*;
	import images.*;
	import sounds.*;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class Powerup extends FlxSprite 
	{
		//{ vars
		[Embed(source = "/images/powerupone.png")]
		public var _powerupOneIMG:Class;
		[Embed(source = "/images/poweruptwo.png")]
		public var _powerupTwoIMG:Class;
		[Embed(source = "/images/powerupthree.png")]
		public var _powerupThreeIMG:Class;
		[Embed(source = "/images/powerupfour.png")]
		public var _powerupFourIMG:Class;
		/*
		[Embed(source = "/images/powerupfive.png")]
		public var _powerupFiveIMG:Class;
		[Embed(source = "/images/powerupsix.png")]
		public var _powerupSixIMG:Class;
		*/
		public var _powerupIMG:FlxGroup;
		private var randomPowerup:int;
		public var randomPowerupTag:String;
		//} end vars
		
		public function Powerup(x:Number,y:Number):void 
		{
			//{ images and tags
			randomPowerup = FlxG.random() * 4;
			super(x, y);
			if (randomPowerup == 0)
			{
				loadGraphic(_powerupOneIMG);
				velocity.x = -150;
				randomPowerupTag = "PowerupOne";
			}
			if (randomPowerup == 1)
			{
				loadGraphic(_powerupTwoIMG);
				velocity.x = -200;
				randomPowerupTag = "PowerupTwo";
			}
			if (randomPowerup == 2)
			{
				loadGraphic(_powerupThreeIMG);
				velocity.x = -250;
				randomPowerupTag = "PowerupThree";
			}
			if (randomPowerup == 3)
			{
				loadGraphic(_powerupFourIMG);
				velocity.x = -50;
				randomPowerupTag = "PowerupFour";
			}
			/*
			if (randomPowerup == 4)
			{
				loadGraphic(_powerupFiveIMG);
				velocity.x = -50;
				randomPowerupTag = "PowerupFive";
			}
			if (randomPowerup == 5)
			{
				loadGraphic(_powerupSixIMG);
				velocity.x = -50;
				randomPowerupTag = "PowerupSix";
			}
			*/
			//} end images and tags
		}		
		override public function update():void
		{
			if (x < (FlxG.width - FlxG.width) -50)
			{
				kill();
			}
			super.update();
		}
	}
}