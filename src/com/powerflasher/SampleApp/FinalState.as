package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxSprite;

	import flash.events.Event;

	import org.flixel.FlxG;
	import org.flixel.FlxState;

	import flash.display.MovieClip;

	public class FinalState extends FlxState {
		protected var final : FlxSprite = new FlxSprite(0, 0);

		override public function create() : void {
			final.loadGraphic(Assets.fin, false, false, 800, 400, false);
			add(final);
		}

		public override function update() : void {
			if (FlxG.keys.any()) {
				FlxG.resetGame();
			}
		}
	}
}
