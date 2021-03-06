package com.powerflasher.SampleApp {
	import org.flixel.plugin.photonstorm.FlxBar;
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
		private var hab : FlxText;
		// astrid
		private var astrid : Astrid;
		// boss
		private var boss : BossArea2;
		// mapa
		private var piso : FlxTilemap;
		private var picos : FlxTilemap;
		private var frente : FlxTilemap;
		private var enredaderas : FlxTilemap;
		private var fondos : FlxTilemap;
		private var pared : FlxTilemap;
		private var plataformas : FlxTilemap;
		private var puertasec : FlxTilemap;
		private var puerta : FlxTilemap;
		private var atras : FlxTilemap;
		// private var invisible: FlxTilemap;
		private var invisible : FlxTilemap;
		// propiedad
		private var doubleJump : Boolean;
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
		// arma
		private var weapon : FlxWeapon;
		// vida
		private var vida : FlxBar;
		private var vidas:FlxBar;
		private var vidaBrujo : FlxBar;
		private var savePoints : FlxGroup;

		public function AreaDos() {
			super();
		}

		override public function create() : void {
			var s : FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
			add(s);
			// crear a astrid
			astrid = new Astrid(3100, 70);
			// bosses

			boss = new BossArea2(3100, 1450, astrid);
			//mensajes
			
			//habilidades mensaje
			hab = new FlxText(150, 20, 350);
			hab.color = 0xffffffff;
			hab.size=15;
			hab.shadow = 0xff000000;
			hab.scrollFactor.x = 0;
			hab.scrollFactor.y = 0;
	
			// crear mapa
			piso = new FlxTilemap();
			pared = new FlxTilemap();
			fondos = new FlxTilemap();
			frente = new FlxTilemap();
			plataformas = new FlxTilemap();
			enredaderas = new FlxTilemap();
			picos = new FlxTilemap();
			puerta = new FlxTilemap();
			atras = new FlxTilemap();
			puertasec = new FlxTilemap();
			// invisible= new FlxTilemap();

			// invisible= new FlxTilemap();
			// invisible.visible=false;

			// cargar mapa
			fondos.loadMap(new Assets.fondosCSV(), Assets.tilesfondos, 32, 32);
			pared.loadMap(new Assets.paredCSV(), Assets.tilespared, 32, 32);
			frente.loadMap(new Assets.frenteCSV(), Assets.tilesfrente, 32, 32);
			enredaderas.loadMap(new Assets.enredaderasCSV(), Assets.tilesenredadera, 12, 32);
			picos.loadMap(new Assets.picosCSV(), Assets.tilespicos, 32, 32);
			puerta.loadMap(new Assets.puertaCSV(), Assets.tilespuerta, 32, 32);
			piso.loadMap(new Assets.pisoCSV2(), Assets.tilespiso, 32, 32);
			plataformas.loadMap(new Assets.plataformasCSV(), Assets.tilesplataforma, 32, 32);
			atras.loadMap(new Assets.atrasCSV(), Assets.tilesatras, 32, 32);
			puertasec.loadMap(new Assets.puertasec2(), Assets.tilespuerta, 32, 32);
			// invisible.loadMap(new Assets.invisble2(), Assets.tilespuerta, 32, 32);

			// Propiedades de las plataformas
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

			// Ejercito
			ejercito = new FlxText(0, 0, 120);
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
			// Añadir el mapa, boss y astrid
			add(atras);
			add(piso);
			add(pared);
			add(fondos);
			add(plataformas);
			add(enredaderas);
			add(picos);
			add(puerta);
			parseSaves();
			add(savePoints);
			// add(invisible);
			add(frente);
			add(puertasec);
			add(astrid);
			add(boss);
			

			// Añadirle arma a astrid
			weapon = new FlxWeapon("shuriken", astrid, "x", "y");
			weapon.makeImageBullet(50, Assets.Shuriken, astrid.origin.x, astrid.origin.y);
			weapon.setBulletDirection(FlxWeapon.BULLET_LEFT, 200);
			weapon.bounds.width = 3200;
			weapon.bounds.height = 1600;
			add(weapon.group);

			// Añadirle barra de vida a astrid

			// inicializa el grupo de items, del mapa al grupo
			parseItems();
			// agrega items y el score,  conteo
			add(items);
			// add(score);
			add(ejercito);
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

			vida = new FlxBar(610, 3);
			vida.scrollFactor.x = 0;
			vida.scrollFactor.y = 0;
			vida.createImageBar(Assets.barravida, Assets.barravida1, 0x00AB00, 0xFF00FF00);
			vida.currentValue =100- Inicio.health;
			add(vida);
			
			vidas = new FlxBar(530, 40,1);
			vidas.setRange(0, 12);
			vidas.scrollFactor.x = 0;
			vidas.scrollFactor.y = 0;
			vidas.createImageBar(Assets.vidafull, Assets.vidaempty);
			vidas.currentValue =12-Inicio.vidas;
			add(vidas);
			
			vidaBrujo = new FlxBar(300, 3);
			vidaBrujo.setRange(0, 50);
			vidaBrujo.scrollFactor.x = 0;
			vidaBrujo.scrollFactor.y = 0;
			vidaBrujo.createImageBar(Assets.barravidabrujo, Assets.barravidabrujo1);
			vidaBrujo.currentValue = 0;
			
			add(hab);


			// Propiedades de la camara
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
						// trace(totalItems);
					}
				}
			}
			// trace("total de items: "+ totalItems);
		}
		
		private function parseSaves() : void {
			var saveMap : FlxTilemap = new FlxTilemap();

			saveMap.loadMap(new Assets.savesA2(), Assets.fogataSpriteSheet, 32, 32);

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

			enemigoMap.loadMap(new Assets.mapaBats2(), Assets.batSpriteSheet2, 24, 24);

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

			soldadoMap.loadMap(new Assets.soldados2(), Assets.soldado, 24, 36);

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

			astrid.acceleration.y = 450;
			if (Inicio.numitems < 6) {
				FlxG.collide(astrid, enredaderas);
			}
			if (astrid.overlaps(enredaderas) && Inicio.numitems > 5) {
				astrid.velocity.y = 0;
				astrid.acceleration.y = 0;

				if (FlxG.keys.pressed("DOWN") && !astrid.isTouching(FlxObject.FLOOR)) {
					astrid.play("enredadera");
					astrid.velocity.y = 50;
					astrid.acceleration.y += astrid.drag.y;
				}
				if (FlxG.keys.pressed("UP")) {
					astrid.play("enredadera");
					astrid.velocity.y = -50;
					astrid.acceleration.y -= astrid.drag.y;
				}
				if (FlxG.keys.pressed("SPACE")) {
					astrid.velocity.y = -astrid.maxVelocity.y;
					doubleJump = true;
					astrid.play("brincar");
				}
			}
			
			
			if (FlxG.keys.justPressed("UP") && astrid.overlaps(puerta)) {
				FlxG.switchState(new AreaTres());
			}
			if (FlxG.collide(astrid, picos)) {
				astrid.kill();
			}
			if (vida.currentValue >=100) {
				astrid.kill();
			}
			super.update();
			// trace(astrid.x+" , "+astrid.y);
			FlxG.collide(astrid, piso);
			FlxG.collide(astrid, plataformas);
			FlxG.collide(astrid, pared);
			FlxG.collide(soldados, piso);
			FlxG.collide(soldados, plataformas);
			FlxG.collide(soldados, enredaderas);
			FlxG.collide(soldados, pared);
			// FlxG.collide(soldados, invisible);
			FlxG.collide(boss, piso);
			// overlap items
			FlxG.overlap(astrid, items, hitItems);
			FlxG.overlap(astrid, savePoints, saveStats);
			// overlap enemigos
			FlxG.overlap(astrid, enemigos, hitEnemigos);
			FlxG.overlap(astrid, soldados, hitEnemigos);
			FlxG.overlap(astrid, boss, hitEnemigos);
			FlxG.collide(weapon.group, piso);
			FlxG.collide(weapon.group, plataformas);

			// overlap bala enemigo
			FlxG.overlap(weapon.group, enemigos, hitBullet);
			FlxG.overlap(weapon.group, soldados, hitBullet);
			FlxG.overlap(weapon.group, boss, hitBullet);
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
				p.health -= 3;
				Inicio.health-=3;
				// Barra de vida
				vida.currentValue += 3;
			} else {
				// Vida de astrid
				p.health -= 1;
				Inicio.health-=1;
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
			}

			 else {
				enemigo.kill();
				Inicio.soldados += 1;
				FlxG.score += 1;
				scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}
		
			private function saveStats(p : FlxObject, savePoint : FlxObject):void{
			Inicio.guardar(2);
			vida.currentValue = 100 - Inicio.health;
			trace("Juego Guardado");
		}
	}
}
