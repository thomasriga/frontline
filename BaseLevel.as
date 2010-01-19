/*
Frontline Copyright (C) 2010 Thomas Riga

This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

Contact the author at thomasriga@gmail.com (http://www.thomasriga.com)
*/
class BaseLevel implements Level {
	private var followPath:Array;
	private var monsterType:Array;
	private var currentSweep:Number;
	private var target_x:Number;
	private var target_y:Number;
	private var cant_build:MovieClip;
	private var backgr:MovieClip;
	private var cant_build_s:String;
	private var backgr_s:String;
	private var active:Boolean;
	private var minx:Number;
	private var miny:Number;
	private var maxx:Number;
	private var maxy:Number;
	
	public function getLead(id:Number, x:Number, y:Number):Array {
		var res:Array = new Array();
		res[2] = id;
		if((id < (this.followPath.length - 1)) and this.hasReached(id, x, y))
			res[2]++;
		//trace("id " + newId + " x " + this.followPath[newId][0] + " y " + this.followPath[newId][1]);
		res[0] = this.followPath[res[2]][0];
		res[1] = this.followPath[res[2]][1];
		return res;
	}

	public function hasReached(id:Number, x:Number, y:Number):Boolean {
		var dx:Number = this.followPath[id][0] - x;
		var dy:Number = this.followPath[id][1] - y;
		if(dx < 0)
			dx *= -1;
		if(dy < 0)
			dy *= -1;
		return ((dx < 10) and (dy < 10));
	}

	public function activate():Void {

	} 
	
	public function isActive():Boolean {
		return this.active;
	}
	
	public function disactivate():Void {
		this.cant_build.removeMovieClip();
		this.backgr.removeMovieClip();
		this.currentSweep = -1;
		this.active = false;
	}

	
	public function getMonsterType(id:Number):Number {
		if(this.currentSweep < 0)
			return this.monsterType[0][id];
		else 
			return this.monsterType[this.currentSweep][id];
	}
	
	public function hasSweep():Boolean {
		return (this.currentSweep < (this.monsterType.length - 1));
		//return (this.currentSweep < this.monsterType.length);
	}
	
	public function nextSweep():Number {
		this.currentSweep++;
		return this.monsterType[this.currentSweep].length;
	}
	
	public function resetSweep():Number {
		this.currentSweep = -1;
		return this.monsterType[0].length;
	}
	
	public function getCurrentSweep():Number {
		if(currentSweep < 0)
			return 0;
		else
			return this.currentSweep;
	}

	public function newMonsters():Array {
		var posx:Number;
		var posy:Number;
		var tmp:Number;
		var x:Number;
		var e:Number;
		var d:Number;
		var c:Number;
		var b:Boolean;
		var monsters:Array;
		if(hasSweep())
			tmp = nextSweep();
		else
			tmp = resetSweep();
		monsters = new Array();
		e = this.getCurrentSweep();
		d = int(_root.app.getWidth() / 2);
		posy = miny + 20;
		posx = d;
		b = true;
		c = 0;
		for(x in this.monsterType[e]) {
			c += 30;
			if(b) {
				b = false;
				posx += c;
				if(posx >= maxx) {
					posx = d;
					b = true;
					posy += 20;
					c = 0;
					if(posy >= maxy) {
						posy = miny + 20;
						
					}
				}
			}
			else {
				b = true;
				posx -= c;
				if(posx <= minx) {
					posx = d;
					b = true;
					posy += 20;
					c = 0;
					if(posy >= maxy)
						posy = miny + 20;
				}
			}
			if(this.monsterType[e][x] == Type.type_SlowSmallCar) {
				monsters[monsters.length] = 
					new SlowSmallCar(
								posx, 
								posy
								);
			}
			else if(this.monsterType[e][x] == Type.type_FastSmallCar) {
				monsters[monsters.length] = 
					new FastSmallCar(
								posx, 
								posy
								);
			}
			else if(this.monsterType[e][x] == Type.type_SlowBigCar) {
				monsters[monsters.length] = 
					new SlowBigCar(
								posx, 
								posy
								);
			}
			else if(this.monsterType[e][x] == Type.type_FastBigCar) {
				monsters[monsters.length] = 
					new FastBigCar(
								posx, 
								posy
								);
			}
			else if(this.monsterType[e][x] == Type.type_SlowSmallPlane) {
				monsters[monsters.length] = 
					new SlowSmallPlane(
								posx, 
								posy
								);
			}
			else if(this.monsterType[e][x] == Type.type_FastSmallPlane) {
				monsters[monsters.length] = 
					new FastSmallPlane(
								posx, 
								posy
								);
			}

			else if(this.monsterType[e][x] == Type.type_SlowBigPlane) {
				monsters[monsters.length] = 
					new SlowBigPlane(
								posx, 
								posy
								);
			}			
			else if(this.monsterType[e][x] == Type.type_FastBigPlane) {
				monsters[monsters.length] = 
					new FastBigPlane(
								posx, 
								posy
								);
			}		
		}
		return monsters;
	}
	
	public function isOnRoad(mousex:Number, mousey:Number, size:Number):Boolean {
		return (
				this.cant_build.hitTest(
									mousex, 
									mousey, 
									true
									) and
		   		this.cant_build.hitTest(
									mousex - size, 
									mousey - size, 
									true
									) and
		   		this.cant_build.hitTest(
									mousex + size, 
									mousey - size, 
									true
									) and
		   		this.cant_build.hitTest(
									mousex + size, 
									mousey + size, 
									true
									) and
				this.cant_build.hitTest(
									mousex - size, 
									mousey + size, 
									true
									)
		   );
	}
	
	
	public function canBuild(mouse_x:Number, mouse_y:Number, size:Number):Boolean {
		return (
				(not this.cant_build.hitTest(mouse_x, mouse_y, true)) and
				(not this.cant_build.hitTest(mouse_x + size, mouse_y, true)) and
				(not this.cant_build.hitTest(mouse_x + size, mouse_y + size, true)) and
				(not this.cant_build.hitTest(mouse_x, mouse_y + size, true))
				);

	}
	
	public function generateSweeps(size:Number, difficulty:Number):Void {
		var x:Number = -1;
		var y:Number;
		var c:Number;
		var e:Number = Type.type_SlowSmallCar;
		
		this.monsterType = new Array();
		while(++x < size) { 
			this.monsterType[x] = new Array();
			y = -1;
			c = (difficulty * 2) + x;
			while(++y < c) {
				this.monsterType[x][y] = e;
				e++;
				if(e == (Type.type_FastBigPlane - (3 - difficulty)))
					e = Type.type_SlowSmallCar + (difficulty - 1);
					
			}
		}
	}	
}