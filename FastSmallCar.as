class FastSmallCar extends BaseMonster {
	
	public function FastSmallCar(x:Number, y:Number) {		
		var depth:Number;

		this.speedMultiplier = 2.0;
		this.life = 100;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "minion", 
									 "minion"+depth, 
									depth,
									 {_x: x, _y: y, _width: 10, _height: 15}
									 );
		this.setup(x, y);
	}
}