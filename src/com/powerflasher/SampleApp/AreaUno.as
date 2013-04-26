package com.powerflasher.SampleApp {
	import flashx.textLayout.utils.HitTestArea;
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

	public class AreaUno extends FlxState {
		
		
		[Embed(source = "Area1/Tiles_mapa1.png")] public var mapaPNG:Class;
		[Embed(source = "Area1/mapCSV_Group2_Pasto.csv" , mimeType="application/octet-stream")] public var mapaCSV:Class;
		[Embed(source = "Area1/agua.png")] public var mapaPNG1:Class;
		[Embed(source = "Area1/mapCSV_Group2_Map1.csv" , mimeType="application/octet-stream")] public var mapaCSV1:Class;
		[Embed(source = "Area1/mapCSV_Group2_Items.csv" , mimeType="application/octet-stream")] public var mapaCSV2:Class;
		[Embed(source = "Area1/item.png")] public var itemsPNG:Class;
		[Embed(source = "Area1/mapCSV_Group2_Bats.csv" , mimeType="application/octet-stream")] public var mapaBats:Class;
		[Embed(source = "Area1/Bat.png")] public var batSpriteSheet:Class;
		[Embed(source = "Area1/barras.png")] public var mapaPNG2:Class;
		[Embed(source = "Area1/mapCSV_Group2_Map4.csv" , mimeType="application/octet-stream")] public var mapaCSV3:Class;
		[Embed(source = "Area1/Sky.png")] public var fondo:Class;
		[Embed(source = "Area1/mapCSV_Group2_Fondo.csv" , mimeType="application/octet-stream")] public var mapaCSV4:Class;
		[Embed(source = "Area1/puertatile.png")] public var puertaPNG:Class;
		[Embed(source = "Area1/mapCSV_Group2_Puerta.csv" , mimeType="application/octet-stream")] public var mapaCSV5:Class;
		
		private var texto:FlxText;
		private var astrid:Astrid;
		private var mapaPrincipal:FlxTilemap;
		private var agua:FlxTilemap;
		private var barras:FlxTilemap;
		private var mapa4:FlxTilemap;
		private var mapa5:FlxTilemap;
		private var puerta:FlxTilemap;
		private var item:FlxTile;
		
		//varibles para recoger items
		public var items:FlxGroup;
		public var totalItems:int;
		private var score:FlxText;
		
		//varibles para enemigos
		public var enemigos:FlxGroup;
		public var totalEnemigos:int;
		private var scoreE:FlxText;
		
		private var player:Astrid;
		private var level:AreaUno;
		public var enemies:FlxGroup;
		
		
		 public function AreaUno()
        {
			super();
        }
		
		
		 override public function create():void
        {
			var s:FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
            add(s);
		   astrid=new Astrid();
		   astrid.lado="der";
		   mapaPrincipal=new FlxTilemap();
		   agua=new FlxTilemap();
		   //mapa3=new FlxTilemap();
		   mapa4=new FlxTilemap();
		   mapa5=new FlxTilemap();
		   puerta=new FlxTilemap();
		   item=new FlxTile(barras, 2, 10, 10, true,1);
		   mapa5.loadMap(new mapaCSV4(),fondo,31,28);
		   mapaPrincipal.loadMap(new mapaCSV(),mapaPNG,31,28);
		   
		   agua.loadMap(new mapaCSV1(), mapaPNG1,31,28);
		   mapa4.loadMap(new mapaCSV3(), mapaPNG2,31,14);
		   mapa4.setTileProperties(1,FlxObject.UP);
		   puerta.loadMap(new mapaCSV5(), puertaPNG,31,14);
		   agua.setTileProperties(5,FlxObject.UP);
		 
		   
		   
		  //atributos del score
		    score = new FlxText(0, 0, 100);
			score.color = 0xffffffff;
			score.shadow = 0xff000000;
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
			 
		//atributos del scoreEnemigo
		    scoreE = new FlxText(0, 15, 100);
			scoreE.color = 0xffffffff;
			scoreE.shadow = 0xff000000;
			scoreE.scrollFactor.x = 0;
			scoreE.scrollFactor.y = 0;
		   
			add(mapa5);
		   	add(mapa4);
			add(agua);
			add(puerta);
		 	 add(mapaPrincipal);
		   	add(astrid);
		   
		   //inicializa el grupo de items, del mapa al grupo
		   parseItems();
		   //inicializa el grupo de enemigos, del mapa al grupo
		   parseEnemigos();
		   
		    //agrega items y el score,  conteo de enemigos
		   add(enemigos);
		   add(scoreE);
		   scoreE.text = "0 / " + totalEnemigos.toString();
		   
		   //agrega items y el score,  conteo
		   add(items);
		   add(score);
		   score.text = "0 / " + totalItems.toString();
		   
		  
		   
		  
		   //de la camara
		   FlxG.camera.setBounds(0,0,2670,992,false);
		   FlxG.worldBounds=new FlxRect(0,0,2670,992);
		   FlxG.camera.follow(astrid);
		   
		}
		private function parseItems():void
		{
			var itemsMap:FlxTilemap = new FlxTilemap();
			
			itemsMap.loadMap(new mapaCSV2(), itemsPNG, 10, 10);
			
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
		   				
		private function parseEnemigos():void
		{
			var enemigoMap:FlxTilemap = new FlxTilemap();
			
			enemigoMap.loadMap(new mapaBats(), batSpriteSheet, 24, 24);
			
			enemigos = new FlxGroup();
			
			for (var ty:int = 0; ty < enemigoMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < enemigoMap.widthInTiles; tx++)
				{
					if (enemigoMap.getTile(tx, ty) == 3)
					{
						enemigos.add(new Murcielago(tx, ty, astrid));
						totalEnemigos++;
						trace(totalEnemigos);
					}
				}
			}
		}
		
	
		
	override public function update():void {
		if(FlxG.keys.justPressed("UP") && FlxG.collide(astrid,puerta)){
			astrid.lado="izq";
			FlxG.switchState(new AreaDos());
				
		}
		super.update();
		FlxG.collide(astrid,mapaPrincipal);
		FlxG.collide(astrid,mapa4);
		FlxG.collide(astrid,agua);
    	FlxG.overlap(astrid, items, hitItems);
		//overlap enemigos
		FlxG.overlap(astrid, enemigos, hitEnemigos);
		
    }
	private function hitItems(p:FlxObject, item:FlxObject):void
		{
			//trace("colapse");
			item.kill();
			FlxG.score += 1;
			score.text = FlxG.score.toString() + " / " + totalItems.toString();
		}
		private function hitEnemigos(p:FlxObject, enemigo:FlxObject):void
		{
			//trace("colapse");
			enemigo.kill();
			FlxG.score += 1;
			scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
		}
		
	}
}
