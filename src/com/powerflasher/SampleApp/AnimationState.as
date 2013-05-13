package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxSprite;

	import flash.events.Event;

	import org.flixel.FlxG;
	import org.flixel.FlxState;

	import flash.display.MovieClip;

	public class AnimationState extends FlxState {
		[Embed(source="Intro.swf")]
		private static var Animacion : Class;
		private var animacion : MovieClip;
		private var count : Number = 0;
		protected var back : FlxSprite = new FlxSprite(0, 0);
		protected var back1 : FlxSprite = new FlxSprite(0, 0);

		override public function create() : void {
			animacion = new Animacion();
			back.loadGraphic(Assets.salvar, false, false, 800, 400, false);
			back1.loadGraphic(Assets.salvarc, false, false, 800, 400, false);
			// animacion.play();
			FlxG.stage.addChildAt(animacion, 1);
		}

		public override function update() : void {
			super.update();
			count++;
			if (count == 1270 ) {
				FlxG.stage.removeChildAt(1);
				this.add(back);
			} else {
				if (count == 1300 ) {
					this.add(back1);
				}
				if (FlxG.keys.any() && count>1300) {
					FlxG.switchState(new AreaUno());
				}
			}
		}
	}
}