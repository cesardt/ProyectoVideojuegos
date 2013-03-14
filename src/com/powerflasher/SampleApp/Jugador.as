package  com.powerflasher.SampleApp{
	import org.flixel.FlxSprite;
	/**
	 * @author ieiomeli
	 */
	public class Jugador extends FlxSprite{
		
		[Embed(source = "monitaXpeq.png")] public static var jugadorSpriteSheet:Class;
		
		public function Jugador()

		{

		super(150,570);
		frame=3;
		velocity.y=10;
		
		loadGraphic(jugadorSpriteSheet, true, true, 16, 24, true);
		addAnimation("nombre", [0,1,2],10,false);

		

		}
	}
}
