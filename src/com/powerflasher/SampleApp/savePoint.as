package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class savePoint extends FlxSprite{
			
		public function savePoint(X:Number,Y:Number):void{
			super(x,y, Assets.fogataSpriteSheet);
			addAnimation("idle",[5],0,true);
			solid = true;
		}
		
		override public function update() :void{
			play("idle");
		}

	}
}