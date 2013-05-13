package com.powerflasher.SampleApp {
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
	/**
	 * @author arantxaviladomat
	 */
	public class creditos extends FlxState {
		private var maxsc : FlxText;

		public function creditos() {
			super();
			
		}
			override public function create() : void {
				var s : FlxSprite = new FlxSprite();
				// Boton back
				maxsc= new FlxText(FlxG.width / 2, FlxG.height / 2, 100, "MAXSCORE: ");
				maxsc.text="Boss area 2 y 3 attributed to Heather Lee Harvey, if possible I would also like a link to EmeraldActivities.com & http://opengameart.org/users/emerald
Astrid attributed to Mandi Paugh from http://opengameart.org
Soldados http://home.scarlet.be/~lw039750/
Murcielago www.deviantart.com
Fondos http://opengameart.org y www.deviantart.com";
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
