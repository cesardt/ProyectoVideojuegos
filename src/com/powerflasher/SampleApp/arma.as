package com.powerflasher.SampleApp{
	import org.flixel.FlxSprite;

	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author Mau
	 */
	public class arma extends FlxSprite {
		[Embed(source = "Astrid/shuriken1.png")]
		public static var Shuriken:Class;
		public function arma(X : Number = 0, Y : Number = 0, SimpleGraphic : Class = null) {
			super(X, Y, SimpleGraphic);

			loadGraphic(Shuriken, true, true,10, 9);

			addAnimation("arma", [0], 8,true);
			play("arma");

			exists = false;
		}

		override public function update() : void {
			super.update();
			velocity.x = 10;
			if (x > 500) {
				exists = false;		
			}
		}
	}
}