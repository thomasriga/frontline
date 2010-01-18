class FastSmallPlane extends BaseMonster {
	
	public function FastSmallPlane(x:Number, y:Number) {		
		var depth:Number;

		this.life = 50;
		this.speedMultiplier = 1.5;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "simple_plane_red", 
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