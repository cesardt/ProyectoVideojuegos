package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Murcielago extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 150;
		private var _detected:Boolean;
			
		public function Murcielago(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X*24,Y*24, Assets.batSpriteSheet1);
			_player = ThePlayer;
			health = 1;
			maxVelocity.x = 200;
            maxVelocity.y = 200;
			_detected = false;
			loadGraphic(Assets.batSpriteSheet1, true, true, 24, 24, true);
			addAnimation("idle",[3], 0,false);
			addAnimation("volar",[0,1,2], 15, false);
			
		}
		
		  override public function update():void{
			
				var dify:int = y - _player.y;
				var difx:int = _player.x - x;
				
				trace("Detectado: ");
				trace(_detected);
			
			if(dify < 10 && !_detected){
				if(difx < 0 && difx > -150){
					facing = LEFT;
					velocity.x -= _move_speed;
					velocity.y = Math.log(FlxG.elapsed)* dify/2 ;
				}
				else if(difx > 0 && difx < 150){
					facing = RIGHT;
					velocity.x += _move_speed;
					velocity.y = Math.log(FlxG.elapsed)*dify/2;
				}
			}
			
			if(velocity.x != 0){
				play("volar");
				_detected = true;
			}
			else{
				play("idle");
				_detected = false;
			}
		  }

	}
}