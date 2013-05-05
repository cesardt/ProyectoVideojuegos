package com.powerflasher.SampleApp {
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class BossArea3 extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 100;
		private var weapon : FlxWeapon;
		private var contador:int=0;	
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
			weapon = new FlxWeapon("shuriken", this, "x", "y");
			weapon.makeImageBullet(50, Assets.Shuriken, 5,0,true,10,1);
			weapon.setBulletDirection(FlxWeapon.BULLET_LEFT,100);
			weapon.bounds.width=3200;
			weapon.bounds.height=1600;
			weapon.group;
						
			
		}
		
		  override public function update():void{
			
				var dify:int = y - _player.y;
				var difx:int = x - _player.x;
				trace(contador);
				if(contador==500){
					trace("dispara");
					weapon.fire();
					weapon.fire();
					weapon.fire();
					weapon.fire();
					weapon.fire();
					contador=0;
				}else{
					contador++;
				}
			if(difx<20 && difx>-20){
				if(difx<20 && difx>0){
					facing = RIGHT;
					velocity.x -= _move_speed;
				}else{
					facing = LEFT;
					
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