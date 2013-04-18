
package  com.powerflasher.SampleApp{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Murcielago extends FlxSprite{
		
		private var _player:FlxSprite;  
		 private var _move_speed:int = 400;
		[Embed(source = "Bat.png")] public static var batSpriteSheet:Class;
		
		public function Murcielago(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X,Y);
			_player = ThePlayer;
			health = 1;
			maxVelocity.x = 200;
            maxVelocity.y = 200;
			loadGraphic(batSpriteSheet, true, true, 24, 24, true);
			addAnimation("idle",[3], 0,false);
			addAnimation("volar",[0,1,2], 15, false);
			
		}
		
		  override public function update():void{
			
			if(Math.abs(_player.x - x)<30 && Math.abs(_player.y - y)<30){
				 if(_player.x < x)
            {
                facing = LEFT;
                velocity.x -= _move_speed;
				velocity.y = -Math.log(FlxG.elapsed);
            }
            else
            {
                facing = RIGHT;
                velocity.x += _move_speed; 
				velocity.y = -Math.log(FlxG.elapsed);            
            }
			}
			
			
			if(velocity.x != 0){
				play("volar");
			}
			else{
				play("idle");
			}
		  }

	}
}