interface Tower {
	public function doHitTest(mouse_x:Number,mouse_y:Number, flagB:Boolean):Boolean; 
   	public function action():Void;
    public function activateRange(enable:Boolean):Void;
	public function destroy():Void;
	public function getWidth():Number;
	public function getHeight():Number;
}