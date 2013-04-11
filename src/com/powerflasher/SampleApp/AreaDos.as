package com.powerflasher.SampleApp {
	import org.flixel.FlxGroup;
	import org.flixel.system.FlxTile;
	import org.flixel.FlxObject;
	import org.flixel.FlxRect;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxState;

	public class AreaDos extends FlxState {
		
		 public function AreaDos(){
            super();
        }
		
		 override public function create():void   {
			var s:FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
            add(s);
		   
		   //de la camara
		   FlxG.camera.setBounds(0,0,2670,992,false);
		   FlxG.worldBounds=new FlxRect(0,0,2670,992);
		   
		}
		   				
		
		override public function update():void {
			super.update();
   		 }
	}
}
