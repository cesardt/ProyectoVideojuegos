package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxSprite;

	public class Items extends FlxSprite
	{
		
		public function Items(X:int, Y:int)
		{
			super(X * 10, Y * 10, Assets.itemsPNG);
			
			solid = true;
		}
		
	}

}
