package com.powerflasher.SampleApp {
	import org.flixel.*;
	
	public class saveData{
		private static var _save:FlxSave; //The FlxSave instance
		private static var _tempNiveles:int = 0; //Holds level data if bind() did not work. This is not persitent, and will be deleted when the application ends
		private static var _tempAliados:int = 0;
		private static var _tempItems:int = 0;
		private static var _loaded:Boolean = false; //Did bind() work? Do we have a valid SharedObject?
	
		public static function get areasC():int
		{
			//We only get data from _save if it was loaded properly. Otherwise, use _temp
			if(_loaded)
			{
				return _save.data.areasC;
			}
			else
			{
				return _tempNiveles;
			}
		}
		
		public static function set areasC(value:int):void
		{
			if(_loaded)
			{
				_save.data.areasC = value;
			}
			else
			{
				_tempNiveles = value;
			}
		}
		
		public static function set aliados(value:int):void
		{
			if (_loaded)
			{
				_save.data.aliados = value;
			}
			else
			{
				_tempAliados= value;
			}
		}
		
			public static function set items(value:int):void
		{
			if (_loaded)
			{
				_save.data.items = value;
			}
			else
			{
				_tempItems = value;
			}
		}
		
		
		public static function save(areasS:int, aliadosS:int, itemsS:int):void
		{
			areasC = areasS;
			aliados = aliadosS;
			items = itemsS;
		}
		
		public static function load():void
		{
			_save = new FlxSave();
			_loaded = _save.bind("GameData");
			if (_loaded && _save.data.areasC == null)
			{
				_save.data.areasC = 0;
				_save.data.aliados = 0;
				_save.data.items = 0;
			}
		}
		
		public static function delSave():void
		{
				areasC = 0;
				aliados = 0;
				items = 0;
		}
	}
}