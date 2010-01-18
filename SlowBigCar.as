class SlowBigCar extends BaseMonster {
	
	public function SlowBigCar(x:Number, y:Number) {		
		var depth:Number;

		this.speedMultiplier = 1.0;
		this.life = 2000;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "tank", 
									 "minion"+depth, 
									 depth,
									 {_x: x, _y: y, _width:20,_height:30}
									 );
		this.setup(x, y);
	}
}