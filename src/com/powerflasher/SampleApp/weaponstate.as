package com.powerflasher.SampleApp {
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	/**
	 * @author Mau
	 */
	public class weaponstate extends FlxState {
		var weaponGroup : FlxGroup;
		var weapon : arma;

		public function ProjectileState() {
			weaponGroup = new FlxGroup();
			for (var i : int = 0; i < 10; i++) {
				weapon = new arma();
				weaponGroup.add(weapon);
			}

			add(weaponGroup);
		}

		override public function update() : void {
			super.update();

			if (FlxG.mouse.justPressed()) {
				trace("lolz", FlxG.mouse.x, FlxG.mouse.y);
				weapon = weaponGroup.getFirstAvailable() as arma;
				weapon.x = FlxG.mouse.x;
				weapon.y = FlxG.mouse.y;
				weapon.exists = true;
				weapon.visible = true;
			}
		}
	}
}