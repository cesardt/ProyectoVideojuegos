package  com.powerflasher.SampleApp{
	import org.flixel.FlxSprite;
	/**
	 * @author ieiomeli
	 */
	public class Astrid extends FlxSprite{
		
		[Embed(source = "monitaXpeq.png")] public static var jugadorSpriteSheet:Class;
		
		public function Astrid()

		{

		super(150,570);
		frame=3;
		velocity.y=10;
		
		loadGraphic(jugadorSpriteSheet, true, true, 16, 24, true);
		addAnimation("izquierda",[3,4,5],15,false);
		addAnimation("derecha", [0,1,2],15,false);

		

		}
	}
}
