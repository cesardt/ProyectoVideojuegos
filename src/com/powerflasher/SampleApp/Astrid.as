package  com.powerflasher.SampleApp{
	import org.flixel.FlxSprite;
	/**
	 * @author ieiomeli
	 */
	 
	public class Astrid extends FlxSprite{
		
		[Embed(source = "Astrid/tilesmedastrid.png")] public static var jugadorSpriteSheet:Class;

		
		var lado:String;
		protected var jump:int;
		public function Astrid()

		{
		var runV:uint = 80;
		super(150,570);
		frame=3;
			
		velocity.y=10;
		offset.x = 0;
		offset.y = 0;
		drag.x = runV * 8;
		jump = 200;
		maxVelocity.x = runV;
		maxVelocity.y = jump;
		acceleration.y = 450;
		loadGraphic(jugadorSpriteSheet, true, true, 24, 36, true);
		addAnimation("izquierda",[3,4,5],15,false);
		addAnimation("derecha", [0,1,2],15,false);
		addAnimation("brincader",[9],10,true);
		addAnimation("brincaizq",[6],10,true);
		addAnimation("nobrincaizq",[7],5,true);
		addAnimation("nobrincader",[8],5,true);
		addAnimation("ataqueizq",[11,10],4,false);
		addAnimation("ataqueder",[13,12],4,false);
		addAnimation("enredadera",[14,15],4,false);
		

		

		}
	}
}
