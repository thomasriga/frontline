class SlowBigPlane extends BaseMonster {
	
	public function SlowBigPlane(x:Number, y:Number) {		
		var depth:Number;

		this.life = 2000;
		this.speedMultiplier = 1.0;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "simple_plane", 
									 "minion" + depth, 
									 depth,
									 {_x: x, _y: y, _width:40,_height:40}
									 );
		this.setup(x, y);
	}
	
	public function isFlying():Boolean {		
		return true;
	}
}