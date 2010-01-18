interface Monster {
	public function isAlive():Boolean; 
   	public function action():Void;
	public function destroy():Void;
	public function addDamage(damage:Number):Number;
	public function getX():Number;
	public function getY():Number;
	public function doHitTest(mouse_x:Number,mouse_y:Number, flagB:Boolean):Boolean; 
}