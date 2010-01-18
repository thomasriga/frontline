class LevelTwo extends BaseLevel {
	
	public function LevelTwo() {
	}
	
	public function activate():Void {
		var depth:Number;
		this.active = true;
		this.backgr_s = "path2";
		this.cant_build_s = "cant_build2";
		this.target_x = 326;
		this.target_y = 20;
		this.minx = 40;
		this.miny = 0;
		this.maxx = _root.app.getWidth() - 30;
		this.maxy = 100;
		this.followPath = new Array();
		this.followPath[0] = new Array();
		this.followPath[1] = new Array();
		this.followPath[2] = new Array();
		this.followPath[3] = new Array();
		this.followPath[4] = new Array();
		this.followPath[0][0] = 85;
		this.followPath[0][1] = 145;
		this.followPath[1][0] = 325;
		this.followPath[1][1] = 265;
		this.followPath[2][0] = 350;
		this.followPath[2][1] = 150;
		this.followPath[3][0] = 455;
		this.followPath[3][1] = 155;
		this.followPath[4][0] = 455;
		this.followPath[4][1] = 400;
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.backgr = _root.attachMovie(this.backgr_s, this.backgr_s + depth, depth);
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.cant_build = _root.attachMovie(this.cant_build_s, this.cant_build_s + depth, depth);
		this.cant_build._alpha = 0;
		this.generateSweeps(6, 2);		
		this.currentSweep = -1;
	} 
}