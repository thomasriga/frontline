interface Level {	
	public function getMonsterType(id:Number):Number;
	public function hasSweep():Boolean;
	public function nextSweep():Number;
	public function resetSweep():Number;
	public function getCurrentSweep():Number;
	public function activate():Void;
	public function disactivate():Void;
	public function isOnRoad(mousex:Number, mousey:Number, size:Number):Boolean;
	public function getLead(id:Number, x:Number, y:Number):Array;
	public function hasReached(id:Number, x:Number, y:Number):Boolean;
}