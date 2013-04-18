
package  com.powerflasher.SampleApp{
	import org.flixel.FlxSprite;
	public class Murcielago extends FlxSprite{
		
		[Embed(source = "Bat.png")] public static var batSpriteSheet:Class;
		
		public function Bat(){
			
			loadGraphic(batSpriteSheet, true, true, 24, 24, true);
			addAnimation("idle",[3], 0,false);
			addAnimation("volar",[0,1,2], 15, false);
			
		}

	}
}