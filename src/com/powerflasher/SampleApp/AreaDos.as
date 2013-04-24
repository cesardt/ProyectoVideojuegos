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
		[Embed(source = "Area2/picos.png")] public var tilespicos:Class;
		[Embed(source = "Area2/puerta.png")] public var tilespuerta:Class;
		[Embed(source = "Area2/enredaderas.png")] public var tilesenredadera:Class;
		[Embed(source = "Area2/frente.png")] public var tilesfrente:Class;
		[Embed(source = "Area2/plataformas.png")] public var tilesplataforma:Class;
		[Embed(source = "Area2/piso.png")] public var tilespiso:Class;
		[Embed(source = "Area2/fondos.png")] public var tilesfondos:Class;
		[Embed(source = "Area2/pared.png")] public var tilespared:Class;
		[Embed(source = "Area2/item.png")] public var itemsPNG:Class;
		[Embed(source = "Area2/mapCSV_Group1_Items.csv" , mimeType="application/octet-stream")] public var itemsCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Piso.csv" , mimeType="application/octet-stream")] public var pisoCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Picos.csv" , mimeType="application/octet-stream")] public var picosCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Frente.csv" , mimeType="application/octet-stream")] public var frenteCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Enredaderas.csv" , mimeType="application/octet-stream")] public var enredaderasCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Fondos.csv" , mimeType="application/octet-stream")] public var fondosCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Plataformas.csv" , mimeType="application/octet-stream")] public var plataformasCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Puerta.csv" , mimeType="application/octet-stream")] public var puertaCSV:Class;
		[Embed(source = "Area2/mapCSV_Group1_Pared.csv" , mimeType="application/octet-stream")] public var paredCSV:Class;
		
		
		private var astrid:Astrid;
		private var piso:FlxTilemap;
		private var picos:FlxTilemap;
		private var frente:FlxTilemap;
		private var enredaderas:FlxTilemap;
		private var fondos:FlxTilemap;
		private var pared:FlxTilemap;
		private var plataformas:FlxTilemap;
		private var puerta:FlxTilemap;
		private var doubleJump:Boolean;
		//varibles para recoger items
		public var items:FlxGroup;
		public var totalItems:int;
		private var score:FlxText;
		
		
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
		   pared=new FlxTilemap();
		   fondos=new FlxTilemap();
		   frente=new FlxTilemap();
		   plataformas=new FlxTilemap();
		   enredaderas=new FlxTilemap();
		   picos=new FlxTilemap();
		   puerta=new FlxTilemap();
		   
		   fondos.loadMap(new fondosCSV(),tilesfondos,32,32);
		   pared.loadMap(new paredCSV(),tilespared,32,32);
		   frente.loadMap(new frenteCSV(),tilesfrente,32,32);
		   enredaderas.loadMap(new enredaderasCSV(),tilesenredadera,32,32);
		   picos.loadMap(new picosCSV(),tilespicos,32,32);
		   puerta.loadMap(new puertaCSV(),tilespuerta,32,32);
		   piso.loadMap(new pisoCSV(),tilespiso,32,32);
		   plataformas.loadMap(new plataformasCSV(),tilesplataforma,32,32);
		 
		   
		    plataformas.setTileProperties(1,FlxObject.UP);
			plataformas.setTileProperties(2,FlxObject.UP);
			plataformas.setTileProperties(3,FlxObject.UP);
			plataformas.setTileProperties(4,FlxObject.UP);
			plataformas.setTileProperties(5,FlxObject.UP);
			plataformas.setTileProperties(6,FlxObject.UP);
			plataformas.setTileProperties(7,FlxObject.UP);
			plataformas.setTileProperties(8,FlxObject.UP);
			plataformas.setTileProperties(9,FlxObject.UP);
			
			//atributos del score
		    score = new FlxText(0, 0, 100);
			score.color = 0xffffffff;
			score.shadow = 0xff000000;
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
		    		  	   
			add(piso);
			add(pared);
		   	add(fondos);
			add(plataformas);
		 	add(enredaderas);
			add(picos);
		 	add(puerta);
		   	add(astrid);
			add(frente);
		   //inicializa el grupo de items, del mapa al grupo
		   parseItems();
		   //agrega items y el score,  conteo
		   add(items);
		   add(score);
		   score.text = "0 / " + totalItems.toString();
		   
		   //de la camara
		   FlxG.camera.setBounds(0,0,3200,1600,false);
		   FlxG.worldBounds=new FlxRect(0,0,3200,1600);
		   FlxG.camera.follow(astrid);
		}
		   				
		private function parseItems():void
		{
			var itemsMap:FlxTilemap = new FlxTilemap();
			
			itemsMap.loadMap(new itemsCSV(), itemsPNG, 10, 10);
			
			items = new FlxGroup();
			
			for (var ty:int = 0; ty < itemsMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < itemsMap.widthInTiles; tx++)
				{
					if (itemsMap.getTile(tx, ty) == 1)
					{
						items.add(new Items(tx, ty));
						totalItems++;
						trace(totalItems);
					}
				}
				
			}
			//trace("total de items: "+ totalItems);
		}
		override public function update():void {
		if(FlxG.collide(astrid,enredaderas) && FlxG.keys.pressed("DOWN")){
			astrid.acceleration.y += astrid.drag.y;
			astrid.play("enredadera");
		}
		if(FlxG.keys.justPressed("UP") && FlxG.collide(astrid,puerta)){
			astrid.lado="izq";
			FlxG.switchState(new AreaDos());
				
		}
		if(FlxG.collide(astrid,pared)){
			astrid.velocity.y = -astrid.maxVelocity.y;
		}
		super.update();
			FlxG.collide(astrid,piso);
			FlxG.collide(astrid,plataformas);
			FlxG.overlap(astrid, items, hitItems);
   		 }
		 private function hitItems(p:FlxObject, item:FlxObject):void
		{
			//trace("colapse");
			item.kill();
			FlxG.score += 1;
			score.text = FlxG.score.toString() + " / " + totalItems.toString();
		}
	}
}
