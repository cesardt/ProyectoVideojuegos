
package  com.powerflasher.SampleApp{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class Murcielago extends FlxSprite{
		
		private var _player:FlxSprite;  
		private var _move_speed:int = 200;
		[Embed(source = "Area1/Bat.png")] public static var batSpriteSheet:Class;
		
		public function Murcielago(X:Number,Y:Number,ThePlayer:FlxSprite):void{
			
			super(X*24,Y*24, batSpriteSheet);
			_player = ThePlayer;
			health = 1;
			maxVelocity.x = 200;
            maxVelocity.y = 200;
			loadGraphic(batSpriteSheet, true, true, 24, 24, true);
			addAnimation("idle",[3], 0,false);
			addAnimation("volar",[0,1,2], 15, false);
			
		}
		
		  override public function update():void{
			
				var dify:int = y - _player.y;
			
			if(y - _player.y < 50 && y - _player.y > 20){
				
				if(_player.x - x < 20){
					facing = LEFT;
					velocity.x -= _move_speed;
					velocity.y = -Math.log(FlxG.elapsed)* dify/10 ;
				}
				else if(_player.x - x > 20){
					facing = RIGHT;
					velocity.x += _move_speed;
					velocity.y = -Math.log(FlxG.elapsed)*dify/20;
				}
			}
			
			/*if(Math.abs(_player.x - x)<100 && Math.abs(_player.y - y)>40){
				 if(_player.x < x)
            {
                facing = LEFT;
                velocity.x -= _move_speed;
				velocity.y = -Math.log(FlxG.elapsed)*20;
            }
            else if(Math.abs(_player.x - x)>100 && Math.abs(_player.y - y)>40)
            {
                facing = RIGHT;
                velocity.x += _move_speed; 
				velocity.y = -Math.log(FlxG.elapsed)*20;            
            }
			}*/
			
			
			if(velocity.x != 0){
				play("volar");
			}
			else{
				play("idle");
			}
		  }

	}
}