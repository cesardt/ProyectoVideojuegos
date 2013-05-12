package com.powerflasher.SampleApp
{
	import org.flixel.*;
 
	public class saveGame
	{
		public var _save:FlxSave; 
		public var _loaded:Boolean = false; 
		
		public function load():void
		{
			_save = new FlxSave();
			_loaded = _save.bind("LocalSharedObjectName");
			
			if (_save.data.soldados == null) createNewSave();	
		}
		
		public function createNewSave():void
		{
			_save.data.soldados = 0;
			_save.data.area = 1;
			_save.data.items = 0;

			_save.flush();
		}
	}
}