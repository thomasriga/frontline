class LevelFive extends BaseLevel {
	
	public function LevelFive() {
	}
	
	public function activate():Void {
		var depth:Number;
		this.active = true;
		this.backgr_s = "path5";
		this.cant_build_s = "cant_build5";
		this.minx = 40;
		this.miny = 0;
		this.maxx = _root.app.getWidth() - 30;
		this.maxy = 100;
		this.followPath = new Array();
		this.followPath[0] = new Array();
		this.followPath[1] = new Array();
		this.followPath[0][0] = 325;
		this.followPath[0][1] = 265;
		this.followPath[1][0] = 400;
		this.followPath[1][1] = 390;
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.backgr = _root.attachMovie(this.backgr_s, this.backgr_s + depth, depth);
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.cant_build = _root.attachMovie(this.cant_build_s, this.cant_build_s + depth, depth);
		this.cant_build._alpha = 0;
		this.generateSweeps(3, 5);		
		this.currentSweep = -1;
	} 
}