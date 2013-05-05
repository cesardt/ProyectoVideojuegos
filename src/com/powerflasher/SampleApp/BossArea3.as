package com.powerflasher.SampleApp {
	import org.flixel.FlxGroup;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class BossArea3 extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 50;
		protected var _bullets:FlxGroup;
		public function BossArea3(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X,Y, Assets.brujo);
			_player = ThePlayer;
			health = 30;
			acceleration.y = 600;
			maxVelocity.x = 100;
            maxVelocity.y = 100;
			loadGraphic(Assets.brujo, true, true, 60, 78, true);
			addAnimation("idle",[0], 0,false);
			addAnimation("caminar",[0,1,2], 15, false);
						facing = LEFT;
									
			
		}
		override public function destroy():void
		{
			super.destroy();
			_bullets = null;
		}
		
		  override public function update():void{
			
				var dify:int = y - _player.y;
				var difx:int = x - _player.x;
				
			if(difx<200 && difx>-200){
				if(difx<100 && difx>0){
					facing = LEFT;
					velocity.x -= _move_speed;
				}else{
					facing = RIGHT;
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