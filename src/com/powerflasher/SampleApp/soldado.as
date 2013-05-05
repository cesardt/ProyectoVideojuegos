package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class soldado extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 150;
		private var detected:Boolean;
		private var maxX:int = 0;
		private var minX:int = 0;
			
		public function soldado(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X*24,Y*36, Assets.soldado);
			_player = ThePlayer;
			health = 1;
			acceleration.y=450;
			maxVelocity.x = 10;
            maxVelocity.y = 20;
			detected = false;
			
			minX = x - 100;
			maxX = x + 100;
			
			loadGraphic(Assets.soldado, true, true, 24, 36, true);
//			addAnimation("quieto",[1], 0,false);
//			addAnimation("camina",[2,3,4], 15, false);
			
		}
		
		  override public function update():void{
				var dify:int = y - _player.y;
				var difx:int = x - _player.x;
				
				
				if(x <= minX){
					facing = RIGHT;
				}
				if(x >= maxX){
					facing = LEFT;
				}
				if(facing == LEFT){
					velocity.x -= _move_speed;
					play("caminar");
				}
				else{
					velocity.x += _move_speed;
					play("caminar");
				}
		}
	}
}