class SlowSmallPlane extends BaseMonster {
	
	public function SlowSmallPlane(x:Number, y:Number) {		
		var depth:Number;

		this.life = 100;
		this.speedMultiplier = 1.0;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "simple_plane", 
									 "minion"+depth, 
									depth,
									 {_x: x, _y: y, _width:20,_height:20}
									 );
		this.setup(x, y);
	}
	
	public function isFlying():Boolean {		
		return true;
	}
}