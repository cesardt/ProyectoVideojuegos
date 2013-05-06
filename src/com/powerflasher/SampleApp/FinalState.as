package com.powerflasher.SampleApp {
	import org.flixel.FlxSave;
	import org.Assets;
	import org.flixel.FlxSound;
	import org.flixel.FlxButton;
	
	import flash.events.MouseEvent;
 
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
	
	public class FinalState extends FlxState {
		
		private var texto:FlxText;
		 public function FinalState()
        {
            super();
        }
		
		
		 override public function create():void
        {
            var s:FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x000000);
            add(s);
			
 			texto=new FlxText(0, 300, FlxG.width, "Ganaste. Tu hermano ha sido liberado, y el imperio ha sido vencido").setFormat(null, 21, 0xFFFFFF, "center");
         
           add(texto);

		}
	}
}