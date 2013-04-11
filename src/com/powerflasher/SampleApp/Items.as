package com.powerflasher.SampleApp {
	import org.flixel.FlxSprite;

	public class Items extends FlxSprite
	{
		[Embed(source = 'item.png')] private var itemsPNG:Class;
		
		public function Items(X:int, Y:int)
		{
			super(X * 10, Y * 10, itemsPNG);
			
			solid = true;
		}
		
	}

}
