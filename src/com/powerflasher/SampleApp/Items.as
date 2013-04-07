package com.powerflasher.SampleApp {
	import org.flixel.FlxSprite;

	public class Items extends FlxSprite
	{
		[Embed(source = 'item.png')] private var itemsPNG:Class;
		
		public function Items(X:int, Y:int)
		{
			super(X * 16, Y * 16, itemsPNG);
			
			solid = true;
		}
		
	}

}
