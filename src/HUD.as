package  
{
	import images.*;
	import sounds.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class HUD extends FlxGroup
	{
		private var barHealth:FlxSprite;
		private var barShield:FlxSprite;
		private var powerupHUD:FlxSprite;
		private var powerupHUD2:FlxSprite;
		private var powerupHUD3:FlxSprite;
		public static var _playerArmor:Number = 10;
		public static var _playerShield:Number = 10;
		
		public function HUD():void
		{
			_playerArmor = 10;
			_playerShield = 10;
			
			//{ armor
			var frameHealth:FlxSprite = new FlxSprite(490, 10);
			frameHealth.makeGraphic(106, 30, 0xFFFFFFFF);
			frameHealth.scrollFactor.x = frameHealth.scrollFactor.y = 0;
			add(frameHealth);
			
			var insideHealth:FlxSprite = new FlxSprite(493, 12);
			insideHealth.makeGraphic(100, 26, 0xFF000000);
			insideHealth.scrollFactor.x = insideHealth.scrollFactor.y = 0;
			add(insideHealth);
			
			barHealth = new FlxSprite(493, 12);
			barHealth.makeGraphic(1, 26, 0xFFFF2020);
			barHealth.scrollFactor.x = barHealth.scrollFactor.y = 0;
			barHealth.origin.x = barHealth.origin.y = 0;
			barHealth.scale.x = 100;
			add(barHealth);

			var healthText:FlxText = new FlxText(430, 12, 150, "Armor");
			healthText.setFormat(null, 20, 0xFFFFFFFF, "right");
			healthText.scrollFactor.x = healthText.scrollFactor.y = 0;
			add(healthText);
			//} end armor			
			//{ shield
			var frameShield:FlxSprite = new FlxSprite(360, 10);
			frameShield.makeGraphic(106, 30, 0xFFFFFFFF);
			frameShield.scrollFactor.x = frameShield.scrollFactor.y = 0;
			add(frameShield);
			
			var insideShield:FlxSprite = new FlxSprite(363, 12);
			insideShield.makeGraphic(100, 26, 0xFF000000);
			insideShield.scrollFactor.x = insideShield.scrollFactor.y = 0;
			add(insideShield);
			
			barShield = new FlxSprite(363, 12);
			barShield.makeGraphic(1, 26, 0xFF3030FF);
			barShield.scrollFactor.x = barShield.scrollFactor.y = 0;
			barShield.origin.x = barShield.origin.y = 0;
			barShield.scale.x = 100;
			add(barShield);
			
			var ShieldText:FlxText = new FlxText(300, 12, 150, "Shield");
			ShieldText.setFormat(null, 20, 0xFFFFFFFF, "right");
			ShieldText.scrollFactor.x = ShieldText.scrollFactor.y = 0;
			add(ShieldText);
			//} end shield
			//{ power
			var framePowerup:FlxSprite = new FlxSprite(250, 10);
			framePowerup.makeGraphic(83, 30, 0xFFFFFFFF);
			framePowerup.scrollFactor.x = framePowerup.scrollFactor.y = 0;
			add(framePowerup);
			
			var insidePowerup:FlxSprite = new FlxSprite(253, 12);
			insidePowerup.makeGraphic(77, 26, 0xFF000000);
			insidePowerup.scrollFactor.x = insidePowerup.scrollFactor.y = 0;
			add(insidePowerup);
			
			powerupHUD = new FlxSprite(253, 13);
			powerupHUD.makeGraphic(24, 24);
			powerupHUD.scrollFactor.x = powerupHUD.scrollFactor.y = 0;
			add(powerupHUD);
			
			powerupHUD2 = new FlxSprite(253, 13);
			powerupHUD2.makeGraphic(24, 24);
			powerupHUD2.scrollFactor.x = powerupHUD2.scrollFactor.y = 0;
			powerupHUD2.visible = false;
			add(powerupHUD2);
			
			powerupHUD3 = new FlxSprite(253, 13);
			powerupHUD3.makeGraphic(24, 24);
			powerupHUD3.scrollFactor.x = powerupHUD3.scrollFactor.y = 0;
			powerupHUD3.visible = false;
			add(powerupHUD3);
			
			var powerupHUDText:FlxText = new FlxText(215, 13, 150, "Power");
			powerupHUDText.setFormat(null, 18, 0xFFFFFFFF, "center");
			powerupHUDText.scrollFactor.x = powerupHUDText.scrollFactor.y = 0
			add(powerupHUDText);
			//} power
			//{ score
			FlxG.score = 0;
			PlayState._scoreText = new FlxText(150, 7, 200, "0");
			PlayState._scoreText.setFormat(null, 32, 0xFF597137, "right");
			PlayState._scoreText.scrollFactor.x = PlayState._scoreText.scrollFactor.y = 0
			
			var scoreText:FlxText = new FlxText(0, 15, 150, "Score");
			scoreText.setFormat(null, 20, 0xFFff0000, "left");
			scoreText.scrollFactor.x = scoreText.scrollFactor.y = 0
			add(scoreText);
			//} score
		}
		override public function update():void
		{
			barHealth.scale.x = _playerArmor * 10;
			barShield.scale.x = _playerShield * 10;
			//{ powerup counters
			if (PlayState._powerupOneCounter == 1)
			{
				powerupHUD.color = 0xFF0000;
				powerupHUD.visible = true;
				powerupHUD2.color = 0xFF0000;
				powerupHUD2.visible = false;
				powerupHUD3.color = 0xFF0000;
				powerupHUD3.visible = false;
			}
			if (PlayState._powerupOneCounter == 2)
			{
				powerupHUD.color = 0xFF0000;
				powerupHUD.visible = true;
				powerupHUD2.color = 0xFF0000;
				powerupHUD2.visible = true;
				powerupHUD3.color = 0xFF0000;
				powerupHUD3.visible = false;
			}
			if (PlayState._powerupOneCounter == 3)
			{
				powerupHUD.color = 0xFF0000;
				powerupHUD.visible = true;
				powerupHUD2.color = 0xFF0000;
				powerupHUD2.visible = true;
				powerupHUD3.color = 0xFF0000;
				powerupHUD3.visible = true;
			}
			if (PlayState._powerupTwoCounter == 1)
			{
				powerupHUD.color = 0x00FF00;
				powerupHUD.visible = true;
				powerupHUD2.color = 0x00FF00;
				powerupHUD2.visible = false;
				powerupHUD3.color = 0x00FF00;
				powerupHUD3.visible = false;
			}
			if (PlayState._powerupTwoCounter == 2)
			{
				powerupHUD.color = 0x00FF00;
				powerupHUD.visible = true;
				powerupHUD2.color = 0x00FF00;
				powerupHUD2.visible = true;
				powerupHUD3.color = 0x00FF00;
				powerupHUD3.visible = false;
			}
			if (PlayState._powerupTwoCounter == 3)
			{
				powerupHUD.color = 0x00FF00;
				powerupHUD.visible = true;
				powerupHUD2.color = 0x00FF00;
				powerupHUD2.visible = true;
				powerupHUD3.color = 0x00FF00;
				powerupHUD3.visible = true;
			}
			if (PlayState._powerupThreeCounter == 1)
			{
				powerupHUD.color = 0x0000FF;
				powerupHUD.visible = true;
				powerupHUD2.color = 0x0000FF;
				powerupHUD2.visible = false;
				powerupHUD3.color = 0x0000FF;
				powerupHUD3.visible = false;
			}
			if (PlayState._powerupThreeCounter == 2)
			{
				powerupHUD.color = 0x0000FF;
				powerupHUD.visible = true;
				powerupHUD2.color = 0x0000FF;
				powerupHUD2.visible = true;
				powerupHUD3.color = 0x0000FF;
				powerupHUD3.visible = false;
			}
			if (PlayState._powerupThreeCounter == 3)
			{
				powerupHUD.color = 0x0000FF;
				powerupHUD.visible = true;
				powerupHUD2.color = 0x0000FF;
				powerupHUD2.visible = true;
				powerupHUD3.color = 0x0000FF;
				powerupHUD3.visible = true;
			}
			//} powerup counters
		}
	}
}