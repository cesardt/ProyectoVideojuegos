package com.powerflasher.SampleApp {
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxWeapon;
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
		private var weapon : FlxWeapon;
			private var vida : FlxBar;

	// varibles para recoger items
		public var items : FlxGroup;
		public var totalItems : int;
		private var score : FlxText;
		// varibles para enemigos
		public var enemigos : FlxGroup;
		public var totalEnemigos : int;
		private var scoreE : FlxText;
		
		public var soldados : FlxGroup;
		public var totalSoldados : int;
		private var scoreS : FlxText;

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
			piso.loadMap(new Assets.pisoCSV3(), Assets.tilesa3, 32, 32);
			cielo.loadMap(new Assets.cieloCSV(), Assets.tilessky, 32, 32);
			fondo.loadMap(new Assets.fondoCSV(), Assets.tilesa3, 32, 32);
			plataforma.loadMap(new Assets.plataformaCSV(), Assets.tilesa3, 32, 32);

			plataforma.setTileProperties(5, FlxObject.UP);
			plataforma.setTileProperties(6, FlxObject.UP);
			
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
			
			// atributos del scoreSoldados
			scoreS = new FlxText(0, 25, 100);
			scoreS.color = 0xffffffff;
			scoreS.shadow = 0xff000000;
			scoreS.scrollFactor.x = 0;
			scoreS.scrollFactor.y = 0;

			add(cielo);
			add(fondo);
			add(plataforma);
			add(astrid);
			add(agua);
			add(piso);
			weapon = new FlxWeapon("shuriken", astrid, "x", "y");
			weapon.makeImageBullet(50, Assets.Shuriken);
			weapon.setBulletDirection(FlxWeapon.BULLET_RIGHT, 200);
			weapon.bounds.width=2592;
			weapon.bounds.height=4800;
			add(weapon.group);
			
			vida = new FlxBar(620, 3);
			vida.scrollFactor.x = 0;
			vida.scrollFactor.y = 0;
			//vida.setParent(astrid,"vida");
			vida.createImageBar(Assets.barravida, Assets.barravida1,0x00AB00,0xFF00FF00);
			vida.currentValue=0;
			add(vida);
			// inicializa el grupo de items, del mapa al grupo
			parseItems();
			// agrega items y el score,  conteo
			add(items);
			add(score);
			score.text = "0 / " + totalItems.toString();
			parseSoldados();
			
			// inicializa el grupo de enemigos, del mapa al grupo
			parseEnemigos();
			// agrega items y el score,  conteo de enemigos
			//add(enemigos);
			add(scoreE);
			scoreE.text = "0 / " + totalEnemigos.toString();
			add(soldados);
			add(scoreS);
			scoreS.text="0 / " + totalSoldados.toString();

			// de la camara
			FlxG.camera.setBounds(0, 2496, 2592, 4800, false);
			FlxG.worldBounds = new FlxRect(0, 2496, 2592, 4800);
			FlxG.camera.follow(astrid);
			super.create();
		}

private function parseItems() : void {
			var itemsMap : FlxTilemap = new FlxTilemap();

			itemsMap.loadMap(new Assets.items3(), Assets.itemsPNG, 10, 10);

			items = new FlxGroup();

			for (var ty : int = 0; ty < itemsMap.heightInTiles; ty++) {
				for (var tx : int = 0; tx < itemsMap.widthInTiles; tx++) {
					if (itemsMap.getTile(tx, ty) == 1) {
						items.add(new Items(tx, ty));
						totalItems++;
						//trace(totalItems);
					}
				}
			}
			// trace("total de items: "+ totalItems);
		}

		private function parseEnemigos() : void {
			var enemigoMap : FlxTilemap = new FlxTilemap();

			enemigoMap.loadMap(new Assets.murcielagos3(), Assets.batSpriteSheet2, 24, 24);

			enemigos = new FlxGroup();

			for (var ty : int = 0; ty < enemigoMap.heightInTiles; ty++) {
				for (var tx : int = 0; tx < enemigoMap.widthInTiles; tx++) {
					if (enemigoMap.getTile(tx, ty) == 3) {
						enemigos.add(new Murcielago(tx, ty, astrid));
						totalEnemigos++;
						//trace(totalEnemigos);
					}
				}
			}
		}

	private function parseSoldados() : void {
			var soldadoMap : FlxTilemap = new FlxTilemap();

			soldadoMap.loadMap(new Assets.soldados3(), Assets.soldado, 24, 36);

			soldados = new FlxGroup();

			for (var ty : int = 0; ty < soldadoMap.heightInTiles; ty++) {
				for (var tx : int = 0; tx < soldadoMap.widthInTiles; tx++) {
					if (soldadoMap.getTile(tx, ty) == 1) {
						soldados.add(new soldado(tx, ty, astrid));
						totalSoldados++;
						trace(soldados.length);
						
					}
				}
			}
		}


		override public function update() : void {
			if (FlxG.mouse.justPressed()) {
				weapon.fire();
			}
			if (astrid.overlaps(agua)) {
				if (astrid.lado == "der") {
					astrid.play("brincader");
				}
				else if (astrid.lado == "izq") {
					astrid.play("brincaizq");
				}
			}
			if(vida.currentValue==100){
				astrid.kill();
			}
			super.update();
			FlxG.collide(astrid, piso);
			FlxG.collide(astrid, plataforma);
			FlxG.collide(soldados,piso);
			FlxG.collide(soldados,plataforma);
			FlxG.overlap(astrid, items, hitItems);
			// overlap enemigos
			FlxG.overlap(astrid, enemigos, hitEnemigos);
			FlxG.overlap(astrid, soldados, hitEnemigos);
			//overlap bala enemigo
			FlxG.overlap(weapon.group, enemigos, hitBullet);
			FlxG.overlap(weapon.group, soldados, hitBullet);
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
			//Vida de astrid
			p.health-=1;
			//Barra de vida
			vida.currentValue+=1;
			FlxG.score += 1;
			scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
		}
		
		private function hitBullet(p : FlxObject, enemigo : FlxObject) : void {
			// trace("colapse");
			p.kill();
			enemigo.kill();
			FlxG.score += 1;
			scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
		}
	}
}
