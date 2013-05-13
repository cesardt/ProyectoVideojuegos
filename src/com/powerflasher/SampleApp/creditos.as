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
	
		public function creditos() {
			super();	
		}
			override public function create() : void {
				var s : FlxSprite = new FlxSprite();
				// Boton back
				text= new FlxText(FlxG.width / 2, FlxG.height /2 -100, 100, "Boss area 2 y 3 attributed to Heather Lee Harvey, if possible I would also like a link to EmeraldActivities.com & http://opengameart.org/users/emerald ");
				text1= new FlxText(FlxG.width / 2, FlxG.height /2+10, 100, "Astrid attributed to Mandi Paugh from http://opengameart.org ");
				text2= new FlxText(FlxG.width / 2, FlxG.height /2+60, 100, "Soldados http://home.scarlet.be/~lw039750/");
				text3= new FlxText(FlxG.width / 2, FlxG.height /2 +100, 100, "Murcielago www.deviantart.com Fondos http://opengameart.org y www.deviantart.com");
				
		
				var backb : FlxButton = new FlxButton(FlxG.width / 4 - 60, FlxG.height / 4 + 70, "Back", back);
	
				s.makeGraphic(FlxG.width, FlxG.height, 0x000000);
				// FlxG.bgColor = 0x00000000;
				add(s);
				add(text);
				add(text1);
				add(text2);
				add(text3);
				
				add(backb);
			}
			
			private function back() : void {
			FlxG.switchState(new Inicio());
			}
			
	}
}
