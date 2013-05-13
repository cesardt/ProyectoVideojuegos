package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxSprite;
	
	public class savePoint extends FlxSprite{
			
		public function savePoint(X:Number,Y:Number):void{
			super(X,Y, Assets.fogataSpriteSheet);
			loadGraphic(Assets.fogataSpriteSheet, true, true, 32, 32, true);
			addAnimation("idle",[5],24,true);
		}
		
		override public function update() :void{
			play("idle");
		}

	}
}