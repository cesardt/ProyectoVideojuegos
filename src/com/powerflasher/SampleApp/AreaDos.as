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
		[Embed(source = "dirt-tiles.png")] public var tiles:Class;
		[Embed(source = "mapCSV_Group1_Piso.csv" , mimeType="application/octet-stream")] public var pisoCSV:Class;
		[Embed(source = "mapCSV_Group1_Picos.csv" , mimeType="application/octet-stream")] public var picosCSV:Class;
		[Embed(source = "mapCSV_Group1_Frente.csv" , mimeType="application/octet-stream")] public var frenteCSV:Class;
		[Embed(source = "mapCSV_Group1_Enredaderas.csv" , mimeType="application/octet-stream")] public var enredaderasCSV:Class;
		[Embed(source = "mapCSV_Group1_Fondos.csv" , mimeType="application/octet-stream")] public var fondosCSV:Class;
		[Embed(source = "mapCSV_Group1_Plataformas.csv" , mimeType="application/octet-stream")] public var plataformasCSV:Class;
		[Embed(source = "mapCSV_Group1_Puerta.csv" , mimeType="application/octet-stream")] public var puertaCSV:Class;
		
		
		private var astrid:Astrid;
		private var piso:FlxTilemap;
		private var picos:FlxTilemap;
		private var frente:FlxTilemap;
		private var enredaderas:FlxTilemap;
		private var fondos:FlxTilemap;
		private var plataformas:FlxTilemap;
		private var puerta:FlxTilemap;
		private var doubleJump:Boolean;
		
		
		
		 public function AreaDos(){
            super();
        }
		
		 override public function create():void   {
			var s:FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
            add(s);
			 astrid=new Astrid();
			 astrid.x=3100;
			  astrid.y=70;
			 astrid.lado="izq";
		    
			
		   piso=new FlxTilemap();
		   fondos=new FlxTilemap();
		   frente=new FlxTilemap();
		   plataformas=new FlxTilemap();
		   enredaderas=new FlxTilemap();
		   picos=new FlxTilemap();
		   puerta=new FlxTilemap();
		   fondos.loadMap(new fondosCSV(),tiles,32,32);
		   frente.loadMap(new frenteCSV(),tiles,32,32);
		    enredaderas.loadMap(new enredaderasCSV(),tiles,32,32);
		   picos.loadMap(new picosCSV(),tiles,32,32);
		   puerta.loadMap(new puertaCSV(),tiles,32,32);
		   piso.loadMap(new pisoCSV(),tiles,32,32);
		   plataformas.loadMap(new plataformasCSV(),tiles,32,32);
		 
		   
		    plataformas.setTileProperties(274,FlxObject.UP);
			plataformas.setTileProperties(96,FlxObject.UP);
			plataformas.setTileProperties(97,FlxObject.UP);
			plataformas.setTileProperties(98,FlxObject.UP);
			plataformas.setTileProperties(206,FlxObject.UP);
			plataformas.setTileProperties(203,FlxObject.UP);
			plataformas.setTileProperties(160,FlxObject.UP);
			plataformas.setTileProperties(273,FlxObject.UP);
			plataformas.setTileProperties(301,FlxObject.UP);
			plataformas.setTileProperties(291,FlxObject.UP);
			plataformas.setTileProperties(294,FlxObject.UP);
			
		    		  	   
			add(piso);
		   	add(fondos);
			add(frente);
			add(plataformas);
		 	add(enredaderas);
			add(picos);
		 	add(puerta);
		   	add(astrid);
		   
		   
		   //de la camara
		   FlxG.camera.setBounds(0,0,3200,1600,false);
		   FlxG.worldBounds=new FlxRect(0,0,3200,1600);
		   FlxG.camera.follow(astrid);
		}
		   				
		
		override public function update():void {
			astrid.acceleration.x = 0;
		if(FlxG.keys.justPressed("SPACE") && astrid.isTouching(FlxObject.FLOOR)){
				astrid.velocity.y = -astrid.maxVelocity.y;
				doubleJump=true;
				if(astrid.velocity.y != 0 ){
					if(astrid.lado=="der"){
						astrid.play("brincader");
					}
					if(astrid.lado=="izq"){
						astrid.play("brincaizq");
					}
				}
		}
		if(FlxG.keys.justPressed("X") && astrid.lado=="izq"){
				astrid.play("ataqueizq");
		}
		if(FlxG.keys.justPressed("X") && astrid.lado=="der"){
				astrid.play("ataqueder");
		}
		if(FlxG.keys.pressed("RIGHT")){
			astrid.acceleration.x += astrid.drag.x;
			astrid.lado="der";
			if(astrid.velocity.y == 0 && !FlxG.keys.pressed("X")){
				astrid.play("derecha");
			}
		}
		if(FlxG.keys.pressed("LEFT")){
			astrid.acceleration.x -= astrid.drag.x;
			astrid.lado="izq";
			if(astrid.velocity.y == 0 && !FlxG.keys.pressed("X")){
				astrid.play("izquierda");
			}
		}
		if(FlxG.keys.pressed("DOWN")){
			
		}
		if(FlxG.keys.justPressed("UP") && FlxG.collide(astrid,puerta)){
			FlxG.switchState(new AreaDos());
				
		}
		if(FlxG.keys.justPressed("SPACE") && FlxG.score >0 && !astrid.isTouching(FlxObject.FLOOR) && doubleJump==true){
				astrid.velocity.y= -astrid.maxVelocity.y;	
				doubleJump=false;
		}
		if(astrid.justTouched(FlxObject.FLOOR)&& astrid.lado=="izq"){
				astrid.play("nobrincaizq");
		}
		if(astrid.justTouched(FlxObject.FLOOR)&& astrid.lado=="der"){
				astrid.play("nobrincader");
		}
		super.update();
			FlxG.collide(astrid,piso);
			FlxG.collide(astrid,plataformas);
   		 }
	}
}
