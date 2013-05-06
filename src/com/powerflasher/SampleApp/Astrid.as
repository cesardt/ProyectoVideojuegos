package com.powerflasher.SampleApp {
	import org.Assets;
	import org.osmf.traits.PlayState;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FX.*;

 	public class Astrid extends FlxSprite {
		public static const RIGHT:uint = 0;
		public static const LEFT:uint = 1;
		public static const UP:uint = 2;
		public static const DOWN:uint = 3;
		protected var jump : int;
		protected var _restart:Number;
		public var runV : uint = 80;
		private var doubleJump : Boolean;

		public function Astrid(x:Number,y:Number) {
			super(x, y);
			loadGraphic(Assets.jugadorSpriteSheet, true, true, 24, 36, true);
			//animaciones
			addAnimation("caminar", [0, 1, 2], 15, false);
			addAnimation("brincar", [9], 10, true);
			addAnimation("nobrincar", [8], 5, true);
			addAnimation("ataque", [12, 13], 4, false);
			addAnimation("enredadera", [14, 15], 4, false);
			_facing=RIGHT;
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
					play("brincar");
					
				}
			}
			/*if (FlxG.keys.justPressed("X")) {
				play("ataque");
			}*/
			
			/*if (FlxG.keys.pressed("RIGHT") && FlxG.keys.pressed("Z")) {
				runV = 200;
				acceleration.x += drag.x;
				trace(acceleration.x);
				_facing=RIGHT;
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}
			if (FlxG.keys.pressed("LEFT") && FlxG.keys.pressed("Z")) {
				acceleration.x -= drag.x * 1000;
				_facing=LEFT;
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}*/
			if (FlxG.keys.pressed("RIGHT")) {
				acceleration.x += drag.x;
				_facing=RIGHT;
				if (velocity.y == 0 ) {
					play("caminar");
				}
			}
			if (FlxG.keys.pressed("LEFT")) {
				acceleration.x -= drag.x;
				_facing=LEFT;
				if (velocity.y == 0 ) {
					play("caminar");
				}
			}
			if (FlxG.keys.pressed("DOWN")) {
			}
			if (FlxG.keys.justPressed("SPACE") && Inicio.numitems > 0 && !isTouching(FlxObject.FLOOR) && doubleJump == true) {
				velocity.y = -maxVelocity.y;
				play("brincar");
				doubleJump = false;
			}
			
			//Salto de Pared
			if(!isTouching(FlxObject.FLOOR) && isTouching(FlxObject.WALL) && Inicio.numitems > 2){
				velocity.y =  velocity.y*.9;
				if(FlxG.keys.justPressed("SPACE")){
					if(_facing==RIGHT){
						_facing=LEFT;
						velocity.y = -maxVelocity.y*25;
						velocity.x = -maxVelocity.x*40;
						play("brincar");
					
					}
					else if(_facing==LEFT){
						_facing=RIGHT;
						velocity.y = -maxVelocity.y*25;
						velocity.x = maxVelocity.x*40;
						play("brincar");
					}
					//doubleJump = true;
				}
			}
			
			if (FlxG.keys.pressed("C") && Inicio.numitems > 1 ) {
				if (FlxG.keys.pressed("RIGHT")) {
					this.x+=2;
					_facing=RIGHT;
					if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
						play("caminar");
					}
				}
				if (FlxG.keys.pressed("LEFT")) {
					this.x-=2;
					_facing=LEFT;
					if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
						play("caminar");
					}
				}
			}
			if (justTouched(FlxObject.FLOOR)){
				play("nobrincar");
			}


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
			Inicio.vidas-=1;
		}
	}
}
