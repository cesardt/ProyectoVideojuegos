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
		private static var _health : Number=100;
		public static var save:saveGame = new saveGame();
		protected var Music:FlxSound = new FlxSound();
		
		protected var back:FlxSprite = new FlxSprite(0, 0);
		
		
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
			back.loadGraphic(Assets.InicioAstrid, false, false, 800, 400, false);
			this.add(back);
			FlxG.music = Music;
			FlxG.playMusic(Assets.Music);
			
 	
 			//texto=new FlxText(0, 300, FlxG.width, "Astrid's Revenge").setFormat(null, 21, 0xFFFFFF, "center");
         
           //add(texto);
		   
		   
		 	var botonInicio:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 +40, "Start Game!", Iniciar);
			add(botonInicio);
			
			var botonCargar:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 +70 , "Continue", Cargar);
			add(botonCargar);
		}

		private function Iniciar() : void {
			FlxG.switchState(new AreaUno());
		}

		private function Cargar() : void{
			save.load();
			_numitems = Inicio.save._save.data.items;
			_soldados = Inicio.save._save.data.soldados;
			var area:int = Inicio.save._save.data.area;
			
			if( area == 2){
				FlxG.switchState(new AreaDos());
			}
			else if( area == 3){
				FlxG.switchState(new AreaDos());
			}
			else{
				FlxG.switchState(new AreaUno());
			}
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
		
		public static function get health() : Number {
			return _health;
		}
		public static function set health(vidas:Number):void {
			_health=health;
		}
		
	}
}
