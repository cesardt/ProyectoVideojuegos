package com.powerflasher.SampleApp {
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import org.flixel.FlxText;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	// Imports para multiusuario
	import com.smartfoxserver.v2.SmartFox;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.requests.*;

	/**
	 * @author luis
	 */
	public class maxscore extends FlxState {
		private var max : Number = 0;
		private var user : String = "";
		private var sfs : SmartFox;
		private var maxsc : FlxText;

		public function maxscore() {
			super();
		}

		override public function create() : void {
			sfs = new SmartFox();
			sfs.loadConfig("sfs-config.xml", true);
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess);
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure);
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection);
			// sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost);
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, onExtensionResponse);
			
			
			sfs.addEventListener(SFSEvent.LOGIN, onLogin);
			sfs.addEventListener(SFSEvent.LOGIN_ERROR, onLoginError);

			sfs.addEventListener(SFSEvent.ROOM_JOIN, onJoin);
			sfs.addEventListener(SFSEvent.ROOM_JOIN_ERROR, onJoinError);

			var s : FlxSprite = new FlxSprite();
			// Boton back
			maxsc= new FlxText(FlxG.width / 2, FlxG.height / 2, 100, "MAXSCORE: ");
			
			//maxsc.text("MAXSCORE: " max);
			var startButton : FlxButton = new FlxButton(FlxG.width / 4 - 60, FlxG.height / 4 + 70, "Back", back);

			s.makeGraphic(FlxG.width, FlxG.height, 0x000000);
			// FlxG.bgColor = 0x00000000;
			add(s);
			add(maxsc);
			add(startButton);
			
		}

		private function back() : void {
			FlxG.switchState(new Inicio());
		}

		override public function update() : void {
			super.update();
		}

		private function onConnection(evt : SFSEvent) : void {
			if (evt.params.success) {
				trace("Estoy conectado");
				sfs.send(new LoginRequest("", "", "ITESM"));
			} else {
				trace(evt.params.errorMessage);
			}
		}

		private function onConfigLoadSuccess(evt : SFSEvent) : void {
			trace("La configuracion SI charcha");
			//trace("Server settings: " + sfs.config.host + ":" + sfs.config.port +sfs.config.zone);
		}

		private function onConfigLoadFailure(evt : SFSEvent) : void {
			trace("La configuracion NO charcha");
			//trace("Server settings: " + sfs.config.host + ":" + sfs.config.port +sfs.config.zone);
		}

		private function onExtensionResponse(evt : SFSEvent) : void {
			trace("Me han respondido");
			max = evt.params.params.getInt("maxscore");
			maxsc.text="MAXSCORE: " + max;
			trace("maxscore= ", max);
			//user= evt.params.get("user");
			
		}

		private function onLogin(evt : SFSEvent) : void {
			trace("si se pudo");
			var fedex:ISFSObject= SFSObject.newInstance();
			sfs.send(new ExtensionRequest("solicitud",fedex));
			sfs.send( new JoinRoomRequest("cuarto") );
//			trace("Estoy en un cuarto");
		}

		private function onLoginError(evt : SFSEvent) : void {
			trace("no se pudo");
			trace(evt.params.errorMessage);
		}

		private function onJoin(evt : SFSEvent) : void {
			trace("Estoy en un cuarto");
		}

		private function onJoinError(evt : SFSEvent) : void {
			trace("No se pudo entrar al cuarto");
		}
	}
}