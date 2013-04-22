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
		
		
		[Embed(source = "Tiles_mapa1.png")] public var mapaPNG:Class;
		[Embed(source = "mapCSV_Group2_Pasto.csv" , mimeType="application/octet-stream")] public var mapaCSV:Class;
		[Embed(source = "agua.png")] public var mapaPNG1:Class;
		[Embed(source = "mapCSV_Group2_Map1.csv" , mimeType="application/octet-stream")] public var mapaCSV1:Class;
		[Embed(source = "mapCSV_Group2_Items.csv" , mimeType="application/octet-stream")] public var mapaCSV2:Class;
		[Embed(source = "item.png")] public var itemsPNG:Class;
		[Embed(source = "barras.png")] public var mapaPNG2:Class;
		[Embed(source = "mapCSV_Group2_Map4.csv" , mimeType="application/octet-stream")] public var mapaCSV3:Class;
		[Embed(source = "Sky.png")] public var fondo:Class;
		[Embed(source = "mapCSV_Group2_Fondo.csv" , mimeType="application/octet-stream")] public var mapaCSV4:Class;
		[Embed(source = "puertatile.png")] public var puertaPNG:Class;
		[Embed(source = "mapCSV_Group2_Puerta.csv" , mimeType="application/octet-stream")] public var mapaCSV5:Class;
		
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
		private var player:Astrid;
		private var level:AreaUno;
		private var doubleJump:Boolean;
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
		   astrid.lado="der"
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
		   
			add(mapa5);
		   	add(mapa4);
			add(agua);
			add(puerta);
		 	 add(mapaPrincipal);
		   	add(astrid);
		   
		   //inicializa el grupo de items, del mapa al grupo
		   parseItems();
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
						trace(totalItems)
					}
				}
				
			}
			//trace("total de items: "+ totalItems);
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
		FlxG.collide(astrid,mapaPrincipal);
		FlxG.collide(astrid,mapa4);
		FlxG.collide(astrid,agua);
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
