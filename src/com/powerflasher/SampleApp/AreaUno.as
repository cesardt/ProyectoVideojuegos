package com.powerflasher.SampleApp {
	import org.flixel.FlxSave;

	import flashx.textLayout.formats.Direction;

	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxEmitter;
	import org.flixel.plugin.photonstorm.FlxWeapon;
	import org.Assets;

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
		private var texto : FlxText;
		private var astrid : Astrid;
		// bosses
		private var robot : BossRobot;
		private var brujo : Brujo;
		private var mapaPrincipal : FlxTilemap;
		private var agua : FlxTilemap;
		private var platagua : FlxTilemap;
		private var flotar : FlxTilemap;
		private var picosagua : FlxTilemap;
		private var barras : FlxTilemap;
		private var mapa4 : FlxTilemap;
		private var mapa5 : FlxTilemap;
		private var puerta : FlxTilemap;
		private var item : FlxTile;
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
		private var level : AreaUno;
		// public var enemies : FlxGroup;
		private var weapon : FlxWeapon;
		private var vida : FlxBar;
		private var vidas : FlxBar;
		private var vidaBoss : FlxBar;
		private var vidaBrujo : FlxBar;
		// Para guardar
		private var Saver : FlxSave;

		public function AreaUno() {
			super();
		}

		override public function create() : void {
			var s : FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
			add(s);
			Saver = new FlxSave();
			// crear a astrid
			astrid = new Astrid(150, 530);
			// bosses
			robot = new BossRobot(180, 780, astrid);
			brujo = new Brujo(1680, 188, astrid);
			// Mapa
			mapaPrincipal = new FlxTilemap();
			agua = new FlxTilemap();
			picosagua = new FlxTilemap();
			platagua = new FlxTilemap();
			flotar = new FlxTilemap();
			mapa4 = new FlxTilemap();
			mapa5 = new FlxTilemap();
			puerta = new FlxTilemap();
			item = new FlxTile(barras, 2, 10, 10, true, 1);
			// Cargar MApa
			mapa5.loadMap(new Assets.mapaCSV4(), Assets.fondo, 31, 28);
			picosagua.loadMap(new Assets.picos1(), Assets.picosagua, 16, 16);
			platagua.loadMap(new Assets.platagua(), Assets.mapaPNG2, 31, 14);
			flotar.loadMap(new Assets.mapaflotar(), Assets.mapaPNG1, 31, 14);
			mapaPrincipal.loadMap(new Assets.mapaCSV(), Assets.mapaPNG, 31, 28);
			agua.loadMap(new Assets.mapaCSV1(), Assets.mapaPNG1, 31, 28);
			mapa4.loadMap(new Assets.mapaCSV3(), Assets.mapaPNG2, 31, 14);
			puerta.loadMap(new Assets.mapaCSV5(), Assets.puertaPNG, 31, 14);
			// Propiedades Tiles
			mapa4.setTileProperties(1, FlxObject.UP);
			agua.setTileProperties(5, FlxObject.UP);

			// atributos del score
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

			add(flotar);
			add(mapa5);
			add(picosagua);
			add(mapa4);
			add(puerta);
			add(mapaPrincipal);
			add(astrid);
			add(robot);
			add(brujo);
			add(agua);
			add(platagua);
			Inicio.numitems=0;
			// añadir arma a astrid
			weapon = new FlxWeapon("shuriken", astrid, "x", "y");
			weapon.makeImageBullet(50, Assets.Shuriken, astrid.origin.x, astrid.origin.y);
			weapon.bounds.width = 2670;
			weapon.bounds.height = 992;
			add(weapon.group);

			// inicializa el grupo de items, del mapa al grupo
			parseItems();
			// inicializa el grupo de enemigos, del mapa al grupo
			parseEnemigos();
			parseSoldados();
			// agrega items y el score,  conteo de enemigos
			add(enemigos);
			add(soldados);
			add(scoreE);

			add(soldados);
			add(scoreS);
			scoreE.text = "0 / " + totalEnemigos.toString();
			scoreS.text = "0 / " + totalSoldados.toString();
			// agrega items y el score,  conteo
			add(items);
			add(score);
			score.text = "0 / " + totalItems.toString();

			// barra de vida de astrid
			vida = new FlxBar(620, 3);
			vida.scrollFactor.x = 0;
			vida.scrollFactor.y = 0;
			vida.createImageBar(Assets.barravida, Assets.barravida1, 0x00AB00, 0xFF00FF00);
			vida.currentValue = 0;
			add(vida);
			
			vidas = new FlxBar(530, 40);
			vidas.scrollFactor.x = 0;
			vidas.scrollFactor.y = 0;
			vidas.createImageBar(Assets.vidafull, Assets.vidaempty);
			vidas.currentValue = 0;
			add(vidas);

			// barra vida bosses
			vidaBoss = new FlxBar(300, 3, 2, 100, 10, null, "", 0, 30);
			vidaBoss.scrollFactor.x = 0;
			vidaBoss.scrollFactor.y = 0;
			vidaBoss.createImageBar(Assets.barravidaboss, Assets.barravidaboss1);
			vidaBoss.currentValue = 0;

			vidaBrujo = new FlxBar(300, 3, 2, 100, 10, null, "", 0, 50);
			vidaBrujo.scrollFactor.x = 0;
			vidaBrujo.scrollFactor.y = 0;
			vidaBrujo.createImageBar(Assets.barravidabrujo, Assets.barravidabrujo1);
			vidaBrujo.currentValue = 0;

			// Prpiedades de la camara
			FlxG.camera.setBounds(0, 0, 2670, 992, false);
			FlxG.worldBounds = new FlxRect(0, 0, 2670, 992);
			mapaPrincipal.follow();
			FlxG.camera.follow(astrid);
			super.create();
		}

		private function parseItems() : void {
			var itemsMap : FlxTilemap = new FlxTilemap();

			itemsMap.loadMap(new Assets.mapaCSV2(), Assets.itemsPNG, 10, 10);

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
			// ("total de items: "+ totalItems);
		}

		private function parseEnemigos() : void {
			var enemigoMap : FlxTilemap = new FlxTilemap();

			enemigoMap.loadMap(new Assets.mapaBats1(), Assets.batSpriteSheet1, 24, 24);

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

			soldadoMap.loadMap(new Assets.soldados(), Assets.soldado, 24, 36);

			soldados = new FlxGroup();

			for (var ty : int = 0; ty < soldadoMap.heightInTiles; ty++) {
				for (var tx : int = 0; tx < soldadoMap.widthInTiles; tx++) {
					if (soldadoMap.getTile(tx, ty) == 1) {
						soldados.add(new soldado(tx, ty, astrid));
						totalSoldados++;
						trace(soldados);
					}
				}
			}
		}

		override public function update() : void {
			trace(Inicio.numitems);
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
				weapon.setBulletDirection(FlxWeapon.BULLET_LEFT, 200);
				weapon.fire();
			} else if (FlxG.keys.justPressed("Z") && astrid.facing == 0) {
				weapon.setBulletDirection(FlxWeapon.BULLET_RIGHT, 200);
				weapon.fire();
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
			if (astrid.overlaps(picosagua)) {
				astrid.kill();
			}

			if (FlxG.keys.justPressed("UP") && astrid.overlaps(puerta)) {
				FlxG.switchState(new AreaDos());
			}

			if (astrid.health == 0) {
				astrid.kill();
			}
			robot.acceleration.y = 600;
			super.update();

			// collides mapa
			FlxG.collide(astrid, mapaPrincipal);
			FlxG.collide(astrid, mapa4);
			FlxG.collide(astrid, platagua);
			/*if (FlxG.collide(astrid, flotar)) {
			astrid.play("brincar");
			}*/
			FlxG.collide(soldados, mapaPrincipal);
			FlxG.collide(soldados, mapa4);
			FlxG.collide(robot, mapaPrincipal);
			FlxG.collide(brujo, mapaPrincipal);
			FlxG.overlap(astrid, items, hitItems);
			// overlap enemigos
			FlxG.overlap(astrid, enemigos, hitEnemigos);
			FlxG.overlap(astrid, soldados, hitEnemigos);
			FlxG.overlap(astrid, robot, hitEnemigos);
			FlxG.overlap(astrid, brujo, hitEnemigos);
			// overlap bala enemigo
			FlxG.overlap(weapon.group, enemigos, hitBullet);
			FlxG.overlap(weapon.group, soldados, hitBullet);
			FlxG.overlap(weapon.group, robot, hitBullet);
			FlxG.overlap(weapon.group, brujo, hitBullet);
		}

		private function hitItems(p : FlxObject, item : FlxObject) : void {
			// trace("colapse");
			item.kill();
			FlxG.score += 1;
			Inicio.numitems++;
			score.text = FlxG.score.toString() + " / " + totalItems.toString();
		}

		private function hitEnemigos(p : FlxSprite, enemigo : FlxObject) : void {
			FlxSave(Saver);
			// trace("colapse");
			/*if (enemigo.alive) {
			var emitter : FlxEmitter = new FlxEmitter();
			// emitter.makeParticles(Assets.Shuriken, 4);
			emitter.gravity = 400;
			emitter.at(enemigo);
			add(emitter);
			emitter.start();
			}*/
			if (enemigo == robot) {
				// Vida de astrid
				p.health -= 3;
				// Barra de vida
				vida.currentValue += 3;
			}
			if (enemigo == brujo) {
				// Vida de astrid
				p.health -= 5;
				// Barra de vida
				vida.currentValue += 3;
			} else {
				// Vida de astrid
				p.health -= 1;
				// Barra de vida
				vida.currentValue += 1;
			}

			FlxG.score += 1;
			scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
		}

		private function hitBullet(p : FlxObject, enemigo : FlxObject) : void {
			Saver.bind("guardar");
			p.kill();
			if (enemigo == robot) {
				add(vidaBoss);
				enemigo.health -= 2;
				// Barra de vida
				vidaBoss.currentValue += 2;

				if (enemigo.health == 0) {
					enemigo.kill();
					vidaBoss.kill();
					
				}
			} else if (enemigo == brujo) {
				add(vidaBrujo);
				enemigo.health -= 2;
				// Barra de vida
				vidaBrujo.currentValue += 2;

				if (enemigo.health == 0) {
					enemigo.kill();
					vidaBrujo.kill();
				}
			} else {
				enemigo.kill();
				FlxG.score += 1;
				scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}
	}
}
