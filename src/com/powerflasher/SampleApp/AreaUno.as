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

	public class AreaUno extends FlxState {
		
		//Prueba de sync
		
		[Embed(source = "Grass_tiles2.png")] public var mapaPNG:Class;
		[Embed(source = "mapCSV_Group2_Pasto.csv" , mimeType="application/octet-stream")] public var mapaCSV:Class;
		[Embed(source = "Tiles.png")] public var mapaPNG1:Class;
		[Embed(source = "mapCSV_Group2_Map1.csv" , mimeType="application/octet-stream")] public var mapaCSV1:Class;
		[Embed(source = "item.png")] public var mapaPNG2:Class;
		[Embed(source = "mapCSV_Group2_Items.csv" , mimeType="application/octet-stream")] public var mapaCSV2:Class;
		
		private var texto:FlxText;
		private var astrid:Astrid;
		private var mapa:FlxTilemap;
		private var mapa2:FlxTilemap;
		private var mapa3:FlxTilemap;
		private var item:FlxTile;
		//varibles àra recoger items
		public var items:FlxGroup;
		public var totalItems:int;
		private var player:Astrid;
		private var level:AreaUno;
		private var score:FlxText;
		
		
		 public function AreaUno()
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
		   astrid=new Astrid();
		   
		   mapa=new FlxTilemap();
		   mapa2=new FlxTilemap();
		   mapa3=new FlxTilemap();
		   item=new FlxTile(mapa3, 2, 10, 10, true,1);
		   mapa.loadMap(new mapaCSV(), mapaPNG,31,28);
		   mapa.setTileProperties(6,FlxObject.UP);
		   
		   add(mapa);
		   mapa2.loadMap(new mapaCSV1(), mapaPNG1,31,28);
		   add(mapa2);
		   mapa3.loadMap(new mapaCSV2(), mapaPNG2,10,10);
		   
		   
		   score = new FlxText(0, 0, 100);
			score.color = 0xffffffff;
			score.shadow = 0xff000000;
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
//			score.text = "0 / " + level.totalItems.toString();
		   add(mapa3);
		   add(astrid);
		   add(score);
		   
		   parseItems();
		   
		  FlxG.camera.setBounds(0,0,2670,730,false);
		   FlxG.worldBounds=new FlxRect(0,0,2670,730);
		   FlxG.camera.follow(astrid);
		   
		}
		   				
		private function parseItems():void
		{
			var itemsMap:FlxTilemap = new FlxTilemap();
			
			itemsMap.loadMap(new mapaCSV2(), mapaPNG2, 16, 16);
			
			items = new FlxGroup();
			
			for (var ty:int = 0; ty < itemsMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < itemsMap.widthInTiles; tx++)
				{
					if (itemsMap.getTile(tx, ty) == 1)
					{
						items.add(new Items(tx, ty));
						totalItems++;
					}
				}
			}
		}
		
	
		
	override public function update():void {
	    super.update();
		 
		
		astrid.velocity.y=30;
		astrid.acceleration.y+=10;
		if(FlxG.keys.pressed("RIGHT")){
			astrid.x+=2;
			astrid.play("derecha");
		}
		if(FlxG.keys.pressed("LEFT")){
			astrid.x-=2;
			astrid.play("izquierda");
		}
		if(FlxG.keys.pressed("DOWN")){
			
		}
		if(FlxG.keys.pressed("UP")){
			
		}
		if(FlxG.keys.justPressed("SPACE")){
			astrid.y-=40;
			astrid.acceleration.y-=20;
		}
		FlxG.collide(astrid,mapa);
    }
		
	}
}
