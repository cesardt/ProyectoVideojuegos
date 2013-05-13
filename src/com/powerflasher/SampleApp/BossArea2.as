package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class BossArea2 extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 25;
			
		public function BossArea2(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X,Y, Assets.brujo);
			_player = ThePlayer;
			health = 50;
			acceleration.y = 600;
			maxVelocity.x = 50;
            maxVelocity.y = 100;
			loadGraphic(Assets.brujo, true, true, 60, 78, true);
			addAnimation("idle",[0], 0,false);
			addAnimation("caminar",[0,1,2], 15, false);
			facing = LEFT;
			
		}
		
		  override public function update():void{
			
				var dify:int = y - _player.y;
				var difx:int = x - _player.x;
				
			if(difx<200 && difx>-200){
				if(difx<100 && difx>0){
					facing = LEFT;
					velocity.x -= _move_speed;
				}else{
					if(dify > 5){
						facing = LEFT;
					}
					if(_player.x > x){
						facing = RIGHT;
					}
					velocity.x += _move_speed;
					
				}
		  	}else{
					if(isTouching(LEFT)){
						facing = RIGHT;
					}
					if(isTouching(RIGHT)){
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
}