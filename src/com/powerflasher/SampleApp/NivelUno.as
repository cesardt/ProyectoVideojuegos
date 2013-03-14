package com.powerflasher.SampleApp {
	import org.flixel.FlxTilemap;
	import org.flixel.FlxTileblock;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxState;

	public class NivelUno extends FlxState {
		
		[Embed(source = "Grass_tiles2.png")] public var mapaPNG:Class;
		[Embed(source = "mapCSV_Group2_Pasto.csv" , mimeType="application/octet-stream")] public var mapaCSV:Class;
		
		private var texto:FlxText;
		private var mario:Jugador;
		private var piso:FlxTileblock;
		private var mapa:FlxTilemap;
		
		 public function NivelUno()
        {
            super();
        }
		
		
		 override public function create():void
        {
            var s:FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
            add(s);
			
 
    
 			texto=new FlxText(0, 300, FlxG.width, "Al infinito").setFormat(null, 21, 0xFFFFFF, "center");
         
           add(texto);
		   mario=new Jugador();
		   add(mario);
		   
		  // piso=new FlxTileblock(0, 130, 100, 30);
		   //piso.makeGraphic(100, 5);
		   //add(piso);
		   mapa=new FlxTilemap();
		   mapa.loadMap(new mapaCSV(), mapaPNG,31,28);
		   add(mapa);
		   
		   
		   FlxG.camera.follow(mario);
		}
		   				
		
	override public function update():void {
       	texto.x++;
	    super.update();
		if(FlxG.keys.pressed("RIGHT")){
			mario.x+=1;
			mario.play("nombre");
			//mario.play("show");
		}
		if(FlxG.keys.pressed("LEFT")){
			mario.x-=1;
			mario.play("nombre2");
		}
		if(FlxG.keys.pressed("DOWN")){
			mario.y+=1;
			//mario.play("show");
		}
		if(FlxG.keys.pressed("UP")){
			mario.y-=1;
		}
		if(FlxG.keys.pressed("SPACE")){
			mario.y-=4;
			mario.play("nombre");
			//mario.play("show");
		}
		FlxG.collide(mario,mapa);
    }
		
	}
}
