package com.powerflasher.SampleApp{
	import org.flixel.FlxButton;
	/**
	 * @author ieiomeli
	 */
	
	import flash.events.MouseEvent;
 
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
	
	public class Inicio extends FlxState{
		
		
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
			
 
    	
 			texto=new FlxText(0, 300, FlxG.width, "Al infinito").setFormat(null, 21, 0xFFFFFF, "center");
         
           add(texto);
		   
		   
		 var botonInicio:FlxButton =  new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 - 60, "Start Game!", Iniciar);
			add(botonInicio);
		}

		private function Iniciar() : void {
<<<<<<< HEAD
			FlxG.switchState(new AreaUno());
=======
			FlxG.switchState(new AreaTres());
>>>>>>> Soldados everywhere!
		}

		
		
		
		
		override public function update():void
    {
       
        super.update();
    }
		
	}
}
