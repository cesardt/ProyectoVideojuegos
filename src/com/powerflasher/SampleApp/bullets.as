package com.powerflasher.SampleApp {
	import org.flixel.FlxSprite;

	import flash.display.Sprite;

	public class bullets extends FlxSprite {
		[Embed(source = "Astrid/shuriken1.png")]
		public static var Shuriken : Class;

		public function bullets(x : Number = 0, y : Number = 0) {
			super(x, y);
			var bulletSpeed = 9;
			var bulletReady = true;
			var bulletDelay = 150
			var bulletArray = [];
			addAnimation("arma", [0], 8, true);
			play("arma");

			exists = false;
			this.x = 10;
			this.y = 20;
			this.exists = false;
			this.acceleration.y = 9;
			loadGraphic(Shuriken, true, true, 10, 9);
		}

		override public function update() : void {
			super.update();
		}
	}
}