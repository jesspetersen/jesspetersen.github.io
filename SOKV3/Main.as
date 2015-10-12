package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	import flash.system.*;
	import flash.text.*;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundMixer;
	
	public class Main extends MovieClip {
		
		var hero:TarnagFight = new TarnagFight();
		var monster:MonsterAttack = new MonsterAttack();
		
		var greataxe_btn:GreataxeButton = new GreataxeButton();
		var heal_btn:HealButton = new HealButton();
		var magic_btn:MagicButton = new MagicButton();
		var shout_btn:ShoutButton = new ShoutButton();
		
		var PlayerHP:PlayerHPBox = new PlayerHPBox();
		var MonsterHP:MonsterHPBox = new MonsterHPBox();
		
		var TarnagTurn:Boolean = true;
		var TurnTimer:Timer = new Timer(1000, 1);
		
		//returns a random number inside specified range
		public function randomRange(minNum:int, maxNum:int):int{
			return(Math.ceil(Math.random()*(maxNum-minNum))+ minNum);
		}
		

		public function Main() {
			startGame();
		}

		public function startGame():void {
			
			loadCharacters();
			loadInterface();
			loadListeners();
			
			loadPlayerOptions(); //since the game is just starting, set to player's turn
		}
		
		public function loadCharacters():void {
			
			hero.scaleX = .85;
			hero.scaleY = .85;
			hero.x = 10;
			hero.y = 190;
			addChild(hero);
			
			monster.scaleX = .80;
			monster.scaleY = .80;
			monster.x = 450;
			monster.y = 20;
			addChild(monster);
		}
		
		public function loadInterface():void {
			
			PlayerHP.scaleX = .70;
			PlayerHP.scaleY = .70;
			PlayerHP.TarnagHPText.text = String(hero.health);
			PlayerHP.x = 1;
			PlayerHP.y = 1;
			addChild(PlayerHP);
			
			MonsterHP.scaleX = .70;
			MonsterHP.scaleY = .70;
			MonsterHP.MonsterHPText.text = String(monster.health);
			MonsterHP.x = 1;
			MonsterHP.y = 40;
			addChild(MonsterHP);
		}
		
		public function loadListeners():void {
			
			greataxe_btn.addEventListener(MouseEvent.CLICK, redPow);
			heal_btn.addEventListener(MouseEvent.CLICK, greenSwirl);
			magic_btn.addEventListener(MouseEvent.CLICK, bluePow);
			shout_btn.addEventListener(MouseEvent.CLICK, shout);
			TurnTimer.addEventListener(TimerEvent.TIMER, changeTurn);
			
		}
		
		public function loadPlayerOptions ():void {
			
			greataxe_btn.scaleX = .70;
			greataxe_btn.scaleY = .70;
			greataxe_btn.x = 378;
			greataxe_btn.y = 344;
			addChild(greataxe_btn);
			
			heal_btn.scaleX = .70;
			heal_btn.scaleY = .70;
			heal_btn.x = 589;
			heal_btn.y = 344;
			addChild(heal_btn);
			
			magic_btn.scaleX = .70;
			magic_btn.scaleY = .70;
			magic_btn.x = 378;
			magic_btn.y = 405;
			addChild(magic_btn);
			
			shout_btn.scaleX = .70;
			shout_btn.scaleY = .70;
			shout_btn.x = 589;
			shout_btn.y = 405;
			addChild(shout_btn);
		}
		
		public function redPow(e:MouseEvent):void{
			removePlayerOptions();
			monster.gotoAndPlay("redPow");
		}
		
		public function greenSwirl(e:MouseEvent):void{
			removePlayerOptions();
			hero.gotoAndPlay("GreenSwirl");
		}
		
		public function bluePow(e:MouseEvent):void{
			removePlayerOptions();
			monster.gotoAndPlay("BluePow");
		}
		
		public function shout(e:MouseEvent):void{
			removePlayerOptions();
			var Shoutint:int = randomRange(0, 3);
			trace(Shoutint);
			if (Shoutint == 1)
			{
				hero.gotoAndPlay("Shout1");
			}
			else if (Shoutint == 2)
			{
				hero.gotoAndPlay("Shout2");
			}
			else if (Shoutint == 3)
			{
				hero.gotoAndPlay("Shout3");
			}
		}
		
		public function removePlayerOptions(): void{
			if(this.contains(greataxe_btn))
			{
				removeChild(greataxe_btn);
				removeChild(heal_btn);
				removeChild(magic_btn);
				removeChild(shout_btn);
			}
		}
		
		public function startTurnTimer(TarnagTurn:Boolean): void{
			this.TarnagTurn = TarnagTurn;
			TurnTimer.start();
		}
		
		public function changeTurn(e:TimerEvent): void{
			trace("Change turn");
			updateUI();
			if (TarnagTurn)
			{
				loadPlayerOptions();
			}
			else if(TarnagTurn == false)
			{
				monster.monsterAI();
			}
		}
		
		public function updateUI(): void{
			PlayerHP.TarnagHPText.text = String(hero.health);
			MonsterHP.MonsterHPText.text = String(monster.health);
		}
		
		public function redPowHit(): void{
			var dmg:int = randomRange(0, 15);
			trace(String(dmg));
			monster.health -= (15+dmg);
			updateUI();
			if (hero.health <= 0)
			{
				tarnagDie();
			}
			else if (monster.health <= 0)
			{
				monsterDie();
			}
		}
		
		public function greenSwirlHit(): void{
			var heal:int = randomRange(9, 30);
			trace(String(heal));
			hero.health += (10+heal);
			updateUI();
			if (hero.health <= 0)
			{
				tarnagDie();
			}
			else if (monster.health <= 0)
			{
				monsterDie();
			}
		}
		
		public function bluePowHit(): void{
			var dmg:int = randomRange(0, 30);
			trace(String(dmg));
			monster.health -= (10+dmg);
			updateUI();
			if (hero.health <= 0)
			{
				tarnagDie();
			}
			else if (monster.health <= 0)
			{
				monsterDie();
			}
		}
		
		public function tarnagPowHit(): void{
			var dmg:int = randomRange(5, 45);
			trace(String(dmg));
			hero.health -= dmg;
			updateUI();
			if (hero.health <= 0)
			{
				tarnagDie();
			}
			else if (monster.health <= 0)
			{
				monsterDie();
			}
		}
		
		public function tarnagDie():void{

			stop();
			//To do navigation we need to call upon 2 Flash function libraries
			var newdoc:URLRequest = new URLRequest("TarnagDie.swf");
			var loader:Loader = new Loader();
			//This line loads the new page but it is invisible
			loader.load(newdoc);
			//We add the new page to the stage and now we have 
			//both old and new pages mixed up on the stage - UGLY!
			stage.addChild(loader);
			//Clear out the old page to make way for the new.
			stage.removeChildAt(0);
		}
		
		public function monsterDie(): void{
			monster.gotoAndPlay("MonsterDie");
		}
	}
}