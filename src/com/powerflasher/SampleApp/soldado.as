package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class soldado extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 200;
			
		public function soldado(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X*24,Y*36, Assets.enemigo);
			_player = ThePlayer;
			health = 1;
			acceleration.y=450;
			maxVelocity.x = 200;
            maxVelocity.y = 200;
			loadGraphic(Assets.enemigo, true, true, 24, 36, true);
			addAnimation("quieto",[1], 0,false);
			addAnimation("camina",[2,3,4], 15, false);
			
		}
		
		  override public function update():void{
				var dify:int = y - _player.y;
				var difx:int = x - _player.x;
				
				if(isTouching(LEFT)){
					facing = RIGHT;
				}
				if(isTouching(RIGHT)){
					facing = LEFT;
				}
				if(facing == LEFT){
					velocity.x -= _move_speed;
				}
				else{
					velocity.x += _move_speed;
				}
			}
	}
}