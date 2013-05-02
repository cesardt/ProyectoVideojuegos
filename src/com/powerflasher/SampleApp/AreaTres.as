package com.powerflasher.SampleApp {
	import org.Assets;
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
			astrid = new Astrid(70,4256);

			agua = new FlxTilemap();
			piso = new FlxTilemap();
			cielo = new FlxTilemap();
			fondo = new FlxTilemap();
			plataforma = new FlxTilemap();

			agua.loadMap(new Assets.aguaCSV(), Assets.tilesa3, 32, 32);
			piso.loadMap(new Assets.pisoCSV2(), Assets.tilesa3, 32, 32);
			cielo.loadMap(new Assets.cieloCSV(), Assets.tilessky, 32, 32);
			fondo.loadMap(new Assets.fondoCSV(), Assets.tilesa3, 32, 32);
			plataforma.loadMap(new Assets.plataformaCSV(), Assets.tilesa3, 32, 32);

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
			super.create();
		}

		override public function update() : void {
			if (astrid.overlaps(agua)) {
				if (astrid.lado == "der") {
					astrid.play("brincader");
				}
				else if (astrid.lado == "izq") {
					astrid.play("brincaizq");
				}
			}
			super.update();
			FlxG.collide(astrid, piso);
			FlxG.collide(astrid, plataforma);
		}
	}
}
