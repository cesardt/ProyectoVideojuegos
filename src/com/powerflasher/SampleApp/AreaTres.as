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
		//mensajes
		private var hab : FlxText;

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
		private var puertasec : FlxTilemap;
		private var vida : FlxBar;
		private var vidas : FlxBar;
		private var vidaBrujo : FlxBar;
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
		private var savePoints : FlxGroup;

		public function AreaTres() {
			super();
		}

		override public function create() : void {
			var s : FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
			add(s);

			astrid = new Astrid(70, 4230);
			//astrid = new Astrid(900, 2900);

			boss = new BossArea3(818, 3030, astrid);
			
			//mensajes
			
			//habilidades mensaje
			hab = new FlxText(150, 20, 350);
			hab.color = 0xffffffff;
			hab.size=15;
			hab.shadow = 0xff000000;
			hab.scrollFactor.x = 0;
			hab.scrollFactor.y = 0;
			
			//mapa
			agua = new FlxTilemap();
			puerta = new FlxTilemap();
			piso = new FlxTilemap();
			cielo = new FlxTilemap();
			fondo = new FlxTilemap();
			plataforma = new FlxTilemap();
			invisible = new FlxTilemap();
			picosagua = new FlxTilemap();
			flotar = new FlxTilemap();
			puertasec = new FlxTilemap();
			flotar.loadMap(new Assets.flotar(), Assets.mapaPNG1, 32, 16);
			puerta.loadMap(new Assets.puerta3(), Assets.tilespuerta, 32, 32);
			picosagua.loadMap(new Assets.picos3(), Assets.picosagua, 16, 16);
			agua.loadMap(new Assets.aguaCSV(), Assets.tilesa3, 32, 32);
			piso.loadMap(new Assets.pisoCSV3(), Assets.tilesa3, 32, 32);
			cielo.loadMap(new Assets.cieloCSV(), Assets.tilessky, 32, 32);
			fondo.loadMap(new Assets.fondoCSV(), Assets.tilesa3, 32, 32);
			plataforma.loadMap(new Assets.plataformaCSV(), Assets.tilesa3, 32, 32);
			invisible.loadMap(new Assets.invisble3(), Assets.tilespuerta, 32, 32);
			puertasec.loadMap(new Assets.puertasec3(), Assets.tilespuerta, 32, 16);

			plataforma.setTileProperties(5, FlxObject.UP);
			plataforma.setTileProperties(6, FlxObject.UP);

			// atributos del score items
			score = new FlxText(0, 60, 100);
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
			add(boss);
			add(piso);
			add(puertasec);
			add(puerta);
			parseSaves();
			add(savePoints);
			add(astrid);
			add(picosagua);
			add(agua);

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

			vida = new FlxBar(610, 3);
			vida.setRange(0, 100);
			vida.scrollFactor.x = 0;
			vida.scrollFactor.y = 0;
			vida.createImageBar(Assets.barravida, Assets.barravida1);
			vida.currentValue = 100 - Inicio.health;
			add(vida);

			vidas = new FlxBar(530, 40, 1);
			vidas.setRange(0, 12);
			vidas.scrollFactor.x = 0;
			vidas.scrollFactor.y = 0;
			vidas.createImageBar(Assets.vidafull, Assets.vidaempty);
			vidas.currentValue = 12 - Inicio.vidas;
			add(vidas);

			vidaBrujo = new FlxBar(300, 3);
			vidaBrujo.setRange(0, 50);
			vidaBrujo.scrollFactor.x = 0;
			vidaBrujo.scrollFactor.y = 0;
			vidaBrujo.createImageBar(Assets.barravidabrujo, Assets.barravidabrujo1);
			vidaBrujo.currentValue = 0;
			
			add(hab);

			// inicializa el grupo de items, del mapa al grupo
			parseItems();
			// agrega items y el score,  conteo
			add(items);
			add(ejercito);
			// add(score);
			score.text = "0 / " + totalItems.toString();
			parseSoldados();

			// inicializa el grupo de enemigos, del mapa al grupo
			parseEnemigos();
			// agrega items y el score,  conteo de enemigos
			add(enemigos);
			// add(scoreE);
			scoreE.text = "0 / " + totalEnemigos.toString();
			add(soldados);
			// add(scoreS);
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
		
		private function parseSaves() : void {
			var saveMap : FlxTilemap = new FlxTilemap();

			saveMap.loadMap(new Assets.savesA3(), Assets.fogataSpriteSheet, 32, 32);

			savePoints = new FlxGroup();

			for (var ty : int = 0; ty < saveMap.heightInTiles; ty++) {
				for (var tx : int = 0; tx < saveMap.widthInTiles; tx++) {
					if (saveMap.getTile(tx, ty) == 1) {
						savePoints.add(new savePoint(tx * 32, ty * 32));
					}
				}
			}
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
			if(Inicio.vidas==0){
				FlxG.resetGame();
				Inicio.vidas=3;
				Inicio.health=100;
				Inicio.numitems=0;
				Inicio.soldados=0;
			}
			ejercito.text = "Ejército: " + Inicio.soldados.toString() + " soldados ";

			if (Inicio.numitems > 10) {
				puertasec.visible=true;
				if (FlxG.keys.justPressed("UP") && astrid.overlaps(puertasec)) {
					if(Inicio.soldados > 150){
					FlxG.switchState(new FinalState());
					Inicio.win=true;
					trace("Ganaste. Recuperaste a tu hermano");	
					}
					else{
						hab.text = "No tienes el número suficiente de soldados, consigue mínimo 150";
						hab.visible=true;
					}
				}
			}

			if (FlxG.keys.justPressed("Z") && astrid.facing == 1 && FlxG.keys.pressed("UP")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_NORTH_WEST, 300);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 0 && FlxG.keys.pressed("UP")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_NORTH_EAST, 300);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 0 && FlxG.keys.pressed("DOWN")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_SOUTH_EAST, 300);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 1 && FlxG.keys.pressed("DOWN")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_SOUTH_WEST, 300);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 1) {
				weapon.setBulletDirection(FlxWeapon.BULLET_LEFT, 400);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 0) {
				weapon.setBulletDirection(FlxWeapon.BULLET_RIGHT, 400);
				weapon.fire();
			}
			if (FlxG.collide(astrid, picosagua)) {
				astrid.kill();
			}
			
			if (FlxG.keys.justPressed("UP") && astrid.overlaps(puerta)) {
				FlxG.switchState(new AreaCuatro());
			}
			if (astrid.overlaps(agua)) {
				astrid.play("brincar");
				if (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("LEFT")) {
					astrid.play("brincar");
				}
				if (Inicio.numitems > 6) {
					if (FlxG.keys.justPressed("C")) {
						astrid.velocity.y = -astrid.maxVelocity.y / 3;
					}
				} else {
					FlxG.collide(astrid, flotar);
				}
			}

			if (vida.currentValue >= 100) {
				astrid.kill();
			}
			super.update();
			if (contador == 100) {
				weaponB.setBulletSpeed(100);
				var deltaX : int = astrid.x - boss.x;
				var deltaY : int = astrid.y - boss.y;

				var angle : int = Math.atan(deltaY / deltaX) * 180 / Math.PI;

				if (angle <= 90 && angle >= 80 ) {
					angle = angle * -1;
				}

				weaponB.setBulletDirection(angle, 100);
				// trace("dispara" + angle);
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
			FlxG.overlap(astrid, savePoints, saveStats);
			// overlap enemigos
			FlxG.overlap(astrid, enemigos, hitEnemigos);
			FlxG.overlap(astrid, soldados, hitEnemigos);
			FlxG.overlap(astrid, boss, hitEnemigos);
			// overlap bala enemigo
			FlxG.overlap(weapon.group, enemigos, hitBullet);
			FlxG.overlap(weapon.group, soldados, hitBullet);
			FlxG.overlap(weapon.group, boss, hitBullet);
			FlxG.overlap(weaponB.group, astrid, hitBullet);
		}

		private function hitItems(p : FlxObject, item : FlxObject) : void {
			hab.visible=true;
			
			item.kill();
			FlxG.score += 1;
			Inicio.numitems++;
			if (Inicio.numitems == 1) {
				hab.text = "Conseguiste la habilidad de doble salto";
			}
			else if (Inicio.numitems == 2) {
				hab.text = "Conseguiste la habilidad de correr, utilizala con 'X'";
			}
			else if (Inicio.numitems == 3) {
				hab.text = "Conseguiste la habilidad de escalar, utilizala con 'SPACE'";
			}
			else if (Inicio.numitems == 4 || Inicio.numitems == 7 || Inicio.numitems == 10 || (Inicio.numitems > 11 && Inicio.numitems % 2 != 0)) {
				Inicio.vidas++;
				vidas.currentValue = 12 - Inicio.vidas;
				hab.text = "Obtuviste una vida extra";
			}
			else if (Inicio.numitems == 5 || Inicio.numitems == 9 || (Inicio.numitems > 11 && Inicio.numitems % 2 == 0)) {
				Inicio.health += 20;
				astrid.health += 20;
				vida.currentValue -= 20;
				hab.text = "Conseguiste recuperar un poco de vida";
			}
			else if (Inicio.numitems == 6) {
				hab.text = "Conseguiste la habilidad de escalar enredaderas con arriba y abajo";
			}
			else if (Inicio.numitems == 8) {
				hab.text = "Conseguiste la habilidad de nadar, úsala con 'C'";
			}
			else if (Inicio.numitems == 11) {
				hab.text = "Desbloqueaste la puerta para llegar al imperio, encuentralà y consigue un gran nùmero de soldados apra rescatarlo";
			}
			score.text = FlxG.score.toString() + " / " + totalItems.toString();
		}

		private function hitEnemigos(p : FlxObject, enemigo : FlxObject) : void {
			hab.visible=false;

			// Vida de astrid
			if (enemigo == boss) {
				// Vida de astrid
				p.health -= 2;
				Inicio.health -= 2;
				// Barra de vida
				vida.currentValue += 2;
			} else {
				// Vida de astrid
				p.health -= 1;
				Inicio.health -= 1;
				// Barra de vida
				vida.currentValue += 1;
				FlxG.score += 1;
				scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}

		private function hitBullet(p : FlxObject, enemigo : FlxObject) : void {
			hab.visible=false;
		
			
			p.kill();
			if (enemigo == boss) {
				add(vidaBrujo);
				enemigo.health -= 2;
				// Barra de vida
				vidaBrujo.currentValue += 2;
				if (enemigo.health == 0) {
					enemigo.kill();
					vidaBrujo.kill();
					Inicio.soldados += 5;
				}
			} else if (enemigo == astrid) {
				enemigo.health -= 10;
				vida.currentValue += 10;
			} else {
				enemigo.kill();
				Inicio.soldados += 1;
				FlxG.score += 1;
				scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}
		
			private function saveStats(p : FlxObject, savePoint : FlxObject):void{
			Inicio.guardar(3);
			vida.currentValue = 100 - Inicio.health;
			trace("Juego Guardado");
		}
	}
}
