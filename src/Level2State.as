package  
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import images.*;
	import neoart.flod.soundfx.FXPlayer;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.*;
	import sounds.*;
	import org.flixel.*;
	import org.Ship;
	/**
	 * ...
	 * @author Faded
	 */
	
	public class Level2State extends FlxState
	{
		//{ vars
		[Embed(source = '/images/jets.png')]
		private var jetsPNG:Class;
		[Embed(source="/images/Particle.png")]
		private var _imgParticle:Class;
		[Embed(source = "/sounds/shipbullet.mp3")]
		private var SoundBullet:Class;
		[Embed(source = "/sounds/explode.mp3")]
		private var SoundAlien:Class;
		[Embed(source = "/sounds/ExplodeShip.mp3")]
		private var SoundShip:Class;
		[Embed(source = "/sounds/ExplodeShipExt.mp3")]
		private var SoundShipExt:Class;
		[Embed(source = "/sounds/GameOver.mp3")]
		private var SoundGameOver:Class;
		[Embed(source = "/sounds/mainpowerup.mp3")]
		private var SoundPowerupOne:Class;
		[Embed(source = "/sounds/secondpowerup.mp3")]
		private var SoundPowerupTwo:Class;
		[Embed(source = "/sounds/thirdpowerup.mp3")]
		private var SoundPowerupThree:Class;
		[Embed(source = "/sounds/soundLevel1.mp3")]
		public var SoundPlayState:Class;
		[Embed(source = "/sounds/warning.mp3")]
		public var SoundWarning:Class;
		private var _powerupDropRate:Number = 40;
		private var _powerupDropCounter:Number = 0;
		public static var _powerupFourCounter:Number = 1;
		public static var _powerupFiveCounter:Number = 0;
		public static var _powerupSixCounter:Number = 0;
		private var _powerups:FlxGroup; 
		private var _aliens:FlxGroup;
		private var _alienSpecial:FlxGroup;
		private var _asteroid:FlxGroup;
		private var _bullets:FlxGroup;
		private var _enemybullets:EnemyBullet;
		private var _spawnTimer:Number;
		private var _spawnInterval:Number = 2.5;
		public  static var _scoreText:FlxText;
		private var _gameOverText:FlxText;
		private var _pinkyPwnText:FlxText;
		private var _goText:FlxText;
		private var _pinkyOuchText:FlxText;
		private var _asteroidText:FlxText;
		private var _HUD:HUD;
		private var jets:FlxGroup;
		private var asteroidEventTimer:Timer = new Timer(20000, 1);
		private var asteroidEventTextTimer:Timer = new Timer(19000, 1);
		private var asteroidEventText:FlxText;
		private var asteroidTimer:Timer = new Timer(900, 20);
		private var pinkyEventTimer:Timer = new Timer(55000, 1);
		private var pinkyEventTextTimer:Timer = new Timer(54000, 1);
		private var pinkyEventText:FlxText;
		private var pinkyTimer:Timer = new Timer(200, 50);
		private var endLevel:FlxText;
		private var levelTimer:Timer = new Timer(1000, 1);
		private var lstateButton:FlxButtonPlus;
		private var lmenuButton:FlxButtonPlus;
		public var _explode:Explode;
		
		
		//} end vars
		
		override public function create():void
		{
			//{ playstate spawning
			FlxG.bgColor = 0xFF000000;
			Registry.player = new Ship();
			add(Registry.player);
			_aliens = new FlxGroup();
			add(_aliens);
			_alienSpecial = new FlxGroup();
			add(_alienSpecial);
			_asteroid = new FlxGroup();
			add(_asteroid);
			_bullets = new FlxGroup();
			add(_bullets);
			_enemybullets = new EnemyBullet();
			add(_enemybullets);
			_powerups = new FlxGroup;
			add(_powerups);
			_HUD = new HUD();
			add(_HUD);
			Registry.stars = new StarField(90, 40);
			add(Registry.stars);
			jets = new FlxGroup();
			add(jets);

			FlxG.playMusic(SoundPlayState, 1.0);
			FlxG.score = 0;
			_scoreText = new FlxText(90, 8, 200, "0");
			_scoreText.setFormat(null, 28, 0xFFFFFFFF, "left");
			add(_scoreText);
			_goText = new FlxText(0, FlxG.height / 4, FlxG.width, "GO!");
			_goText.setFormat(null, 20, 0xFFFFFFFF, "center");
			add(_goText);
			resetSpawnTimer();
			asteroidEventTimer.addEventListener(TimerEvent.TIMER, asteroidEventListener);
			asteroidEventTimer.start();
			asteroidEventTextTimer.addEventListener(TimerEvent.TIMER, asteroidEventTextListener);
			asteroidEventTextTimer.start();
			pinkyEventTimer.addEventListener(TimerEvent.TIMER, pinkyEventListener);
			pinkyEventTimer.start();
			pinkyEventTextTimer.addEventListener(TimerEvent.TIMER, pinkyEventTextListener);
			pinkyEventTextTimer.start();
			
			super.create();
						
			//Registry.init();
			//add(Registry.enemyBullets);

			//} end spawns
		}	
		
		override public function update():void
		{
			//{ spawn timers
			FlxG.overlap(_aliens, _bullets, overlapAlienBullet);
			FlxG.overlap(_aliens, Registry.player, overlapAlienShip);
			FlxG.overlap(_alienSpecial, _bullets, overlapSpecialAlienBullet);
			FlxG.overlap(_alienSpecial, Registry.player, overlapSpecialAlienShip);
			FlxG.overlap(Registry.player, _powerups, overlapShipPowerup);
			FlxG.overlap(Registry.player, _enemybullets, overlapShipEnemyBullets);
			FlxG.overlap(_asteroid, Registry.player, overlapShipAsteroid);
			
			if (FlxG.keys.justPressed("X") && Registry.player.alive)
			{
				remove(_goText);
				spawnBullet(Registry.player.getBulletSpawnPosition());
			}
			_spawnTimer -= FlxG.elapsed;

			if (_spawnTimer <= 0)
			{
				spawnAlien();
				resetSpawnTimer();
			}
			
			if (_spawnTimer >= 0.95)
			{
				resetSpawnTimer();
			}
			
			if (FlxG.keys.ENTER && Registry.player.alive == false)
			{
				FlxG.resetState();
			}
			
			super.update();
			//} end spawn timers
		}
		//{ timer listeners
		
		private function asteroidEventListener(e:TimerEvent):void 
		{
			asteroidTimer.addEventListener(TimerEvent.TIMER, asteroidtimerListener);
			asteroidTimer.start();
		}
		
		private function asteroidEventTextListener(e:TimerEvent):void 
		{
			asteroidEventText = new FlxText(0, FlxG.height / 2, FlxG.width, "ASTEROID FIELD DETECTED!");
			asteroidEventText.setFormat(null, 35, 0xFFFF0000, "center");
			add(asteroidEventText);
			FlxG.play(SoundWarning);
		}
		private function asteroidtimerListener(e:TimerEvent):void 
		{
			spawnAsteroid();
			remove(asteroidEventText);
			asteroidEventTimer.stop();
		}
		
		private function pinkyEventListener(e:TimerEvent):void
		{
			pinkyTimer.addEventListener(TimerEvent.TIMER, pinkyTimerListener);
			pinkyTimer.start();
		}
		
		private function pinkyEventTextListener(e:TimerEvent):void 
		{
			pinkyEventText = new FlxText(0, FlxG.height / 2, FlxG.width, "DETECTED INCOMING ALIEN FLEET!");
			pinkyEventText.setFormat(null, 30, 0xFFFF0000, "center");
			add(pinkyEventText);
			FlxG.play(SoundWarning);
			remove(_aliens);
		}
		
		private var tickCounts:int = 0;
		private function pinkyTimerListener(e:TimerEvent):void
		{
			spawnSpecialAlien();
			remove(pinkyEventText);
			pinkyEventTimer.stop();
			tickCounts++;
			if (tickCounts >= 50)
			{
				levelTimer.addEventListener(TimerEvent.TIMER, levelTimerListener);
				levelTimer.start();
				remove(Registry.player);
				remove(_bullets);
				remove(_alienSpecial);
				remove(_asteroid);
				remove(_enemybullets);
				remove(_powerups);
				remove(_HUD);
				remove(jets);
				remove(_explode);
				FlxG.music.stop();
				endLevel = new FlxText(0, FlxG.height / 2, FlxG.width, "YOU HAVE COMPLETED LEVEL 1");
				endLevel.setFormat(null, 30, 0xFFFF0000, "center");
				add(endLevel);
				if (LevelsCompleted.levels == 1)
				{
					LevelsCompleted.levels = 1;
				}
				if (LevelsCompleted.levels < 1)
				{
					LevelsCompleted.levels += 1;
				}
			}
		}
		
		private function levelTimerListener(e:TimerEvent):void 
		{
			FlxG.mouse.show();
			lstateButton = new FlxButtonPlus(265, 304, lstateButtonClick, null, "Continue to level II"); 
			add(lstateButton);
			lmenuButton = new FlxButtonPlus(265, 404, lmenuButtonClick, null, "Go back to Level Menu"); 
			add(lmenuButton);
		}
		
		private function lstateButtonClick():void 
		{
			FlxG.mouse.hide();
			//FlxG.switchState(new Level2);
		}
		
		private function lmenuButtonClick():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new LevelState);
		}
		//} end listeners
		
		//{ powerup spawn function
		private function spawnPowerup(powerupPos:FlxPoint):void
		{
			var powerup: Powerup = new Powerup(powerupPos.x, powerupPos.y);
			_powerups.add(powerup);
		}
		//} end spawn functions
		//{ overlaps/collisions
		private function overlapAlienBullet(alien: Alien, bullet: Bullet):void 
		{
			_explode  = new Explode(alien.x, alien.y);
			add(_explode);
			alien.kill();
			bullet.kill();
			FlxG.play(SoundAlien);
			/*var emitter:FlxEmitter = createEmitter();
			emitter.at(alien);*/
			FlxG.score += 2;
			_scoreText.text = FlxG.score.toString();
			_powerupDropCounter += 1;
			
			if (_powerupDropCounter >= _powerupDropRate)
			{
				spawnPowerup(alien.getPowerupSpawnPosition());
				_powerupDropCounter = 0;
			}
		}
		
		private function overlapSpecialAlienBullet(salien: SpecialAlien, bullet: Bullet):void
		{
			salien.kill();
			bullet.kill();
			FlxG.play(SoundAlien);
			var emitter:FlxEmitter = createEmitter();
			emitter.at(salien);
			FlxG.score += 10;
			_scoreText.text = FlxG.score.toString();
			_powerupDropCounter += 3;
			
			if (_powerupDropCounter >= _powerupDropRate)
			{
				spawnPowerup(salien.getPowerupSpawnPosition());
				_powerupDropCounter = 3;
			}
		}
		
		private function overlapShipEnemyBullets(sbullet: EnemyBullet, ship: Ship):void
		{
			//salien.kill();
			//aliens.kill();
			var emitter:FlxEmitter = createEmitter();
			emitter.at(ship);
			HUD._playerShield = 0;
			HUD._playerArmor = 0;
			
			if (HUD._playerArmor == 0 && HUD._playerShield == 0)
			{
				Registry.player.kill();
				FlxG.shake.apply(0.02);
				FlxG.play(SoundShip);
				FlxG.play(SoundShipExt);
				_pinkyPwnText = new FlxText(0, FlxG.height / 4, FlxG.width, "PINKY SHOT YOU DOWN!");
				_pinkyPwnText.setFormat(null, 20, 0xFFFFFFFF, "center");
				add(_pinkyPwnText);
				_gameOverText = new FlxText(0, FlxG.height / 2, FlxG.width, "GAME OVER\nPRESS ENTER TO PLAY AGAIN");
				_gameOverText.setFormat(null, 20, 0xFFFFFFFF, "center");
				add(_gameOverText);
				FlxG.playMusic(SoundPlayState, 0);
				FlxG.playMusic(SoundGameOver);
				remove(_alienSpecial);
				remove(_aliens);
				
				_powerupFourCounter = 1;
				_powerupFiveCounter = 0;
				_powerupSixCounter = 0;
			}
		}
		
		private function overlapSpecialAlienShip(salien: SpecialAlien, ship: Ship):void 
		{
			var emitter:FlxEmitter = createEmitter();
			emitter.at(Registry.player);
			HUD._playerShield = 0;
			HUD._playerArmor = 0;
			
			if (HUD._playerArmor == 0 && HUD._playerShield == 0)
			{
				Registry.player.kill();
				FlxG.shake.apply(0.02);
				FlxG.play(SoundShip);
				FlxG.play(SoundShipExt);
				_pinkyPwnText = new FlxText(0, FlxG.height / 4, FlxG.width, "YOU JUST GOT PWND BY PINKY!");
				_pinkyPwnText.setFormat(null, 20, 0xFFFFFFFF, "center");
				add(_pinkyPwnText);
				_gameOverText = new FlxText(0, FlxG.height / 2, FlxG.width, "GAME OVER!\nPRESS ENTER TO PLAY AGAIN");
				_gameOverText.setFormat(null, 20, 0xFFFFFFFF, "center");
				add(_gameOverText);
				FlxG.playMusic(SoundPlayState, 0);
				FlxG.playMusic(SoundGameOver);
				pinkyEventTimer.stop();
				pinkyEventTextTimer.stop();
				pinkyTimer.stop();
				remove(_alienSpecial);
				remove(_aliens);
				remove(_asteroid);
				remove(Registry.stars);
				_powerupFourCounter = 1;
				_powerupFiveCounter = 0;
				_powerupSixCounter = 0;
			}
		}
		
		private function overlapShipAsteroid(sasteroid: Asteroid, ship: Ship):void 
		{
			Registry.player.kill();
			sasteroid.kill();
			var emitter:FlxEmitter = createEmitter();
			emitter.at(Registry.player);
			HUD._playerShield = 0;
			HUD._playerArmor = 0;
			if (HUD._playerArmor == 0 && HUD._playerShield == 0)
			{
				Registry.player.kill();
				FlxG.shake.apply(0.02);
				FlxG.play(SoundShip);
				FlxG.play(SoundShipExt);
				_asteroidText = new FlxText(0, FlxG.height / 4, FlxG.width, "Watch out for those Asteroids!!");
				_asteroidText.setFormat(null, 20, 0xFFFFFFFF, "center");
				add(_asteroidText);
				_gameOverText = new FlxText(0, FlxG.height / 2, FlxG.width, "GAME OVER\nPRESS ENTER TO PLAY AGAIN");
				_gameOverText.setFormat(null, 20, 0xFFFFFFFF, "center");
				add(_gameOverText);
				FlxG.playMusic(SoundPlayState, 0);
				FlxG.playMusic(SoundGameOver);
				remove(_alienSpecial);
				remove(_aliens);
				remove(_asteroid);
				remove(Registry.stars);
				asteroidEventTimer.stop();
				asteroidEventTextTimer.stop();
				asteroidTimer.stop();
				pinkyEventTimer.stop();
				pinkyEventTextTimer.stop();
				pinkyTimer.stop();
			}
		}
		
		private function overlapAlienShip(alien: Alien, ship: Ship):void 
		{
			alien.kill();
			var emitter:FlxEmitter = createEmitter();
			emitter.at(Registry.player);
			
			if (HUD._playerShield > 0)
			{
				HUD._playerShield -= 1;
				FlxG.shake.apply(0.01);
				FlxG.play(SoundShip);
				FlxG.play(SoundShipExt);
			}
			else if (HUD._playerShield <= 0)
			{
				HUD._playerArmor -= 1;
				FlxG.shake.apply(0.01);
				FlxG.play(SoundShip);
				FlxG.play(SoundShipExt);
			}
			
			if (HUD._playerShield < 0)
			{
				HUD._playerShield = 0;
			}
			if (HUD._playerArmor < 0)
			{
				HUD._playerArmor = 0;
			}
			
			if (HUD._playerArmor == 0 && HUD._playerShield == 0)
			{
				Registry.player.kill();
				FlxG.shake.apply(0.02);
				FlxG.play(SoundShip);
				FlxG.play(SoundShipExt);
				
				_gameOverText = new FlxText(0, FlxG.height / 2, FlxG.width, "GAME OVER\nPRESS ENTER TO PLAY AGAIN");
				_gameOverText.setFormat(null, 20, 0xFFFFFFFF, "center");
				add(_gameOverText);
				FlxG.playMusic(SoundPlayState, 0);
				FlxG.playMusic(SoundGameOver);
				asteroidEventTimer.stop();
				asteroidEventTextTimer.stop();
				asteroidTimer.stop();
				pinkyEventTimer.stop();
				pinkyEventTextTimer.stop();
				pinkyTimer.stop();
				remove(_alienSpecial);
				remove(_aliens);
				remove(_asteroid);
				remove(Registry.stars);
			}
		}
		private function overlapShipPowerup(ship:Ship, powerup:Powerup):void
		{
			if (powerup.randomPowerupTag == "PowerupFour")
			{
				_powerupFourCounter += 1;
				_powerupFiveCounter = 0;
				_powerupSixCounter = 0;
				FlxG.play(SoundPowerupOne);
				
				if (_powerupFourCounter >= 3)
				{
					_powerupFourCounter = 3;
				}
			}
			if (powerup.randomPowerupTag == "PowerupFive")
			{
				_powerupFourCounter = 0;
				_powerupFiveCounter += 1;
				_powerupSixCounter = 0;
				FlxG.play(SoundPowerupTwo);
				
				if (_powerupFiveCounter >= 3)
				{
					_powerupFiveCounter = 3;
				}
			}
			if (powerup.randomPowerupTag == "PowerupSix")
			{
				_powerupFourCounter = 0;
				_powerupFiveCounter = 0;
				_powerupSixCounter += 1;
				FlxG.play(SoundPowerupThree);
				
				if (_powerupSixCounter >= 3)
				{
					_powerupSixCounter = 3;
				}
			}
			powerup.kill();
		}
		//} end overlaps
		
		//{ bullet spawn + powerup change
		private function spawnBullet(p: FlxPoint):void 
		{
			if (_powerupFourCounter == 0)
			{
				var bullet4:Bullet = new Bullet(p.x, p.y + 7);
				var bullet4Two:Bullet = new Bullet(p.x, p.y);
				var bullet4Three:Bullet = new Bullet(p.x, p.y - 7);
				_bullets.add(bullet4);
				_bullets.add(bullet4Two);
				_bullets.add(bullet4Three);
			}
			if (_powerupFourCounter == 1)
			{
				var bullet4Four:Bullet = new Bullet(p.x, p.y + 10);
				var bullet4Five:Bullet = new Bullet(p.x, p.y + 7);
				var bullet4Six:Bullet = new Bullet(p.x, p.y - 7);
				var bullet4Seven:Bullet = new Bullet(p.x, p.y - 10);
				_bullets.add(bullet4Four);
				_bullets.add(bullet4Five);
				_bullets.add(bullet4Six);
				_bullets.add(bullet4Seven);
			}
			if (_powerupFourCounter == 2)
			{
				var bullet4Eight:Bullet = new Bullet(p.x, p.y + 10);
				var bullet4Nine:Bullet = new Bullet(p.x, p.y + 7);
				var bullet4Ten:Bullet = new Bullet(p.x, p.y);
				var bullet4Eleven:Bullet = new Bullet(p.x, p.y - 7);
				var bullet4Twelve:Bullet = new Bullet(p.x, p.y - 10);
				_bullets.add(bullet4Eight);
				_bullets.add(bullet4Nine);
				_bullets.add(bullet4Ten);
				_bullets.add(bullet4Eleven);
				_bullets.add(bullet4Twelve);
			}
		}
		//} end bullet spawn
		
		//{ alien spawn functions
		private function spawnAlien():void
		{
			var x:Number = FlxG.width;
			var y:Number = Math.random() * (FlxG.height - 100) + 50;
			_aliens.add(new Alien(x, y));
		}
		
		private function spawnSpecialAlien():void
		{
				var x:Number = FlxG.width;
				var y:Number = Math.random() * (FlxG.height - 100) + 50;
				_alienSpecial.add(new SpecialAlien(x, y));
		}
		
		private function spawnAsteroid():void 
		{
			var x:Number = FlxG.width;
			var y:Number = Math.random() * (FlxG.height - 200) + 50;
			_asteroid.add(new Asteroid(x, y));
		}
		//} end alien spawns
		
		//{ particle emitter
		private function createEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.lifespan = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed( -500, 500);
			emitter.setYSpeed( -500, 500);
			var particles:int = 10;
			
			for (var i:int = 0; i < particles; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				emitter.makeParticles(_imgParticle, 10);
				particle.exists = false;
				emitter.add(particle);
			}
			
			emitter.start();
			add(emitter);
			return emitter;
		}
		//} end emitter
		
		//{ spawn reset timer
		private function  resetSpawnTimer():void 
		{
			_spawnTimer = _spawnInterval;
			_spawnInterval *= 0.95;
			if (_spawnInterval < 0.4)
			{
				_spawnInterval = 0.4;
			}
		}
		/*
		private function resetTestTimer():void 
		{
			if (testTimer >= 4.9)
			{
				testTimer = 5;
			}
		}
		*/
		//} end reset timer
	}
}