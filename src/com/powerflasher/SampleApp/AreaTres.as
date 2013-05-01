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

	public class AreaTres extends FlxState {
		[Embed(source = "Area3/TilesA3.png")]
		public var tilesa3 : Class;
		[Embed(source = "Area3/Sky.png")]
		public var tilessky : Class;
		[Embed(source = "Area3/mapCSV_Group1_Agua.csv" , mimeType="application/octet-stream")]
		public var aguaCSV : Class;
		[Embed(source = "Area3/mapCSV_Group1_Cielo.csv" , mimeType="application/octet-stream")]
		public var cieloCSV : Class;
		[Embed(source = "Area3/mapCSV_Group1_FondoCastillo.csv" , mimeType="application/octet-stream")]
		public var fondoCSV : Class;
		[Embed(source = "Area3/mapCSV_Group1_Plataformas.csv" , mimeType="application/octet-stream")]
		public var plataformaCSV : Class;
		[Embed(source = "Area3/Pared.csv" , mimeType="application/octet-stream")]
		public var pisoCSV : Class;
		private var astrid : Astrid;
		private var agua : FlxTilemap;
		private var cielo : FlxTilemap;
		private var fondo : FlxTilemap;
		private var plataforma : FlxTilemap;
		private var piso : FlxTilemap;
		private var doubleJump : Boolean;

		public function AreaTres() {
			super();
		}

		override public function create() : void {
			var s : FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
			add(s);
			astrid = new Astrid();
			astrid.x = 70;
			astrid.y = 4256;
			astrid.lado = "der";

			agua = new FlxTilemap();
			piso = new FlxTilemap();
			cielo = new FlxTilemap();
			fondo = new FlxTilemap();
			plataforma = new FlxTilemap();

			agua.loadMap(new aguaCSV(), tilesa3, 32, 32);
			piso.loadMap(new pisoCSV(), tilesa3, 32, 32);
			cielo.loadMap(new cieloCSV(), tilessky, 32, 32);
			fondo.loadMap(new fondoCSV(), tilesa3, 32, 32);
			plataforma.loadMap(new plataformaCSV(), tilesa3, 32, 32);

			plataforma.setTileProperties(5, FlxObject.UP);
			plataforma.setTileProperties(6, FlxObject.UP);

			add(cielo);
			add(fondo);
			add(piso);
			add(plataforma);
			add(astrid);
			add(agua);

			// de la camara
			FlxG.camera.setBounds(0, 2496, 2592, 4800, false);
			FlxG.worldBounds = new FlxRect(0, 2496, 2592, 4800);
			FlxG.camera.follow(astrid);
		}

		override public function update() : void {
			/*if(astrid.overlaps(puerta)){
			FlxG.switchState(new AreaTres());
			}
			 */
			if (astrid.overlaps(agua)) {
				if (astrid.lado = "der") {
					astrid.play("brincader");
				}
				if (astrid.lado = "izq") {
					astrid.play("brincaizq");
				}
			}
			super.update();
			FlxG.collide(astrid, piso);
			FlxG.collide(astrid, plataforma);
		}
	}
}
