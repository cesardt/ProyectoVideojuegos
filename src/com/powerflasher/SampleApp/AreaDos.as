package com.powerflasher.SampleApp {
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.Assets;
	import org.flixel.FlxBasic;
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
		private var astrid : Astrid;
		private var piso : FlxTilemap;
		private var picos : FlxTilemap;
		private var frente : FlxTilemap;
		private var enredaderas : FlxTilemap;
		private var fondos : FlxTilemap;
		private var pared : FlxTilemap;
		private var plataformas : FlxTilemap;
		private var puerta : FlxTilemap;
		private var atras : FlxTilemap;
		private var doubleJump : Boolean;
		// varibles para recoger items
		public var items : FlxGroup;
		public var totalItems : int;
		private var score : FlxText;
		// varibles para enemigos
		public var enemigos : FlxGroup;
		public var totalEnemigos : int;
		private var scoreE : FlxText;
		private var weapon : FlxWeapon;

		public function AreaDos() {
			super();
		}

		override public function create() : void {
			var s : FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
			add(s);
			astrid = new Astrid(3100, 70);

			piso = new FlxTilemap();
			pared = new FlxTilemap();
			fondos = new FlxTilemap();
			frente = new FlxTilemap();
			plataformas = new FlxTilemap();
			enredaderas = new FlxTilemap();
			picos = new FlxTilemap();
			puerta = new FlxTilemap();
			atras = new FlxTilemap();

			fondos.loadMap(new Assets.fondosCSV(), Assets.tilesfondos, 32, 32);
			pared.loadMap(new Assets.paredCSV(), Assets.tilespared, 32, 32);
			frente.loadMap(new Assets.frenteCSV(), Assets.tilesfrente, 32, 32);
			enredaderas.loadMap(new Assets.enredaderasCSV(), Assets.tilesenredadera, 12, 32);
			picos.loadMap(new Assets.picosCSV(), Assets.tilespicos, 32, 32);
			puerta.loadMap(new Assets.puertaCSV(), Assets.tilespuerta, 32, 32);
			piso.loadMap(new Assets.pisoCSV2(), Assets.tilespiso, 32, 32);
			plataformas.loadMap(new Assets.plataformasCSV(), Assets.tilesplataforma, 32, 32);
			atras.loadMap(new Assets.atrasCSV(), Assets.tilesatras, 32, 32);

			plataformas.setTileProperties(1, FlxObject.UP);
			plataformas.setTileProperties(2, FlxObject.UP);
			plataformas.setTileProperties(3, FlxObject.UP);
			plataformas.setTileProperties(4, FlxObject.UP);
			plataformas.setTileProperties(5, FlxObject.UP);
			plataformas.setTileProperties(6, FlxObject.UP);
			plataformas.setTileProperties(7, FlxObject.UP);
			plataformas.setTileProperties(8, FlxObject.UP);
			plataformas.setTileProperties(9, FlxObject.UP);

			// atributos del score items
			score = new FlxText(0, 0, 100);
			score.color = 0xffffffff;
			score.shadow = 0xff000000;
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;

			// atributos del scoreEnemigo
			scoreE = new FlxText(0, 15, 100);
			scoreE.color = 0xffffffff;
			scoreE.shadow = 0xff000000;
			scoreE.scrollFactor.x = 0;
			scoreE.scrollFactor.y = 0;

			add(atras);
			add(piso);
			add(pared);
			add(fondos);
			add(plataformas);
			add(enredaderas);
			add(picos);
			add(puerta);
			add(frente);
			add(astrid);
			weapon = new FlxWeapon("shuriken", astrid, "x", "y");
			weapon.makeImageBullet(50, Assets.Shuriken, 5,0,true,10,1);
			weapon.setBulletDirection(FlxWeapon.BULLET_LEFT,100);
			weapon.bounds.width=3200;
			weapon.bounds.height=1600;
			add(weapon.group);

			// inicializa el grupo de items, del mapa al grupo
			parseItems();
			// agrega items y el score,  conteo
			add(items);
			add(score);
			score.text = "0 / " + totalItems.toString();

			// inicializa el grupo de enemigos, del mapa al grupo
			parseEnemigos();
			// agrega items y el score,  conteo de enemigos
			add(enemigos);
			add(scoreE);
			scoreE.text = "0 / " + totalEnemigos.toString();

			// de la camara
			FlxG.camera.setBounds(0, 0, 3200, 1600, false);
			FlxG.worldBounds = new FlxRect(0, 0, 3200, 1600);
			FlxG.camera.follow(astrid);
			super.create();
		}

		private function parseItems() : void {
			var itemsMap : FlxTilemap = new FlxTilemap();

			itemsMap.loadMap(new Assets.itemsCSV(), Assets.itemsPNG, 10, 10);

			items = new FlxGroup();

			for (var ty : int = 0; ty < itemsMap.heightInTiles; ty++) {
				for (var tx : int = 0; tx < itemsMap.widthInTiles; tx++) {
					if (itemsMap.getTile(tx, ty) == 1) {
						items.add(new Items(tx, ty));
						totalItems++;
						trace(totalItems);
					}
				}
			}
			// trace("total de items: "+ totalItems);
		}

		private function parseEnemigos() : void {
			var enemigoMap : FlxTilemap = new FlxTilemap();

			enemigoMap.loadMap(new Assets.mapaBats2(), Assets.batSpriteSheet2, 24, 24);

			enemigos = new FlxGroup();

			for (var ty : int = 0; ty < enemigoMap.heightInTiles; ty++) {
				for (var tx : int = 0; tx < enemigoMap.widthInTiles; tx++) {
					if (enemigoMap.getTile(tx, ty) == 3) {
						enemigos.add(new Murcielago(tx, ty, astrid));
						totalEnemigos++;
						trace(totalEnemigos);
					}
				}
			}
		}

		override public function update() : void {
			if (FlxG.mouse.justPressed()) {
				weapon.fire();
			}
			astrid.acceleration.y = 450;

			if (astrid.overlaps(enredaderas)) {
				astrid.velocity.y = 0;
				astrid.acceleration.y = 0;

				if (FlxG.keys.pressed("DOWN") && !astrid.isTouching(FlxObject.FLOOR)) {
					astrid.play("enredadera");
					astrid.lado = "ab";
					astrid.velocity.y = 50;
					astrid.acceleration.y += astrid.drag.y;
				}
				if (FlxG.keys.pressed("UP")) {
					astrid.play("enredadera");
					astrid.lado = "ar";
					astrid.velocity.y = -50;
					astrid.acceleration.y -= astrid.drag.y;
				}
				if (FlxG.keys.pressed("SPACE")) {
					astrid.velocity.y = -astrid.maxVelocity.y;
					doubleJump = true;

					if (astrid.lado == "der") {
						astrid.play("brincader");
					}
					if (astrid.lado == "izq") {
						astrid.play("brincaizq");
					}
				}
			}
			if (FlxG.keys.justPressed("UP") && FlxG.collide(astrid, puerta)) {
				astrid.lado = "izq";
				FlxG.switchState(new AreaTres());
			}
			if (FlxG.collide(astrid, pared) && FlxG.keys.pressed("Z")) {
				astrid.velocity.y = -astrid.maxVelocity.y;
				if (astrid.velocity.y != 0 ) {
					if (astrid.lado == "izq") {
						astrid.play("caminader");
					}
					if (astrid.lado == "der") {
						astrid.play("caminaizq");
					}
				}
			}
			if (FlxG.collide(astrid, picos)) {
				astrid.kill();
			}
			super.update();
			FlxG.collide(astrid, piso);
			FlxG.collide(astrid, plataformas);
			FlxG.overlap(astrid, items, hitItems);
			// overlap enemigos
			FlxG.overlap(weapon.group, enemigos, hitEnemigos);
		}

		private function hitItems(p : FlxObject, item : FlxObject) : void {
			// trace("colapse");
			item.kill();
			FlxG.score += 1;
			score.text = FlxG.score.toString() + " / " + totalItems.toString();
		}

		private function hitEnemigos(p : FlxObject, enemigo : FlxObject) : void {
			// trace("colapse");
			enemigo.kill();
			FlxG.score += 1;
			scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
		}
	}
}
