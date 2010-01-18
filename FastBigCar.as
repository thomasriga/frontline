class FastBigCar extends BaseMonster {
	
	public function FastBigCar(x:Number, y:Number) {		
		var depth:Number;

		this.speedMultiplier = 2.0;
		this.life = 300;
		depth = _root.app.actors.getNextDepth(this.getCategory());
		this.min = _root.attachMovie(
									 "minion", 
									 "minion"+depth, 
									depth,
									 {_x: x, _y: y, _width: 20, _height: 30}
									 );
		this.setup(x, y);
	}
}