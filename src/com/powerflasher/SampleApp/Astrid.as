package  com.powerflasher.SampleApp{
	import org.flixel.FlxSprite;
	/**
	 * @author ieiomeli
	 */
	public class Astrid extends FlxSprite{
		
		[Embed(source = "monitaXpeq.png")] public static var jugadorSpriteSheet:Class;
		
		
		protected var jump:int;
		public function Astrid()

		{
		var runV:uint = 100;
		super(150,570);
		frame=3;
			
		velocity.y=10;
		offset.x = 0;
		offset.y = 0;
		drag.x = runV * 8;
		jump = 200;
		maxVelocity.x = runV;
		acceleration.y = 420;
		maxVelocity.y = jump;
		loadGraphic(jugadorSpriteSheet, true, true, 16, 24, true);
		addAnimation("izquierda",[3,4,5],15,false);
		addAnimation("derecha", [0,1,2],15,false);

		

		}
	}
}
