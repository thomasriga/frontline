class FastBigPlane extends BaseMonster {
	
	public function FastBigPlane(x:Number, y:Number) {		
		var depth:Number;

		this.life = 1200;
		this.speedMultiplier = 1.5;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "simple_plane_red", 
									 "minion"+depth, 
									depth,
									 {_x: x, _y: y, _width:40,_height:40}
									 );
		this.setup(x, y);
	}
	
	public function isFlying():Boolean {		
		return true;
	}
}