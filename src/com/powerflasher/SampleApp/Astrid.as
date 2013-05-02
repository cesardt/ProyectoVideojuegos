package com.powerflasher.SampleApp {
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	/**
	 * @author ieiomeli
	 */
	public class Astrid extends FlxSprite {
		[Embed(source = "Astrid/tilesmedastrid.png")]
		public static var jugadorSpriteSheet : Class;
		public var lado : String;
		protected var jump : int;
		protected var _restart:Number;
		protected var _bullets:FlxGroup;
		public var runV : uint = 80;
		private var doubleJump : Boolean;

		public function Astrid() {
			super(150, 570);
			frame = 3;

			_restart = 0;
			velocity.y = 10;
			offset.x = 0;
			offset.y = 0;
			drag.x = runV * 8;
			jump = 200;
			maxVelocity.x = runV;
			maxVelocity.y = jump;
			acceleration.y = 450;
			loadGraphic(jugadorSpriteSheet, true, true, 24, 36, true);
			addAnimation("izquierda", [3, 4, 5], 15, false);
			addAnimation("derecha", [0, 1, 2], 15, false);
			addAnimation("brincader", [9], 10, true);
			addAnimation("brincaizq", [6], 10, true);
			addAnimation("nobrincaizq", [7], 5, true);
			addAnimation("nobrincader", [8], 5, true);
			addAnimation("ataqueizq", [10, 11], 4, false);
			addAnimation("ataqueder", [12, 13], 4, false);
			addAnimation("enredadera", [14, 15], 4, false);
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
			
				
			acceleration.x = 0;
			if (FlxG.keys.justPressed("SPACE") && isTouching(FlxObject.FLOOR)) {
				velocity.y = -maxVelocity.y;
				doubleJump = true;
				if (velocity.y != 0 ) {
					if (lado == "der") {
						play("brincader");
					}
					if (lado == "izq") {
						play("brincaizq");
					}
				}
			}
			if (FlxG.keys.justPressed("X") && lado == "izq") {
				play("ataqueizq");
			}
			if (FlxG.keys.justPressed("X") && lado == "der") {
				play("ataqueder");
			}
			if (FlxG.keys.pressed("RIGHT") && FlxG.keys.pressed("Z")) {
				// trace (astrid.drag.x*10);
				runV = 200;
				acceleration.x += drag.x;
				trace(acceleration.x);
				lado = "der";
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}
			if (FlxG.keys.pressed("LEFT") && FlxG.keys.pressed("Z")) {
				acceleration.x -= drag.x * 1000;
				lado = "izq";
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("izquierda");
				}
			}
			if (FlxG.keys.pressed("RIGHT")) {
				trace(acceleration.x);
				acceleration.x += drag.x;
				lado = "der";
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("derecha");
				}
			}
			if (FlxG.keys.pressed("LEFT")) {
				acceleration.x -= drag.x;
				lado = "izq";
				if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
					play("izquierda");
				}
			}
			if (FlxG.keys.pressed("DOWN")) {
			}
			if (FlxG.keys.justPressed("SPACE") && FlxG.score > 0 && !isTouching(FlxObject.FLOOR) && doubleJump == true) {
				velocity.y = -maxVelocity.y;
				doubleJump = false;
			}
			
			//Salto de Pared
			if(FlxG.keys.justPressed("SPACE") && !isTouching(FlxObject.FLOOR) && isTouching(WALL)){
				velocity.y = -maxVelocity.y*4;
				
				velocity.x = -maxVelocity.x*5;
				doubleJump = true;
			}
			
			if (FlxG.keys.pressed("C")) {
				if (FlxG.keys.pressed("RIGHT")) {
					this.x+=2;
					lado = "der";
					if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
						play("derecha");
					}
				}
				if (FlxG.keys.pressed("LEFT")) {
					this.x-=2;
					lado = "izq";
					if (velocity.y == 0 && !FlxG.keys.pressed("X")) {
						play("izquierda");
					}
				}
			}
			if (justTouched(FlxObject.FLOOR) && lado == "izq") {
				play("nobrincaizq");
			}
			if (this.justTouched(FlxObject.FLOOR) && lado == "der") {
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
