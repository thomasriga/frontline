class LevelOne extends BaseLevel {
	
	public function LevelOne() {
	}
	
	public function activate():Void {
		var depth:Number;
		this.active = true;
		this.backgr_s = "path1";
		this.cant_build_s = "cant_build1";
		this.target_x = 326;
		this.target_y = 20;
		this.minx = 40;
		this.miny = 0;
		this.maxx = _root.app.getWidth() - 20;
		this.maxy = 100;
		this.followPath = new Array();
		this.followPath[0] = new Array();
		this.followPath[1] = new Array();
		this.followPath[2] = new Array();
		this.followPath[0][0] = 255;
		this.followPath[0][1] = 285;
		this.followPath[1][0] = 435;
		this.followPath[1][1] = 345;
		this.followPath[2][0] = 95;
		this.followPath[2][1] = 400;
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.backgr = _root.attachMovie(this.backgr_s, this.backgr_s + depth, depth);
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.cant_build = _root.attachMovie(this.cant_build_s, this.cant_build_s + depth, depth);
		this.cant_build._alpha = 0;
		this.generateSweeps(7, 1);		
		this.currentSweep = -1;
	} 
}