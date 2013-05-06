package com.powerflasher.SampleApp{
import org.flixel.FlxGame;


  [SWF(width="800", height="400", backgroundColor="#FFFFFF")]
	public class Flixel extends FlxGame {
		public function Flixel() {
			
			super(800, 400, Inicio, 1, 60 ,30 ,true );
			saveData.load();
		}
	}
}
