package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Brujo extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 100;
		private var maxX:int = 0;
		private var minX:int = 0;
			
		public function Brujo(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X,Y, Assets.brujo);
			_player = ThePlayer;
			health = 50;
			acceleration.y = 600;
			maxVelocity.x = 100;
            maxVelocity.y = 100;
			minX = x - 600;
			maxX = x + 600;
			loadGraphic(Assets.brujo, true, true, 60, 78, true);
			addAnimation("idle",[0], 0,false);
			addAnimation("caminar",[0,1,2], 15, false);
			facing = LEFT;
			
		}
		
		  override public function update():void{
			
				var dify:int = y - _player.y;
				var difx:int = x - _player.x;
				
			
				if(x <= minX || isTouching(LEFT)){
					facing = RIGHT;
				}
				if(x >= maxX || isTouching(RIGHT)){
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