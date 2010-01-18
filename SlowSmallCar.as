class SlowSmallCar extends BaseMonster {
	
	public function SlowSmallCar(x:Number, y:Number) {		
		var depth:Number;
		this.speedMultiplier = 1.0;
		this.life = 200;
		
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "tank", 
									 "minion"+depth, 
									 depth,
									 {_x: x, _y: y, _width:10,_height:15}
									 );
		setup(x, y);
	}
}