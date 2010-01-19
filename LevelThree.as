/*
Frontline Copyright (C) 2010 Thomas Riga

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

Contact the author at thomasriga@gmail.com (http://www.thomasriga.com)
*/
class LevelThree extends BaseLevel {
	
	public function LevelThree() {
	}
	
	public function activate():Void {
		var depth:Number;
		this.active = true;
		this.backgr_s = "path3";
		this.cant_build_s = "cant_build3";
		this.target_x = 326;
		this.target_y = 20;
		this.minx = 40;
		this.miny = 0;
		this.maxx = _root.app.getWidth() - 30;
		this.maxy = 100;
		this.followPath = new Array();
		this.followPath[0] = new Array();
		this.followPath[1] = new Array();
		this.followPath[0][0] = 325;
		this.followPath[0][1] = 205;
		this.followPath[1][0] = 85;
		this.followPath[1][1] = 400;
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.backgr = _root.attachMovie(this.backgr_s, this.backgr_s + depth, depth);
		depth = _root.app.actors.getNextDepth(Type.type_Background);
		this.cant_build = _root.attachMovie(this.cant_build_s, this.cant_build_s + depth, depth);
		this.cant_build._alpha = 0;
		this.generateSweeps(5, 3);		
		this.currentSweep = -1;
	} 
}