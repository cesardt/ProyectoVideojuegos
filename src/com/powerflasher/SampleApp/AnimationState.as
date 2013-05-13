 package 
com.powerflasher.SampleApp{
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import flash.display.MovieClip;
   
    public class AnimationState extends FlxState
    {
        [Embed(source="Intro.swf")]private static var Animacion:Class;
    
        private var animacion:MovieClip;
		private var count:Number =0;
        
        override public function create():void {
            animacion = new Animacion();
        
            
        FlxG.stage.addChildAt(animacion, 1);    
        
           
        }
		public override function update():void {
			super.update();
			count++;
			if (count > 1218) {
					FlxG.switchState(new AreaUno());	
					FlxG.stage.removeChildAt(1);
			}
		}
        
        

        
    }
}