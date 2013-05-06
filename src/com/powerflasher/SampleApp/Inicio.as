package com.powerflasher.SampleApp {
	import org.Assets;
	import org.flixel.FlxSound;
	import org.flixel.FlxButton;
	
	import flash.events.MouseEvent;
 
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
	
	public class Inicio extends FlxState {
		private static var _numitems : Number=0;
		private static var _vidas : Number=3;
		private static var _soldados : Number=0;
		protected var Music:FlxSound = new FlxSound();
		
		
		private var texto:FlxText;
		 public function Inicio()
        {
            super();
        }
		
		
		 override public function create():void
        {
            var s:FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x000000);
            add(s);
			FlxG.music = Music;
			FlxG.playMusic(Assets.Music);
			
 	
 			texto=new FlxText(0, 300, FlxG.width, "Astrid's Revenge").setFormat(null, 21, 0xFFFFFF, "center");
         
           add(texto);
		   
		   
		 var botonInicio:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 60, "Start Game!", Iniciar);
			add(botonInicio);
		}

		private function Iniciar() : void {
			FlxG.switchState(new AreaUno());
		}

		
		
		
		
		override public function update():void
    {
       
        super.update();
		}

		public static function get numitems() : Number {
			return _numitems;
		}
		public static function set numitems(items:Number):void {
			_numitems=items;
		}
		public static function get soldados() : Number {
			return _soldados;
		}
		public static function set soldados(soldados:Number):void {
			_soldados=soldados;
		}
		public static function get vidas() : Number {
			return _vidas;
		}
		public static function set vidas(vidas:Number):void {
			_vidas=vidas;
		}
		
	}
}
