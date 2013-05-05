package com.powerflasher.SampleApp {
	import org.Assets;
	import org.osmf.traits.PlayState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FX.*;

 	public class Astrid extends FlxSprite {
		protected var jump : int;
		protected var _restart:Number;
		protected var _bullets:FlxGroup;
		public var runV : uint = 80;
		private var doubleJump : Boolean;

		public function Astrid(x:Number,y:Number) {
			super(x, y);
			loadGraphic(Assets.jugadorSpriteSheet, true, true, 24, 36, true);
			//animaciones
			addAnimation("derecha", [0, 1, 2], 15, false);
			addAnimation("izquierda", [3, 4, 5], 15, false);
			addAnimation("brincader", [9], 10, true);
			addAnimation("brincaizq", [6], 10, true);
			addAnimation("nobrincaizq", [7], 5, true);
			addAnimation("nobrincader", [8], 5, true);
			addAnimation("ataqueizq", [10, 11], 4, false);
			addAnimation("ataqueder", [12, 13], 4, false);
			addAnimation("enredadera", [14, 15], 4, false);
			if(x>500){
				play("izquierda");
			}
			else{
				play("derecha");
			}
			frame = 3;

			//Propiedades astrid
			_restart = 0;
			velocity.y = 10;
			offset.x = 0;
			offset.y = 0;
			drag.x = runV * 8;
			jump = 200;
			maxVelocity.x = runV;
			maxVelocity.y = jump;
			acceleration.y = 450;
			health=100;
			facing=RIGHT;
			
		}
		override public function destroy():void
		{
			super.destroy();
			_bullets = null;
		}

		override public function update() : void {
			if(!alive)
			{
				_restart += FlxG.elapsed;
				if(_restart > 2)
					FlxG.resetState();
				return;
			}
			
			if(isTouching(FlxObject.FLOOR)){
				doubleJump = true;
			}
			
				
			acceleration.x = 0;
			if (FlxG.keys.justPressed("SPACE") && isTouching(FlxObject.FLOOR)) {
				velocity.y = -maxVelocity.y;
				if (velocity.y != 0 ) {
					play("brincader");
					
				}
			}
			if (FlxG.keys.justPressed("X")) {
				play("ataqueder");
			}
			
			if (FlxG.keys.pressed("RIGHT") && FlxG.keys.pressed("Z")) {
				// trace (astrid.drag.x*10);
				runV = 200;
				acceleration.x += drag.x;
				trace(acceleration.x);
				facing=RIGHT;
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}
			if (FlxG.keys.pressed("LEFT") && FlxG.keys.pressed("Z")) {
				acceleration.x -= drag.x * 1000;
				facing=LEFT;
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}
			if (FlxG.keys.pressed("RIGHT")) {
				trace(acceleration.x);
				acceleration.x += drag.x;
				facing=RIGHT;
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}
			if (FlxG.keys.pressed("LEFT")) {
				acceleration.x -= drag.x;
				facing=LEFT;
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}
			if (FlxG.keys.pressed("DOWN")) {
			}
			if (FlxG.keys.justPressed("SPACE") && FlxG.score > 0 && !isTouching(FlxObject.FLOOR) && doubleJump == true) {
				velocity.y = -maxVelocity.y;
				doubleJump = false;
			}
			
			//Salto de Pared
			if(!isTouching(FlxObject.FLOOR) && isTouching(FlxObject.WALL)){
				velocity.y =  velocity.y*.9;
				if(FlxG.keys.justPressed("SPACE")){
					if(facing==RIGHT){
						facing=LEFT;
						velocity.y = -maxVelocity.y*25;
						velocity.x = -maxVelocity.x*40;
						play("brincaizq");
					
					}
					else{
						facing=RIGHT;
						velocity.y = -maxVelocity.y*25;
						velocity.x = maxVelocity.x*40;
						play("brincader");
					}
					doubleJump = true;
				}
			}
			
			if (FlxG.keys.pressed("C")) {
				if (FlxG.keys.pressed("RIGHT")) {
					this.x+=2;
					facing=RIGHT;
					if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
						play("derecha");
					}
				}
				if (FlxG.keys.pressed("LEFT")) {
					this.x-=2;
					facing=LEFT;
					if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
						play("derecha");
					}
				}
			}
			if (justTouched(FlxObject.FLOOR)){
				play("nobrincader");
			}


		}
		
		override public function hurt(Damage:Number):void
		{
			Damage = 0;
			if(flickering)
				return;
			flicker(1.3);
			if(FlxG.score > 1000) FlxG.score -= 1000;
			if(velocity.x > 0)
				velocity.x = -maxVelocity.x;
			else
				velocity.x = maxVelocity.x;
			super.hurt(Damage);
		}
		override public function kill():void
		{
			if(!alive){
				return;
			}
			solid = false;
			super.kill();
			flicker(0);
			exists = true;
			visible = false;
			velocity.make();
			acceleration.make();
			FlxG.camera.shake(0.005,0.35);
			FlxG.camera.flash(0xffd8eba2,0.35);
		}
	}
}
