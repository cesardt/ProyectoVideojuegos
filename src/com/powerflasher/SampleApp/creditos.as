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
		private var text : FlxText;
		private var text1 : FlxText;
		private var text2 : FlxText;
		private var text3 : FlxText;
		private var text4 : FlxText;
		public function creditos() {
			super();	
		}
			override public function create() : void {
				var s : FlxSprite = new FlxSprite();
				// Boton back
				text= new FlxText(FlxG.width / 2, FlxG.height /2 -100, 400, "Boss area 2 y 3 attributed to Heather Lee Harvey, EmeraldActivities.com & http://opengameart.org/users/emerald ");
				text1= new FlxText(FlxG.width / 2, FlxG.height /2-70, 400, "Astrid attributed to Mandi Paugh from http://opengameart.org ");
				text2= new FlxText(FlxG.width / 2, FlxG.height /2-40, 400, "Soldados http://home.scarlet.be/~lw039750/");
				text3= new FlxText(FlxG.width / 2, FlxG.height /2 -10, 400, "Murcielago www.deviantart.com Fondos http://opengameart.org y www.deviantart.com");
				text4= new FlxText(FlxG.width / 2, FlxG.height /2 +20, 400, "Music:  “Many Happy Returns” by Tom7");
		
				var backb : FlxButton = new FlxButton(FlxG.width / 4 - 60, FlxG.height / 4 + 70, "Back", back);
	
				s.makeGraphic(FlxG.width, FlxG.height, 0x000000);
				// FlxG.bgColor = 0x00000000;
				add(s);
				add(text);
				add(text1);
				add(text2);
				add(text3);
				add(text4);
				add(backb);
			}
			
			private function back() : void {
			FlxG.switchState(new Inicio());
			}
			
	}
}
