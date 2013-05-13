package com.powerflasher.SampleApp {
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
	/**
	 * @author arantxaviladomat
	 */
	public class score extends FlxState {
		private var actual : Number = 0;
		private var user : String = "";
		private var maxsc : FlxText;

		public function score(puntaje: Number) {
			super();
			actual=puntaje;
		}
			override public function create() : void {
				var s : FlxSprite = new FlxSprite();
				// Boton back
				maxsc= new FlxText(FlxG.width / 2, FlxG.height / 2, 100, "MAXSCORE: ");
				maxsc.text="MAXSCORE: " + actual;
				var backb : FlxButton = new FlxButton(FlxG.width / 4 - 60, FlxG.height / 4 + 70, "Back", back);
	
				s.makeGraphic(FlxG.width, FlxG.height, 0x000000);
				// FlxG.bgColor = 0x00000000;
				add(s);
				add(maxsc);
				add(backb);
			}
			
			private function back() : void {
			FlxG.switchState(new Inicio());
		}
			
	}
}
