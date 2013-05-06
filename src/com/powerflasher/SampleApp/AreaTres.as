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
		// bosses
		private var boss : BossArea3;
		private var agua : FlxTilemap;
		private var flotar : FlxTilemap;
		private var puerta : FlxTilemap;
		private var cielo : FlxTilemap;
		private var fondo : FlxTilemap;
		private var plataforma : FlxTilemap;
		private var picosagua : FlxTilemap;
		private var piso : FlxTilemap;
		private var weapon : FlxWeapon;
		private var weaponB : FlxWeapon;
		private var contador : int = 0;
		private var invisible : FlxTilemap;

		private var vida : FlxBar;
		// varibles para recoger items
		public var items : FlxGroup;
		public var totalItems : int;
		private var score : FlxText;
		private var ejercito : FlxText;
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

			//astrid = new Astrid(70, 4230);
			astrid = new Astrid(900, 2900);

			boss = new BossArea3(818, 3030, astrid);

			agua = new FlxTilemap();
			puerta = new FlxTilemap();
			piso = new FlxTilemap();
			cielo = new FlxTilemap();
			fondo = new FlxTilemap();
			plataforma = new FlxTilemap();
			invisible = new FlxTilemap();
			picosagua = new FlxTilemap();
			flotar = new FlxTilemap();
			flotar.loadMap(new Assets.flotar(), Assets.mapaPNG1, 32, 16);
			puerta.loadMap(new Assets.puerta3(), Assets.tilespuerta, 32, 16);
			picosagua.loadMap(new Assets.picos3(), Assets.picosagua, 16, 16);
			agua.loadMap(new Assets.aguaCSV(), Assets.tilesa3, 32, 32);
			piso.loadMap(new Assets.pisoCSV3(), Assets.tilesa3, 32, 32);
			cielo.loadMap(new Assets.cieloCSV(), Assets.tilessky, 32, 32);
			fondo.loadMap(new Assets.fondoCSV(), Assets.tilesa3, 32, 32);
			plataforma.loadMap(new Assets.plataformaCSV(), Assets.tilesa3, 32, 32);
			invisible.loadMap(new Assets.invisble3(), Assets.tilespuerta, 32, 32);

			plataforma.setTileProperties(5, FlxObject.UP);
			plataforma.setTileProperties(6, FlxObject.UP);

			// atributos del score items
			score = new FlxText(0,60, 100);
			score.color = 0xffffffff;
			score.shadow = 0xff000000;
			score.scrollFactor.x = 0;
			score.scrollFactor.y = 0;
			
			// atributos del score ejercito
			ejercito = new FlxText(0, 0, 100);
			ejercito.color = 0xffffffff;
			ejercito.shadow = 0xff000000;
			ejercito.scrollFactor.x = 0;
			ejercito.scrollFactor.y = 0;

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
			add(flotar);
			add(fondo);
			add(plataforma);
			add(astrid);
			add(boss);
			add(piso);
			add(picosagua);
			add(agua);
			add(puerta);

			weapon = new FlxWeapon("shuriken", astrid, "x", "y");
			weapon.makeImageBullet(50, Assets.Shuriken, astrid.origin.x, astrid.origin.y);
			weapon.bounds.width = 2592;
			weapon.bounds.height = 4800;
			add(weapon.group);

			weaponB = new FlxWeapon("shuriken", boss, "x", "y");
			weaponB.makeImageBullet(50, Assets.Shuriken);
			weaponB.setBulletDirection(FlxWeapon.BULLET_RIGHT, 100);
			weaponB.bounds.width = 2592;
			weaponB.bounds.height = 4800;

			add(weaponB.group);

			vida = new FlxBar(620, 3);
			vida.scrollFactor.x = 0;
			vida.scrollFactor.y = 0;
			// vida.setParent(astrid,"vida");
			vida.createImageBar(Assets.barravida, Assets.barravida1, 0x00AB00, 0xFF00FF00);
			vida.currentValue = 0;
			add(vida);
			// inicializa el grupo de items, del mapa al grupo
			parseItems();
			// agrega items y el score,  conteo
			add(items);
			add(ejercito);
			//add(score);
			score.text = "0 / " + totalItems.toString();
			parseSoldados();

			// inicializa el grupo de enemigos, del mapa al grupo
			parseEnemigos();
			// agrega items y el score,  conteo de enemigos
			add(enemigos);
			//add(scoreE);
			scoreE.text = "0 / " + totalEnemigos.toString();
			add(soldados);
			//add(scoreS);
			scoreS.text = "0 / " + totalSoldados.toString();

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
						// trace(totalItems);
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
						// trace(totalEnemigos);
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
						// trace(soldados.length);
					}
				}
			}
		}

		override public function update() : void {
			//trace(astrid.x);
			//trace(astrid.y);
			ejercito.text = "Ejército: " + Inicio.soldados.toString() + " soldados ";
			if (FlxG.keys.justPressed("Z") && astrid.facing == 1 && FlxG.keys.pressed("UP")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_NORTH_WEST, 200);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 0 && FlxG.keys.pressed("UP")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_NORTH_EAST, 200);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 0 && FlxG.keys.pressed("DOWN")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_SOUTH_EAST, 200);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 1 && FlxG.keys.pressed("DOWN")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_SOUTH_WEST, 200);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 1) {
				weapon.setBulletDirection(FlxWeapon.BULLET_LEFT, 300);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 0) {
				weapon.setBulletDirection(FlxWeapon.BULLET_RIGHT, 300);
				weapon.fire();
			}
			if(FlxG.collide(astrid,picosagua)){
				astrid.kill();
			}
			if (FlxG.keys.justPressed("UP") && astrid.overlaps(puerta)) {
				FlxG.switchState(new AreaUno());
			}
			if (astrid.overlaps(agua)) {
				astrid.play("brincar");
				if(FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("LEFT")){
					astrid.play("brincar");
				}
				if (Inicio.numitems > 6) {
					if (FlxG.keys.justPressed("X")) {
						astrid.velocity.y = -astrid.maxVelocity.y / 3;
					}
				} else {
					FlxG.collide(astrid, flotar);
				}
			}

			if (astrid.health == 0) {
				astrid.kill();
			}
			super.update();
			if (contador == 100) {
				weaponB.setBulletSpeed(100);
				var deltaX:int = astrid.x - boss.x;
				var deltaY:int = astrid.y - boss.y;
				
				var angle:int = Math.atan(deltaY / deltaX) * 180 / Math.PI;
				
				if(angle <= 90 && angle >= 80 ){
					angle = angle * -1;
				}
				
				weaponB.setBulletDirection(angle, 100);
				//trace("dispara" + angle);
				weaponB.fire();
				contador = 0;
			} else {
				contador++;
			}
			// trace(astrid.x, astrid.y);
			FlxG.collide(astrid, piso);
			FlxG.collide(boss, piso);
			FlxG.collide(boss, invisible);

			FlxG.collide(astrid, plataforma);
			FlxG.collide(soldados, piso);
			FlxG.collide(soldados, plataforma);
			FlxG.collide(soldados, invisible);
			FlxG.collide(weapon.group, piso);
			FlxG.collide(weaponB.group, piso);

			FlxG.overlap(astrid, items, hitItems);
			// overlap enemigos
			FlxG.overlap(astrid, enemigos, hitEnemigos);
			FlxG.overlap(astrid, soldados, hitEnemigos);
			FlxG.overlap(astrid, boss, hitEnemigos);
			// overlap bala enemigo
			FlxG.overlap(weapon.group, enemigos, hitBullet);
			FlxG.overlap(weapon.group, soldados, hitBullet);
			FlxG.overlap(weaponB.group,astrid,hitBullet);
		}

		private function hitItems(p : FlxObject, item : FlxObject) : void {
			// trace("colapse");
			item.kill();
			FlxG.score += 1;
			Inicio.numitems++;
			score.text = FlxG.score.toString() + " / " + totalItems.toString();
		}

		private function hitEnemigos(p : FlxObject, enemigo : FlxObject) : void {
			// trace("colapse");
			// Vida de astrid
			if (enemigo == boss) {
			// Vida de astrid
				p.health -= 2;
				// Barra de vida
				vida.currentValue += 2;
			} else {
				// Vida de astrid
				p.health -= 1;
				// Barra de vida
				vida.currentValue += 1;
				p.health -= 1;
				// Barra de vida
				vida.currentValue += 1;
				FlxG.score += 1;
				scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}

		private function hitBullet(p : FlxObject, enemigo : FlxObject) : void {
			p.kill();
			if (enemigo == boss) {
				// add(vidaBoss);
				enemigo.health -= 2;
				// Barra de vida
				// vidaBoss.currentValue += 2;
				if (enemigo.health == 0) {
					enemigo.kill();
					//vidaBoss.kill();
					Inicio.soldados+=5;
				}
			}
/*			else if (enemigo == soldados) {
					enemigo.kill();
					Inicio.soldados+=1;
				}*/
			else if(enemigo==astrid){
				enemigo.health=-10;
			}else{
				enemigo.kill();
				Inicio.soldados+=1;
				FlxG.score += 1;
				scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}
	}
}
