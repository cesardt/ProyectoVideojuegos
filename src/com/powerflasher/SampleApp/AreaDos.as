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
		//astrid
		private var astrid : Astrid;
		// boss
		private var boss :BossArea2;
		//mapa
		private var piso : FlxTilemap;
		private var picos : FlxTilemap;
		private var frente : FlxTilemap;
		private var enredaderas : FlxTilemap;
		private var fondos : FlxTilemap;
		private var pared : FlxTilemap;
		private var plataformas : FlxTilemap;
		private var puerta : FlxTilemap;
		private var atras : FlxTilemap;
		//private var invisible: FlxTilemap;
		private var invisible: FlxTilemap;
		//propiedad
		private var doubleJump : Boolean;
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
		//arma
		private var weapon : FlxWeapon;
		//vida
		private var vida : FlxBar;

		public function AreaDos() {
			super();
		}

		override public function create() : void {
			var s : FlxSprite = new FlxSprite();
			s.makeGraphic(FlxG.width, FlxG.height, 0x9345Da);
			add(s);
			//crear a astrid
			astrid = new Astrid(3100,70);
			//bosses

			boss = new BossArea2(3100,1450, astrid);
			
			//crear mapa
			piso = new FlxTilemap();
			pared = new FlxTilemap();
			fondos = new FlxTilemap();
			frente = new FlxTilemap();
			plataformas = new FlxTilemap();
			enredaderas = new FlxTilemap();
			picos = new FlxTilemap();
			puerta = new FlxTilemap();
			atras = new FlxTilemap();
			//invisible= new FlxTilemap();

			//invisible= new FlxTilemap();
			//invisible.visible=false;
			
			//cargar mapa
			fondos.loadMap(new Assets.fondosCSV(), Assets.tilesfondos, 32, 32);
			pared.loadMap(new Assets.paredCSV(), Assets.tilespared, 32, 32);
			frente.loadMap(new Assets.frenteCSV(), Assets.tilesfrente, 32, 32);
			enredaderas.loadMap(new Assets.enredaderasCSV(), Assets.tilesenredadera, 12, 32);
			picos.loadMap(new Assets.picosCSV(), Assets.tilespicos, 32, 32);
			puerta.loadMap(new Assets.puertaCSV(), Assets.tilespuerta, 32, 32);
			piso.loadMap(new Assets.pisoCSV2(), Assets.tilespiso, 32, 32);
			plataformas.loadMap(new Assets.plataformasCSV(), Assets.tilesplataforma, 32, 32);
			atras.loadMap(new Assets.atrasCSV(), Assets.tilesatras, 32, 32);
			//invisible.loadMap(new Assets.invisble2(), Assets.tilespuerta, 32, 32);
			
			
			//Propiedades de las plataformas
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
			
			// atributos del scoreSoldados
			scoreS = new FlxText(0, 25, 100);
			scoreS.color = 0xffffffff;
			scoreS.shadow = 0xff000000;
			scoreS.scrollFactor.x = 0;
			scoreS.scrollFactor.y = 0;
			//Añadir el mapa, boss y astrid
			add(atras);
			add(piso);
			add(pared);
			add(fondos);
			add(plataformas);
			add(enredaderas);
			add(picos);
			add(puerta);
			//add(invisible);
			add(frente);
			add(astrid);
			add(boss);
			
			//Añadirle arma a astrid
			weapon = new FlxWeapon("shuriken", astrid, "x", "y");
			weapon.makeImageBullet(200, Assets.Shuriken, 0,15,true,10,1);
			weapon.setBulletDirection(FlxWeapon.BULLET_LEFT,200);
			weapon.bounds.width=3200;
			weapon.bounds.height=1600;
			add(weapon.group);
			
			//Añadirle barra de vida a astrid
			vida = new FlxBar(610, 3);
			vida.scrollFactor.x = 0;
			vida.scrollFactor.y = 0;
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
			add(enemigos);
			add(scoreE);
			scoreE.text = "0 / " + totalEnemigos.toString();
			add(soldados);
			add(scoreS);
			scoreS.text="0 / " + totalSoldados.toString();
			
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
						//trace(totalItems);
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
						//trace(totalEnemigos);
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
						//trace(soldados.length);
						
					}
				}
			}
		}

		override public function update() : void {
			if (FlxG.keys.justPressed("Z") && astrid.facing==1 && FlxG.keys.pressed("UP")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_NORTH_WEST, 200);
				weapon.fire();
			}
			else if (FlxG.keys.justPressed("Z") && astrid.facing==0 && FlxG.keys.pressed("UP")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_NORTH_EAST, 200);
				weapon.fire();
			}
			else if (FlxG.keys.justPressed("Z") && astrid.facing==0 && FlxG.keys.pressed("DOWN")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_SOUTH_EAST, 200);
				weapon.fire();
			}
			else if (FlxG.keys.justPressed("Z") && astrid.facing==1 && FlxG.keys.pressed("DOWN")) {
				weapon.setBulletDirection(FlxWeapon.BULLET_SOUTH_WEST, 200);
				weapon.fire();
			}
			else if (FlxG.keys.justPressed("Z") && astrid.facing==1) {
				weapon.setBulletDirection(FlxWeapon.BULLET_LEFT, 200);
				weapon.fire();
			}
			else if (FlxG.keys.justPressed("Z") && astrid.facing==0) {
				weapon.setBulletDirection(FlxWeapon.BULLET_RIGHT, 200);
				weapon.fire();
			}
			
			astrid.acceleration.y = 450;

			if (astrid.overlaps(enredaderas)) {
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
			if (FlxG.keys.justPressed("UP") && FlxG.collide(puerta,astrid)) {
				FlxG.switchState(new AreaTres());
			}
			/*if (FlxG.collide(astrid, pared) && FlxG.keys.pressed("Z")) {
				astrid.velocity.y = -astrid.maxVelocity.y;
				if (astrid.velocity.y != 0 ) {
					astrid.play("caminar");
				}
			}*/
			if (FlxG.collide(astrid, picos)) {
				astrid.kill();
			}
			if(astrid.health==0){
				astrid.kill();
			}
			super.update();
			//trace(astrid.x+" , "+astrid.y);
			FlxG.collide(astrid, piso);
			FlxG.collide(astrid, plataformas);
			FlxG.collide(astrid, pared);
			FlxG.collide(soldados,piso);
			FlxG.collide(soldados,plataformas);
			FlxG.collide(soldados, enredaderas);
			FlxG.collide(soldados, pared);
			//FlxG.collide(soldados, invisible);
			FlxG.collide(boss,piso);
			//overlap items
			FlxG.overlap(astrid, items, hitItems);
			// overlap enemigos
			FlxG.overlap(astrid, enemigos, hitEnemigos);
			FlxG.overlap(astrid, soldados, hitEnemigos);
			FlxG.overlap(astrid, boss, hitEnemigos);
			
			//overlap bala enemigo
			FlxG.overlap(weapon.group, enemigos, hitBullet);
			FlxG.overlap(weapon.group, soldados, hitBullet);
			FlxG.overlap(weapon.group, boss, hitBullet);
			
		}

		private function hitItems(p : FlxObject, item : FlxObject) : void {
			// trace("colapse");
			item.kill();
			FlxG.score += 1;
			score.text = FlxG.score.toString() + " / " + totalItems.toString();
		}
		private function hitEnemigos(p : FlxObject, enemigo : FlxObject) : void {
			// trace("colapse");
			//Vida de astrid
			if (enemigo == boss) {
				// Vida de astrid
				p.health -= 3;
				// Barra de vida
				vida.currentValue += 3;
			} else {
				// Vida de astrid
				p.health -= 1;
				// Barra de vida
				vida.currentValue += 1;
			p.health-=1;
			//Barra de vida
			vida.currentValue+=1;
			FlxG.score += 1;
			scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}
		
		private function hitBullet(p : FlxObject, enemigo : FlxObject) : void {
				p.kill();
				if(enemigo==boss){
				//add(vidaBoss);
				enemigo.health-=2;
				// Barra de vida
				//vidaBoss.currentValue += 2;
				
				if(enemigo.health==0){
					enemigo.kill();
				}
			}
			else{
			enemigo.kill();
			FlxG.score += 1;
			scoreE.text = FlxG.score.toString() + " / " + totalEnemigos.toString();
			}
		}
		
	}
}
