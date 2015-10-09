package  {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.*;
	import flash.utils.*;
	import flash.system.*;
	import flash.text.*;
	
	public class MonsterAttack extends MovieClip {
		
		var health:int = 100;
		
		public function monsterAI():void{
			MovieClip(parent).hero.gotoAndPlay("TarnagPow");
		}

		public function MonsterAttack() {
			// constructor code
		}

	}
	
}
