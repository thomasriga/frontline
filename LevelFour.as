﻿class LevelFour extends BaseLevel {
	
	public function LevelFour() {
	}
	
	public function activate():Void {
		var depth:Number;
		this.active = true;
		this.backgr_s = "path4";
		this.cant_build_s = "cant_build4";
		this.minx = 40;
		this.miny = 0;
		this.maxx = _root.app.getWidth() - 30;
		this.maxy = 100;
		this.followPath = new Array();
		this.followPath[0] = new Array();
		this.followPath[1] = new Array();
		this.followPath[0][0] = 265;
		this.followPath[0][1] = 400;
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.backgr = _root.attachMovie(this.backgr_s, this.backgr_s + depth, depth);
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.cant_build = _root.attachMovie(this.cant_build_s, this.cant_build_s + depth, depth);
		this.cant_build._alpha = 0;
		this.generateSweeps(4, 4);		
		this.currentSweep = -1;
	} 
}